unit marDBConnectionService;

interface

uses
  System.SysUtils, System.IOUtils, FireDAC.Comp.Client, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Stan.Intf, System.IniFiles, Vcl.Dialogs, marUtils;

type
  TDBConnectionService = class
  public
    class procedure ConfigureConnection(AConnection: TFDConnection; ALink: TFDPhysFBDriverLink);
  end;

implementation

{ TDBConnectionService }

class procedure TDBConnectionService.ConfigureConnection(AConnection: TFDConnection; ALink: TFDPhysFBDriverLink);
var
  ConfigFile: TIniFile;
begin
  if (AConnection = nil) or (ALink = nil) then
     Exit;

  ALink.VendorLib := GetAppConfigPath(TPath.Combine('fbclient', 'fbclient.dll'));

  AConnection.Close;
  AConnection.Params.Clear;
  AConnection.DriverName := 'FB';
  AConnection.Params.Values['DriverID'] := 'FB';
  AConnection.Params.Values['Protocol'] := 'TCPIP';

  ConfigFile := TIniFile.Create(GetAppConfigPath('settings.config'));
  try
    AConnection.Params.Values['Server'] := ConfigFile.ReadString('Database', 'Server', 'localhost');
    AConnection.Params.Values['Port'] := ConfigFile.ReadString('Database', 'Port', '3050');
    AConnection.Params.Values['Database'] := ConfigFile.ReadString('Database', 'Path', 'W:\FDB\SYSTEM200626.FDB');
    AConnection.Params.Values['CharacterSet'] := ConfigFile.ReadString('Database', 'CharacterSet', 'UTF8');
  finally
    ConfigFile.Free;
  end;

  AConnection.Params.Values['User_Name'] := 'SYSDBA';
  AConnection.Params.Values['Password'] := 'masterkey';

  AConnection.Params.Values['WireCrypt'] := 'Disabled';

  AConnection.LoginPrompt := False;
end;


end.

