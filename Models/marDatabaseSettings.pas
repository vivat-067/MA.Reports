unit marDatabaseSettings;

interface

type
  TDatabaseSettings = class
  private
    FServer: string;
    FPort: string;
    FDatabasePath: string;
    FCharacterSet: string;
    FUserName: string;
    FPassword: string;
  public
    property Server: string read FServer write FServer;
    property Port: string read FPort write FPort;
    property DatabasePath: string read FDatabasePath write FDatabasePath;
    property CharacterSet: string read FCharacterSet write FCharacterSet;
    property UserName: string read FUserName write FUserName;
    property Password: string read FPassword write FPassword;

    constructor Create;
    procedure Assign(Source: TDatabaseSettings);
  end;

implementation

constructor TDatabaseSettings.Create;
begin
  inherited Create;

  FServer := 'localhost';
  FPort := '3050';
  FDatabasePath := 'W:\FDB\SYSTEM200626.FDB';
  FCharacterSet := 'UTF8';
  FUserName := 'SYSDBA';
  FPassword := 'masterkey';

end;

procedure TDatabaseSettings.Assign(Source: TDatabaseSettings);
begin
  if Source <> nil then
  begin
    FServer := Source.Server;
    FPort := Source.Port;
    FDatabasePath := Source.DatabasePath;
    FCharacterSet := Source.CharacterSet;
    FUserName := Source.UserName;
    FPassword := Source.Password;
  end;
end;

end.

