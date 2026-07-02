unit marBrigadeReport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  dxUIAClasses, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxGroupBox, dxLayoutContainer, cxClasses, dxLayoutControl,  System.IOUtils,
  dxLayoutcxEditAdapters, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid, dxLayoutControlAdapters, System.StrUtils,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, cxMRUEdit, marBrigadeReportController,
  System.Actions, Vcl.ActnList, FireDAC.Comp.Client,cxCurrencyEdit,
  dxGDIPlusClasses,
  marResourcesDM,
  marBrigadeReportFilter,
  marFilterStorageService;

const
    cReportName = 'Отчет по сотрудникам бригады';
    cFiletrConfigFileName = 'ReportFiterSettings.json';

    cColor_DoctorBg    = $00CCFFFF; // Желтый
    cColor_ParamedicBg = $00FFF0E0; // Голубой
    cColor_DriverBg    = $00E0E0FF; // Розовый

type
  TfraBrigadeReport = class(TFrame)
    dxLayoutControl1: TdxLayoutControl;
    dxLayoutControl1Group_Root: TdxLayoutGroup;
    lgFilter: TdxLayoutGroup;
    lgReport: TdxLayoutGroup;
    dePeriodStart: TcxDateEdit;
    liPeriodStart: TdxLayoutItem;
    liPeriodEnd: TdxLayoutItem;
    dePeriodEnd: TcxDateEdit;
    cmbEmloyeeRole: TcxComboBox;
    liEmployeeType: TdxLayoutItem;
    liReportGrid: TdxLayoutItem;
    grReport: TcxGrid;
    gvReport: TcxGridDBTableView;
    clFIO: TcxGridDBColumn;
    gclWorkTime: TcxGridDBColumn;
    gclN: TcxGridDBColumn;
    gclEmpRoleName: TcxGridDBColumn;
    gclCallTime: TcxGridDBColumn;
    gclCallTimeHrs: TcxGridDBColumn;
    gclInsuranceCallsCount: TcxGridDBColumn;
    gclPrivateCallsCount: TcxGridDBColumn;
    gclRevenue: TcxGridDBColumn;
    glReport: TcxGridLevel;
    btnGenerate: TcxButton;
    liGenerate: TdxLayoutItem;
    btnExport: TcxButton;
    liExport: TdxLayoutItem;
    edEmployeeName: TcxMRUEdit;
    liEmployeeName: TdxLayoutItem;
    ActionList1: TActionList;
    acGenerateReport: TAction;
    acExportReport: TAction;
    gclEmpRoleID: TcxGridDBColumn;
    liFilterBlock: TdxLayoutLabeledItem;
    gvEmpID: TcxGridDBColumn;
    procedure acGenerateReportExecute(Sender: TObject);
    procedure acGenerateReportUpdate(Sender: TObject);
    procedure acExportReportExecute(Sender: TObject);
    procedure acExportReportUpdate(Sender: TObject);
    procedure gvReportCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure edEmployeeNamePropertiesButtonClick(Sender: TObject);
    procedure gclNGetDataText(Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure ConvertTimeToHHMM(Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure gclCallTimeHrsGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
  private
    { Private declarations }
    FReportController: TBrigadeReportController;
    FReportFilter: TBrigadeReportFilter;

    procedure GetFilter;
    procedure SetFilter;
    function GetReportFilterPath:string;

    procedure FillEmpRoleCombo;

  public
    { Public declarations }
    function ReportName: string;

    procedure Init(AConnection: TFDConnection);
    procedure Done;

    destructor Destroy; override;
  end;

implementation


{$R *.dfm}

uses
  marExportGridToExcel, marConverters, marUtils;


resourcestring
  rsWaitPlease = 'Идёт подготовка отчёта. Это может занять некоторое время...';
  rsNoData = 'Нет данных для отображения. Задайте параметры отчета и нажмите кнопку "Сформировать"...';

{ TfraBrigadeReport }

procedure TfraBrigadeReport.Init(AConnection: TFDConnection);
begin

  FReportController := TBrigadeReportController.Create(AConnection);
  FReportFilter := TBrigadeReportFilter.Create;

  TFilterStorageService.LoadFromFile(GetReportFilterPath, FReportFilter);

  gvReport.OptionsView.NoDataToDisplayInfoText := rsNoData;
  gvReport.DataController.DataSource := FReportController.DataSource;

  FillEmpRoleCombo;
  SetFilter;

end;

procedure TfraBrigadeReport.Done;
begin
  if FReportFilter <> nil then
  begin
    GetFilter;
    TFilterStorageService.SaveToFile(GetReportFilterPath, FReportFilter);
  end;
end;


destructor TfraBrigadeReport.Destroy;
begin
  FreeAndNil(FReportFilter);
  FreeAndNil(FReportController);

  inherited;
end;


function TfraBrigadeReport.ReportName: string;
begin
  Result := cReportName;
end;

procedure TfraBrigadeReport.acGenerateReportExecute(Sender: TObject);
var
  ErrorMsg: string;
begin

  GetFilter;

  if not FReportFilter.IsValid(ErrorMsg) then
  begin
    ShowMessage(ErrorMsg);
    Exit;
  end;

     grReport.LockedStateImageOptions.Text := rsWaitPlease;
     grReport.LockedStateImageOptions.ShowText := True;

//      gvReport.BeginUpdate(lsimImmediate);
//      try
//        if not FReportController.GenerateReport(FReportFilter) then
//          ShowMessage(FReportController.ErrorStr);
//      finally
//        gvReport.EndUpdate;
//      end;

    gvReport.BeginUpdate(lsimImmediate);

    FReportController.GenerateReportAsync(FReportFilter,
                      procedure(Success: Boolean)
                      begin
                        gvReport.EndUpdate;
                        if not Success then
                          ShowMessage(FReportController.ErrorStr);
                      end
    );

end;

procedure TfraBrigadeReport.acGenerateReportUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (dePeriodStart.Date > 0) and (dePeriodEnd.Date > 0)
                                  and not FReportController.IsLoading;
end;

procedure TfraBrigadeReport.acExportReportExecute(Sender: TObject);
begin

  var exportFolderName := GetAppConfigPath('Export');
  var exportFileName := Format('%s %s.xlsx', [FormatDateTime('yymmdd_hhnn', Now), cReportName]);

  TGridExcelExporter.Export(grReport, exportFileName, exportFolderName);
end;

procedure TfraBrigadeReport.acExportReportUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (gvReport.DataController.RecordCount > 0)
                                 and not FReportController.IsLoading;
end;

procedure TfraBrigadeReport.edEmployeeNamePropertiesButtonClick(Sender: TObject);
begin
  ShowMessage('Форма выбора сотрудника из списка.')
end;


{$REGION 'Тип (роль) сотрудника'}
procedure TfraBrigadeReport.FillEmpRoleCombo;
begin
  cmbEmloyeeRole.Properties.Items.Clear;

  for var roleName in cEmployeeRoleNames do
     cmbEmloyeeRole.Properties.Items.Add(roleName);
end;


// Колонка N п/п
procedure TfraBrigadeReport.gclNGetDataText(Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  AText := IntToStr(ARecordIndex + 1);
end;

//hh,hh
procedure TfraBrigadeReport.gclCallTimeHrsGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
end;


//HH:MM
procedure TfraBrigadeReport.ConvertTimeToHHMM(Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
var
  rawHours: Double;
begin
  rawHours := XVarToDouble(gvReport.DataController.Values[ARecordIndex, Sender.Index], 0);
  AText := XFormatTime(RawHours);
end;


{$REGION 'Фильтр'}
procedure TfraBrigadeReport.GetFilter;
begin
  with FReportFilter do
  begin
    PeriodStart := dePeriodStart.Date;
    PeriodEnd := dePeriodEnd.Date;
    EmployeeName := edEmployeeName.Text;
    EmployeeRole := TEmployeeRole(cmbEmloyeeRole.ItemIndex);
  end;
end;

function TfraBrigadeReport.GetReportFilterPath: string;
begin
   Result := TPath.Combine(ExtractFilePath(ParamStr(0)), cFiletrConfigFileName);
end;

procedure TfraBrigadeReport.SetFilter;
begin
  with FReportFilter do
  begin
    dePeriodStart.Date := PeriodStart;
    dePeriodEnd.Date := PeriodEnd;
    edEmployeeName.Text := EmployeeName;
    cmbEmloyeeRole.ItemIndex := Ord(FReportFilter.EmployeeRole)
  end;
end;
{$ENDREGION}


//----   Условное форматирование -----
procedure TfraBrigadeReport.gvReportCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  //По роли сотрудника (gclEmpRoleID)
  if not AViewInfo.GridRecord.Selected then
    case XVarToInt(AViewInfo.GridRecord.Values[gclEmpRoleID.Index], -1) of
      cRoleID_Doctor:    ACanvas.Brush.Color := cColor_DoctorBg;
      cRoleID_Paramedic: ACanvas.Brush.Color := cColor_ParamedicBg;
      cRoleID_Driver:    ACanvas.Brush.Color := cColor_DriverBg;
    end;

  //По значению "Время на вызовах" (gclCallTimeHrs)
 if XVarToDouble(AViewInfo.GridRecord.Values[gclCallTimeHrs.Index]) <= 0 then
    ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];

end;

end.

