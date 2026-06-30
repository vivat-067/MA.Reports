unit marConverters;

interface

uses
  System.SysUtils, System.DateUtils, System.TimeSpan, System.Variants, System.StrUtils;


const
   CRLF = #10#13;

function XVarToDate(AValue : variant) : TDateTime;
function XVarToDateTime(AValue : variant) : TDateTime;
function XVarToString(AValue : variant) : string;
function XVarToInt(AValue : variant; ADef : integer = -1) : integer;
function XVarToBool(AValue : variant) : boolean;
function XVarTimeToInt(AValue : variant) : integer;
function XVarToDouble(AValue : variant; ADef : integer = 0) : Double;

function XStrToDate(str : string):TDateTime;
function XStrToDateTime(S: string): TDateTime;

function XFormatTime(const Value: TDateTime): string; overload;
function XFormatTime(const Value: TTimeSpan): string; overload;
function XFormatTime(const Value: Double): string; overload;

implementation



function XVarToDate(AValue : variant) : TDateTime;
begin
  Result := XStrToDate(XVarToString(AValue));
end;

function XVarToDateTime(AValue : variant) : TDateTime;
begin
  if not (VarIsNull(AValue) or VarIsEmpty(AValue) or VarIsClear(AValue)) then
     Result := VarToDateTime(AValue)
  else
    Result :=0
end;


function XVarToString(AValue : variant) : string;
begin
  if not (VarIsNull(AValue) or VarIsEmpty(AValue) or VarIsClear(AValue)) then
    result := VarAsType(AValue,varString)
  else
    Result := '';
end;

function XVarToInt64(AValue: variant; ADef: int64 = -1): int64;
begin
  Result := StrToInt64Def(XVarToString(AValue),ADef);
end;

function XVarToInt(AValue : variant;ADef : integer=-1) : integer;
begin
  Result := StrToIntDef(XVarToString(AValue), ADef);
end;

function XVarToBool(AValue : variant) : boolean;
begin
  if not (VarIsNull(AValue) or VarIsEmpty(AValue) or VarIsClear(AValue)) then
    result := VarAsType(AValue, varBoolean)
  else
    Result := False;
end;

function XVarTimeToInt(AValue : variant) : integer;
var
  i : integer;
  s : string;
begin
  try
    s := XVarToString(AValue);
    i := Pos(':',s);
    if i > 0 then
      delete(s,i,1);
    Result := StrToIntDef(s, -1);
  except
    Result := -1;
  end;
end;

function XVarToDouble(AValue : variant; ADef : integer = 0) : Double;
begin
  Result := StrToFloatDef(XVarToString(AValue), ADef);

end;

function XStrToDate(str: string): TDateTime;
begin
  if str = '' then Exit(0.0);
  var Formats := TFormatSettings.Create;
  Formats.DateSeparator := '-';
  Formats.ShortDateFormat := 'yyyy-mm-dd';
  if TryStrToDate(str, Result, Formats) then
    Exit;
  if not TryStrToDate(str, Result) then
    Result := 0.0;
end;

function XStrToDateTime(S: string): TDateTime;
begin
  if S = '' then Exit(0.0);
  if TryStrToDateTime(S, Result) then
    Exit;
  var Formats := TFormatSettings.Create;
  Formats.DateSeparator := '-';
  Formats.TimeSeparator := ':';
  Formats.ShortDateFormat := 'yyyy-mm-dd';
  Formats.LongTimeFormat := 'HH:nn';
  if not TryStrToDateTime(S, Result, Formats) then
    Result := 0.0;
end;


function XFormatTime(const Value: TDateTime): string; overload;
begin
  if Value = 0 then Exit('');
  Result := FormatDateTime('HH:nn', Value);
end;

function XFormatTime(const Value: TTimeSpan): string; overload;
begin
  if Value = TTimeSpan.Zero then Exit('');
  Result := Format('%02d:%02d', [Value.Hours, Value.Minutes]);
end;

function XFormatTime(const Value: Double): string; overload;
var
  TotalMinutes, Hours, Mins: Integer;
begin
  if Value <= 0 then
     Exit('00:00');
  TotalMinutes := Round(Value * 60.0);
  Hours := TotalMinutes div 60;
  Mins := TotalMinutes mod 60;
  Result := Format('%.2d:%.2d', [Hours, Mins]);
end;

end.

