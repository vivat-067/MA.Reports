unit marBrigadeReportFilter;

interface

uses
  System.SysUtils, System.JSON.Serializers;

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
    constructor Create;
    procedure Assign(Source: TBrigadeReportFilter);
    function IsValid(out AErrorMsg: string): Boolean;

    [JsonProperty('period_start')]
    property PeriodStart: TDateTime read FPeriodStart write FPeriodStart;
    [JsonProperty('period_end')]
    property PeriodEnd: TDateTime read FPeriodEnd write FPeriodEnd;
    [JsonProperty('employee_name')]
    property EmployeeName: string read FEmployeeName write FEmployeeName;
    [JsonProperty('employee_role')]
    property EmployeeRole: TEmployeeRole read FEmployeeRole write FEmployeeRole;
  end;

implementation

resourcestring
  rsInvalidDateSelection = 'Дата начала периода не может быть больше даты окончания.';
  rsInvalidBlankDateInput = 'Необходимо заполнить период дат.';

constructor TBrigadeReportFilter.Create;
begin
  inherited Create;
  FPeriodStart := EncodeDate(2026, 6, 15);
  FPeriodEnd := EncodeDate(2026, 6, 19);
  FEmployeeRole := erAll;
  FEmployeeName := string.Empty;
end;

procedure TBrigadeReportFilter.Assign(Source: TBrigadeReportFilter);
begin
  if Source <> nil then
  begin
    FPeriodStart := Source.FPeriodStart;
    FPeriodEnd := Source.FPeriodEnd;
    FEmployeeName := Source.FEmployeeName;
    FEmployeeRole := Source.FEmployeeRole;
  end;
end;

function TBrigadeReportFilter.IsValid(out AErrorMsg: string): Boolean;
begin
  Result := False;
  if (FPeriodStart = 0) or (FPeriodEnd = 0) then
  begin
    AErrorMsg := rsInvalidBlankDateInput;
    Exit;
  end;
  if FPeriodStart > FPeriodEnd then
  begin
    AErrorMsg := rsInvalidDateSelection;
    Exit;
  end;
  Result := True;
end;

end.

