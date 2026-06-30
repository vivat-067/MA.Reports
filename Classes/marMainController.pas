unit marMainController;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client, FireDAC.Phys.FB;

type
  TMainController = class
  private
    FConnection: TFDConnection;
    FDriverLink: TFDPhysFBDriverLink;
    FIsDBConnected: Boolean;
    FErrorStr: string;
  public
    property IsDBConnected: Boolean read FIsDBConnected;
    property ErrorStr: string read FErrorStr;

    function ConnectToDB: Boolean;
    function DisconnectFromDB: Boolean;

    constructor Create(AConnection: TFDConnection; ADriverLink: TFDPhysFBDriverLink);
    destructor Destroy; override;
  end;

implementation

uses
  marDBConnectionService;

constructor TMainController.Create(AConnection: TFDConnection; ADriverLink: TFDPhysFBDriverLink);
begin
  inherited Create;
  FConnection := AConnection;
  FDriverLink := ADriverLink;
  FIsDBConnected := False;
end;

destructor TMainController.Destroy;
begin
  DisconnectFromDB;
  inherited;
end;

function TMainController.ConnectToDB: Boolean;
begin
  FErrorStr := '';

  if FIsDBConnected then
    Exit(True);

  if not Assigned(FConnection) or not Assigned(FDriverLink) then
    Exit(False);

 try
    TDBConnectionService.ConfigureConnection(FConnection, FDriverLink);
    FConnection.Connected := True;
    FIsDBConnected := True;
  except
    on E: Exception do
    begin
      FIsDBConnected := False;
      FErrorStr := E.Message;
    end;
  end;
  Result := FIsDBConnected;
end;

function TMainController.DisconnectFromDB: Boolean;
begin

  if not Assigned(FConnection) or not FConnection.Connected then
  begin
    FIsDBConnected := False;
    Exit(True);
  end;

  try
    FConnection.Close;
     FIsDBConnected := False;
    Result := True;
  except
    on E: Exception do begin
        FIsDBConnected := False;
       Result := False;
    end;
  end;
end;


end.

