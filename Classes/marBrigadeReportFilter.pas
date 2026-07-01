unit marBrigadeReportFilter;

interface

uses
  System.SysUtils, System.IOUtils, System.JSON.Serializers, System.JSON.Converters;


type
  TEmployeeRole = (erAll, erDoctor, erParamedic, erDriver);

const
  cEmployeeRoleNames: array[0..3] of string = ('Все', 'Врач', 'Фельдшер', 'Водитель');

type

  [JsonSerialize(TJsonMemberSerialization.Public)]
  TBrigadeReportFilter = class
  private
    FPeriodStart: TDateTime;
    FPeriodEnd: TDateTime;
    FEmployeeName: string;
    FEmployeeRole: TEmployeeRole;
  public
    [JsonProperty('period_start')]
    property PeriodStart: TDateTime read FPeriodStart write FPeriodStart;

    [JsonProperty('period_end')]
    property PeriodEnd: TDateTime read FPeriodEnd write FPeriodEnd;

    [JsonProperty('employee_name')]
    property EmployeeName: string read FEmployeeName write FEmployeeName;

    [JsonProperty('employee_role')]
    property EmployeeRole: TEmployeeRole read FEmployeeRole write FEmployeeRole;

    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
    function IsValid(out AErrorMsg: string): Boolean;

    constructor Create;
    procedure Assign(Source: TBrigadeReportFilter);
  end;


implementation

resourcestring
  rsInvalidDateSelection = 'Дата начала периода не может быть больше даты окончания.';
  rsInvalidBlankDateInput = 'Необходимо заполнить период дат.';

constructor TBrigadeReportFilter.Create;
begin
  inherited Create;
  PeriodStart := EncodeDate(2026, 6, 15);
  PeriodEnd := EncodeDate(2026, 6, 19);
  EmployeeRole:= erAll;
  EmployeeName := string.Empty;
end;

procedure TBrigadeReportFilter.Assign(Source: TBrigadeReportFilter);
begin
 if Source <> nil then
  begin
    Self.PeriodStart :=  Source.PeriodStart;
    Self.PeriodEnd :=    Source.PeriodEnd;
    Self.EmployeeName := Source.EmployeeName;
    Self.EmployeeRole := Source.EmployeeRole;
  end;
end;

function TBrigadeReportFilter.IsValid(out AErrorMsg: string): Boolean;
begin
  Result := False;
  if (PeriodStart = 0) or (PeriodEnd = 0) then
  begin
    AErrorMsg := rsInvalidBlankDateInput;
    Exit;
  end;
  if PeriodStart > PeriodEnd then
  begin
    AErrorMsg := rsInvalidDateSelection;
    Exit;
  end;
  Result := True;
end;

procedure TBrigadeReportFilter.LoadFromFile(const AFileName: string);
begin
  if not TFile.Exists(AFileName) then Exit;

  var Serializer := TJsonSerializer.Create;
  try
    var JsonText := TFile.ReadAllText(AFileName, TEncoding.UTF8);
    var TempFilter := Serializer.Deserialize<TBrigadeReportFilter>(JsonText);

    if TempFilter <> nil then
    try
      Self.Assign(TempFilter);
    finally
      TempFilter.Free;
    end;
  finally
    Serializer.Free;
  end;

end;

procedure TBrigadeReportFilter.SaveToFile(const AFileName: string);
begin
 var Serializer := TJsonSerializer.Create;
  try
    var JsonText := Serializer.Serialize(Self);
    TFile.WriteAllText(AFileName, JsonText, TEncoding.UTF8);
  finally
    Serializer.Free;
  end;
end;

end.

