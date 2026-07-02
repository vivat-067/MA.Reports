program MedAnalyticsReportsApp;

uses
  Vcl.Forms,
  marMainForm in 'Views\marMainForm.pas' {frmMain},
  marBrigadeReport in 'Views\marBrigadeReport.pas' {fraBrigadeReport: TFrame},
  marUtils in 'Helpers\marUtils.pas',
  marMainController in 'Classes\marMainController.pas',
  marDBConnectionService in 'Services\marDBConnectionService.pas',
  marDatabaseDM in 'Services\marDatabaseDM.pas' {dmDB: TDataModule},
  marBrigadeReportController in 'Classes\marBrigadeReportController.pas',
  marBrigadeReportFilter in 'Models\marBrigadeReportFilter.pas',
  marExportGridToExcel in 'Helpers\marExportGridToExcel.pas',
  marConverters in 'Helpers\marConverters.pas',
  marResourcesDM in 'Resources\marResourcesDM.pas' {dmResources: TDataModule},
  marAppVersionInfo in 'Helpers\marAppVersionInfo.pas',
  MedAnalyticsReportsApp.dxSettings in 'MedAnalyticsReportsApp.dxSettings.pas',
  marFilterStorageService in 'Services\marFilterStorageService.pas',
  marSettingsEditor in 'Views\marSettingsEditor.pas' {frmSettingsEditor},
  marDatabaseSettings in 'Models\marDatabaseSettings.pas',
  marSettingsStorageService in 'Services\marSettingsStorageService.pas',
  marSettingsEditorController in 'Classes\marSettingsEditorController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'МедАналитика: Отчеты';
  Application.CreateForm(TdmDB, dmDB);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmResources, dmResources);
  Application.CreateForm(TfrmSettingsEditor, frmSettingsEditor);
  Application.Run;
end.
