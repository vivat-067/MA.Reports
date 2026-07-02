unit marSettingsStorageService;

interface

uses
  System.SysUtils, System.IniFiles, marDatabaseSettings, marUtils;

type
  TSettingsStorageService = class
  public
    class procedure Load(ASettings: TDatabaseSettings);
    class procedure Save(ASettings: TDatabaseSettings);
  end;

implementation

const
  cConfigFileName = 'settings.config';
  cSectionDatabase = 'Database';

class procedure TSettingsStorageService.Load(ASettings: TDatabaseSettings);
begin
  if ASettings = nil then Exit;

  var Ini := TIniFile.Create(GetAppConfigPath(cConfigFileName));
  try
    ASettings.Server := Ini.ReadString(cSectionDatabase, 'Server', 'localhost');
    ASettings.Port := Ini.ReadString(cSectionDatabase, 'Port', '3050');
    ASettings.DatabasePath := Ini.ReadString(cSectionDatabase, 'Path', 'W:\FDB\SYSTEM200626.FDB');
    ASettings.CharacterSet := Ini.ReadString(cSectionDatabase, 'CharacterSet', 'UTF8');
  finally
    Ini.Free;
  end;
end;

class procedure TSettingsStorageService.Save(ASettings: TDatabaseSettings);
begin
  if ASettings = nil then Exit;

  var Ini := TIniFile.Create(GetAppConfigPath(cConfigFileName));
  try
    Ini.WriteString(cSectionDatabase, 'Server', ASettings.Server.Trim);
    Ini.WriteString(cSectionDatabase, 'Port', ASettings.Port.Trim);
    Ini.WriteString(cSectionDatabase, 'Path', ASettings.DatabasePath.Trim);
    Ini.WriteString(cSectionDatabase, 'CharacterSet', ASettings.CharacterSet.Trim);
  finally
    Ini.Free;
  end;
end;

end.

