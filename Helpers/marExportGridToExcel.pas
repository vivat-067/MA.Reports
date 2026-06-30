unit marExportGridToExcel;

interface

uses
  Vcl.Dialogs, cxGridExportLink, cxGrid;

type

  TGridExcelExporter = class
  public
   class procedure Export(AGrid: TcxGrid; const ADefaultFileName: string = '';
                                          const ADefaultFolder: string = '');
  end;

implementation


class procedure TGridExcelExporter.Export(AGrid: TcxGrid; const ADefaultFileName: string = '';
                                                          const ADefaultFolder: string = '');
var
  SaveDialog: TSaveDialog;
begin
  if (AGrid = nil) or (AGrid.ActiveView = nil) or (AGrid.ActiveView.DataController.RecordCount = 0) then
    Exit;

  SaveDialog := TSaveDialog.Create(nil);

  try

    SaveDialog.Filter := 'Файлы Excel (*.xlsx)|*.xlsx|Файлы Excel 97-2003 (*.xls)|*.xls';
    SaveDialog.DefaultExt := 'xlsx';

    if ADefaultFolder <> '' then
      SaveDialog.InitialDir := ADefaultFolder;

    if ADefaultFileName <> '' then
       SaveDialog.FileName := ADefaultFileName;

    if SaveDialog.Execute then
    begin
      if SaveDialog.FilterIndex = 1 then
        ExportGridToXLSX(SaveDialog.FileName, AGrid, True, True, True, 'xlsx')
      else
        ExportGridToExcel(SaveDialog.FileName, AGrid, True, True, True, 'xls');
    end;

  finally
    SaveDialog.Free;
  end;

end;

end.

