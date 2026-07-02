unit marSettingsEditorController;

interface

uses
  System.SysUtils, marDatabaseSettings, marSettingsStorageService;

type
  TSettingsEditorController = class
  private
    FSettings: TDatabaseSettings;
  public
    procedure LoadSettings;
    procedure SaveSettings(const AServer, APort, ADBPath, ACharSet: string);

    property Settings: TDatabaseSettings read FSettings;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

constructor TSettingsEditorController.Create;
begin
  inherited Create;
  FSettings := TDatabaseSettings.Create;
end;

destructor TSettingsEditorController.Destroy;
begin
  FSettings.Free;
  inherited;
end;

procedure TSettingsEditorController.LoadSettings;
begin
  TSettingsStorageService.Load(FSettings);
end;

procedure TSettingsEditorController.SaveSettings(const AServer, APort, ADBPath, ACharSet: string);
begin
  FSettings.Server := AServer;
  FSettings.Port := APort;
  FSettings.DatabasePath := ADBPath;
  FSettings.CharacterSet := ACharSet;

  TSettingsStorageService.Save(FSettings);
end;

end.

