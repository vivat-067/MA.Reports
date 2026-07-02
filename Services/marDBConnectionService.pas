unit marDBConnectionService;

interface

uses
  System.SysUtils, System.IOUtils, FireDAC.Comp.Client, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Stan.Intf,
  marDatabaseSettings, marSettingsStorageService, marUtils;

type
  TDBConnectionService = class
  public
    class procedure ConfigureConnection(AConnection: TFDConnection; ALink: TFDPhysFBDriverLink);
  end;

implementation

{ TDBConnectionService }

class procedure TDBConnectionService.ConfigureConnection(AConnection: TFDConnection; ALink: TFDPhysFBDriverLink);
begin
  if (AConnection = nil) or (ALink = nil) then
    Exit;

  ALink.VendorLib := GetAppConfigPath(TPath.Combine('fbclient', 'fbclient.dll'));

  AConnection.Close;
  AConnection.Params.Clear;
  AConnection.DriverName := 'FB';
  AConnection.Params.Values['DriverID'] := 'FB';
  AConnection.Params.Values['Protocol'] := 'TCPIP';

  var Settings := TDatabaseSettings.Create;
  try
    TSettingsStorageService.Load(Settings);

    AConnection.Params.Values['Server'] := Settings.Server;
    AConnection.Params.Values['Port'] := Settings.Port;
    AConnection.Params.Values['Database'] := Settings.DatabasePath;
    AConnection.Params.Values['CharacterSet'] := Settings.CharacterSet;

    AConnection.Params.Values['User_Name'] := Settings.UserName;
    AConnection.Params.Values['Password'] := Settings.Password;
  finally
    Settings.Free;
  end;

  AConnection.Params.Values['User_Name'] := 'SYSDBA';
  AConnection.Params.Values['Password'] := 'masterkey';

  AConnection.Params.Values['WireCrypt'] := 'Disabled';

  AConnection.LoginPrompt := False;
end;

end.

