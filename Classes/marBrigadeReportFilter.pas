unit marBrigadeReportFilter;

interface

uses
  System.SysUtils;

type
  TEmployeeRole = (erAll, erDoctor, erParamedic, erDriver);

const
  cEmployeeRoleNames: array[0..3] of string = ('Все', 'Врач', 'Фельдшер', 'Водитель');

type

  TBrigadeReportFilter = class
  public
    PeriodStart: TDateTime;
    PeriodEnd: TDateTime;

    EmployeeName: string;
    EmployeeRole: TEmployeeRole;

    constructor Create;
    function IsValid(out AErrorMsg: string): Boolean;
  end;

implementation

constructor TBrigadeReportFilter.Create;
begin
  inherited Create;
  PeriodStart := EncodeDate(2026, 6, 15);
  PeriodEnd := EncodeDate(2026, 6, 19);
  EmployeeRole:= erAll;
  EmployeeName := string.Empty;
end;

function TBrigadeReportFilter.IsValid(out AErrorMsg: string): Boolean;
begin
  Result := False;
  if (PeriodStart = 0) or (PeriodEnd = 0) then
  begin
    AErrorMsg := 'Необходимо заполнить период дат.';
    Exit;
  end;
  if PeriodStart > PeriodEnd then
  begin
    AErrorMsg := 'Дата начала периода не может быть больше даты окончания.';
    Exit;
  end;
  Result := True;
end;

end.

