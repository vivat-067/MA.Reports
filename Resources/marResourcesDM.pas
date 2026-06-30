unit marResourcesDM;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls,
  cxImageList, cxGraphics, cxStyles, dxLayoutLookAndFeels, cxClasses, dxCore, dxSkinMetropolisDark,
  Generics.Defaults, Generics.Collections, cxContainer, cxEdit;


type
  TdmResources = class(TDataModule)
    ilButtons24: TcxImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmResources: TdmResources;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmResources }


end.
