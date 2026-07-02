unit marFilterStorageService;

interface

uses
  System.SysUtils, System.IOUtils, System.JSON.Serializers,
  marBrigadeReportFilter;

type
  TFilterStorageService = class
  public
    class procedure LoadFromFile(const AFileName: string; AFilter: TBrigadeReportFilter);
    class procedure SaveToFile(const AFileName: string; AFilter: TBrigadeReportFilter);
  end;

implementation

{ TFilterStorageService }

class procedure TFilterStorageService.LoadFromFile(const AFileName: string; AFilter: TBrigadeReportFilter);
begin
  if (AFilter = nil) or not TFile.Exists(AFileName) then
    Exit;

  var Serializer := TJsonSerializer.Create;
  try
    var JsonText := TFile.ReadAllText(AFileName, TEncoding.UTF8);
    var TempFilter := Serializer.Deserialize<TBrigadeReportFilter>(JsonText);

    if TempFilter <> nil then
    try
      AFilter.Assign(TempFilter);
    finally
      TempFilter.Free;
    end;
  finally
    Serializer.Free;
  end;
end;

class procedure TFilterStorageService.SaveToFile(const AFileName: string; AFilter: TBrigadeReportFilter);
begin
  if AFilter = nil then
    Exit;

  var Serializer := TJsonSerializer.Create;
  try
    var JsonText := Serializer.Serialize(AFilter);
    TFile.WriteAllText(AFileName, JsonText, TEncoding.UTF8);
  finally
    Serializer.Free;
  end;
end;

end.

