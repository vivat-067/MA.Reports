unit marBrigadeReportController;

interface

uses
  System.SysUtils, System.Classes, System.IOUtils, Data.DB,  System.Threading,
  FireDAC.Comp.Client, FireDAC.Stan.Option,  FireDAC.Stan.Intf, FireDAC.Stan.Error, FireDAC.DApt,
  Vcl.Dialogs,
  marBrigadeReportFilter,  marUtils;

const
  cReportSQLTemplate = 'T_BrigadeReport.sql';

  cRoleID_Doctor    = 4;
  cRoleID_Paramedic = 5;
  cRoleID_Driver    = 6;

type
  TBrigadeReportController = class
  private
    FQuery: TFDQuery;
    FDataSource: TDataSource;
    FFilter: TBrigadeReportFilter;
    FErrorStr: string;
    FisLoading:boolean;
    procedure PrepareSQL;
  public
    property ErrorStr: string read FErrorStr;
    property IsLoading: Boolean read FIsLoading;

    function GenerateReport(AFilter: TBrigadeReportFilter): Boolean;
    procedure GenerateReportAsync(AFilter: TBrigadeReportFilter; AOnComplete: TProc<Boolean>);

    property DataSource: TDataSource read FDataSource;

    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;
  end;

implementation

resourcestring
  rsGenerateError = 'Не удалось сформировать отчет. Ошибка: ';
  rsSQLTemplateLoadingError =  'Не удалось загрузить файл шаблона SQL запроса: ';

constructor TBrigadeReportController.Create(AConnection: TFDConnection);
begin
  inherited Create;

  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := AConnection;
  FQuery.Active := false;

  FDataSource := TDataSource.Create(nil);
  FDataSource.DataSet := FQuery;

  FErrorStr := '';
  FIsLoading := False;
end;

destructor TBrigadeReportController.Destroy;
begin
  FDataSource.Free;
  FQuery.Free;

  inherited;
end;

function TBrigadeReportController.GenerateReport(AFilter: TBrigadeReportFilter): Boolean;
begin

  Result := False;
  FErrorStr := '';

  if AFilter = nil then
    Exit;

  FFilter := AFilter;

  FQuery.DisableControls;
  try
    FQuery.Close;
    PrepareSQL;
    try
      FQuery.Open;
      Result := true;
    except
      on E: Exception do
      begin
        FErrorStr := rsGenerateError + E.Message;
        Result := False;
      end;
    end;
  finally
    FQuery.EnableControls;
  end;
end;


procedure TBrigadeReportController.GenerateReportAsync(AFilter: TBrigadeReportFilter; AOnComplete: TProc<Boolean>);
begin
  if (AFilter = nil) or FIsLoading then
  begin
    if Assigned(AOnComplete) then AOnComplete(False);
    Exit;
  end;
  FErrorStr := '';
  FIsLoading := True;
  FFilter := AFilter;
  //FireDAC в неблокирующий режим для работы с фоновым потоком
  FQuery.ResourceOptions.CmdExecMode := amNonBlocking;
  FQuery.DisableControls;
  FQuery.Close;
  try
    PrepareSQL;
  except
    on E: Exception do
    begin
      FErrorStr := E.Message;
      FQuery.EnableControls;
      FIsLoading := False;
      if Assigned(AOnComplete) then AOnComplete(False);
      Exit;
    end;
  end;
  TTask.Run(
    procedure
    var
      Success: Boolean;
    begin
      Success := False;
      try
        FQuery.Open; // Фоновое выполнение запроса
        Success := True;
      except
        on E: Exception do
           FErrorStr := rsGenerateError + E.Message;
      end;
      TThread.Synchronize(nil,
        procedure
        begin
          FQuery.EnableControls;
          FIsLoading := False;
          if Assigned(AOnComplete) then
             AOnComplete(Success);
         end
      );
    end
  );

end;

procedure TBrigadeReportController.PrepareSQL;
begin
  var TemplatePath := GetAppConfigPath(TPath.Combine('Templates', cReportSQLTemplate));

  FQuery.SQL.Clear;

  try
    FQuery.SQL.LoadFromFile(TemplatePath);
  except
    on E: Exception do
    begin
      raise Exception.Create(rsSQLTemplateLoadingError + E.Message);
    end;
  end;

   //Дата
   FQuery.ParamByName('pStart').AsDate := FFilter.PeriodStart;
   FQuery.ParamByName('pEnd').AsDate := FFilter.PeriodEnd;

    //Тип (роль)
    if FFilter.EmployeeRole <> erAll then
       case FFilter.EmployeeRole of
          erDoctor:     FQuery.ParamByName('pEmpRoleId').AsInteger := cRoleID_Doctor;
          erParamedic:  FQuery.ParamByName('pEmpRoleId').AsInteger := cRoleID_Paramedic;
          erDriver:     FQuery.ParamByName('pEmpRoleId').AsInteger := cRoleID_Driver;
        end
    else
      FQuery.ParamByName('pEmpRoleId').Clear;


    //Фамилия
    var employeeName := FFilter.EmployeeName.Trim;
    if not employeeName.IsEmpty then
      FQuery.ParamByName('pName').AsString := employeeName
    else
      FQuery.ParamByName('pName').Clear;

end;

end.

