unit marAppVersionInfo;

interface
uses
  System.SysUtils, Winapi.Windows;
type
  TAppVersionInfo = record
  private
    class var FMajor, FMinor, FRelease: Word;
    class var FBuild: string;
    class constructor Create;
  public
    class property Major: Word read FMajor;
    class property Minor: Word read FMinor;
    class property Release: Word read FRelease;
    class property Build: string read FBuild;

    class function ToString: string; overload; static; inline;
    class function ToShortString: string; static; inline;
    class function ToAssembleyString: string; static; inline;
  end;

implementation
{ TAppVersionInfo }
class constructor TAppVersionInfo.Create;
var
  VHandle, BufSize: DWORD;
  PBuf, TransBlock: pointer;
  ValueBlock: PChar;
  Len: UINT;
  Parts: TArray<string>;
begin
  FMajor := 0;
  FMinor := 0;
  FRelease := 0;
  FBuild := '';
  BufSize := GetFileVersionInfoSize(PChar(ParamStr(0)), VHandle);
  if BufSize = 0 then Exit;
  GetMem(PBuf, BufSize);
  try
    if GetFileVersionInfo(PChar(ParamStr(0)), 0, BufSize, PBuf) and
       VerQueryValue(PBuf, '\VarFileInfo\Translation', TransBlock, Len) and (Len >= 4) and
       VerQueryValue(PBuf, PChar(Format('\StringFileInfo\%.4x%.4x\FileVersion',
         [LoWord(PDWORD(TransBlock)^), HiWord(PDWORD(TransBlock)^)])), Pointer(ValueBlock), Len) then
    begin
      Parts := string(ValueBlock).Split(['.']);
      if Length(Parts) > 0 then FMajor   := StrToIntDef(Parts[0], 0);
      if Length(Parts) > 1 then FMinor   := StrToIntDef(Parts[1], 0);
      if Length(Parts) > 2 then FRelease := StrToIntDef(Parts[2], 0);
      if Length(Parts) > 3 then FBuild   := Parts[3].Trim;
    end;
  finally
    FreeMem(PBuf);
  end;
end;

class function TAppVersionInfo.ToString: string;
begin
  Result := ToString;
end;

class function TAppVersionInfo.ToShortString: string;
begin
  Result := Format('%d.%d', [FMajor, FMinor]);
end;

class function TAppVersionInfo.ToAssembleyString: string;
begin
    Result := Format('%d.%s', [FRelease, Build])
end;


end.

