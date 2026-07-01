unit marUtils;

interface

uses
  Vcl.Controls, Vcl.Forms, System.SysUtils, System.IOUtils;


procedure SetFrameParent(AItem: TWinControl; AFrame: TFrame);

function GetAppConfigPath(const AConfigName: string = 'settings.config'): string;

implementation


procedure SetFrameParent(AItem: TWinControl; AFrame: TFrame);
begin
  AFrame.Parent := AItem;
  AFrame.Align := alClient;
end;


function GetAppConfigPath(const AConfigName: string): string;
begin
  Result := TPath.Combine(ExtractFilePath(ParamStr(0)), AConfigName);
end;



end.
