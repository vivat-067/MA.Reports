unit marBrigadeReportController;

interface

uses
  System.SysUtils, System.Classes, System.IOUtils, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Error, FireDAC.DApt, Vcl.Dialogs, marBrigadeReportFilter,
  marUtils;

const
  cReportSQLTemplate = 'T_BrigadeReport.sql';

type
  TBrigadeReportController = class
  private
    FQuery: TFDQuery;
    FDataSource: TDataSource;
    FFilter: TBrigadeReportFilter;
    FErrorStr: string;
    procedure PrepareSQL;
  public
    function GenerateReport(AFilter: TBrigadeReportFilter): Boolean;
    property ErrorStr: string read FErrorStr;

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
    begin
      case FFilter.EmployeeRole of
        erDoctor:
          FQuery.ParamByName('pEmpRoleId').AsInteger := 4;
        erParamedic:
          FQuery.ParamByName('pEmpRoleId').AsInteger := 5;
        erDriver:
          FQuery.ParamByName('pEmpRoleId').AsInteger := 6;
      end;
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

