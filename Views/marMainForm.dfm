object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = #1058#1077#1089#1090#1086#1074#1099#1081' '#1084#1086#1076#1091#1083#1100
  ClientHeight = 660
  ClientWidth = 1220
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object grpHeader: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    Style.BorderStyle = ebsNone
    Style.Color = 4227072
    Style.LookAndFeel.NativeStyle = True
    StyleDisabled.LookAndFeel.NativeStyle = True
    TabOrder = 0
    Height = 57
    Width = 1220
    object labAppHeader: TcxLabel
      Left = 2
      Top = 2
      Align = alClient
      Caption = #1052#1077#1076#1040#1085#1072#1083#1080#1090#1080#1082#1072': '#1054#1090#1095#1077#1090#1099
      ParentColor = False
      ParentFont = False
      Style.Color = clWhite
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindow
      Style.Font.Height = -19
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.ReadOnly = True
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      TabOrder = 0
      Transparent = True
      AnchorX = 610
      AnchorY = 29
    end
  end
  object gbBottomControls: TcxGroupBox
    Left = 0
    Top = 562
    Align = alBottom
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    Style.Color = clBtnFace
    TabOrder = 1
    Height = 98
    Width = 1220
    object lcBottomControls: TdxLayoutControl
      Left = 2
      Top = 2
      Width = 1216
      Height = 94
      Align = alClient
      TabOrder = 0
      object btnDBConnect: TcxButton
        Left = 479
        Top = 12
        Width = 125
        Height = 65
        Action = acDBConnect
        OptionsImage.Layout = blGlyphTop
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object btnExitApp: TcxButton
        Left = 1129
        Top = 14
        Width = 75
        Height = 65
        Action = acExitApp
        OptionsImage.Layout = blGlyphTop
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object btnSettings: TcxButton
        Left = 611
        Top = 12
        Width = 125
        Height = 65
        Action = acSettingsEditor
        OptionsImage.Layout = blGlyphTop
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object lcBottomControlsGroup_Root: TdxLayoutGroup
        AlignHorz = ahClient
        AlignVert = avClient
        Hidden = True
        ItemIndex = 1
        LayoutDirection = ldHorizontal
        ShowBorder = False
        Index = -1
      end
      object lgDB: TdxLayoutGroup
        Parent = lcBottomControlsGroup_Root
        AlignHorz = ahCenter
        AlignVert = avClient
        CaptionOptions.Text = 'New Group'
        ItemIndex = 1
        LayoutDirection = ldHorizontal
        ShowBorder = False
        Index = 1
      end
      object liDBConnect: TdxLayoutItem
        Parent = lgDB
        CaptionOptions.Visible = False
        Control = btnDBConnect
        ControlOptions.OriginalHeight = 65
        ControlOptions.OriginalWidth = 125
        ControlOptions.ShowBorder = False
        Index = 0
      end
      object liExitApp: TdxLayoutItem
        Parent = lcBottomControlsGroup_Root
        AlignHorz = ahRight
        AlignVert = avCenter
        CaptionOptions.Visible = False
        Control = btnExitApp
        ControlOptions.OriginalHeight = 65
        ControlOptions.OriginalWidth = 75
        ControlOptions.ShowBorder = False
        Index = 0
      end
      object liAppVersionInfo: TdxLayoutItem
        Parent = lcBottomControlsGroup_Root
        AlignVert = avCenter
        CaptionOptions.Glyph.SourceDPI = 96
        CaptionOptions.Glyph.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          61796572312220786D6C6E733D22687474703A2F2F7777772E77332E6F72672F
          323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F7777
          772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D22
          307078222076696577426F783D2230203020333220333222207374796C653D22
          656E61626C652D6261636B67726F756E643A6E6577203020302033322033323B
          2220786D6C3A73706163653D227072657365727665223E262331333B26233130
          3B20203C7374796C6520747970653D22746578742F6373732220786D6C3A7370
          6163653D227072657365727665223E2E426C7565262331333B262331303B2020
          20207B262331333B262331303B20202020202066696C6C3A233131373744373B
          262331333B262331303B202020202020666F6E742D66616D696C793A2661706F
          733B64782D666F6E742D69636F6E732661706F733B3B262331333B262331303B
          202020202020666F6E742D73697A653A333270783B262331333B262331303B20
          2020207D262331333B262331303B20203C2F7374796C653E0D0A3C7465787420
          783D22302220793D2233322220636C6173733D22426C7565223EEEA5863C2F74
          6578743E0D0A3C2F7376673E0D0A}
        CaptionOptions.Text = #1042#1077#1088#1089#1080#1103':'
        Index = 2
      end
      object liSettings: TdxLayoutItem
        Parent = lgDB
        CaptionOptions.Visible = False
        Control = btnSettings
        ControlOptions.OriginalHeight = 65
        ControlOptions.OriginalWidth = 125
        ControlOptions.ShowBorder = False
        Index = 1
      end
    end
  end
  object panClientContainer: TcxGroupBox
    Left = 0
    Top = 57
    Align = alClient
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    Height = 505
    Width = 1220
  end
  object ActionList1: TActionList
    Images = dmResources.ilButtons24
    Left = 901
    Top = 279
    object acDBConnect: TAction
      Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1082' '#1041#1044
      Hint = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1082' '#1041#1044
      ImageIndex = 16
      OnExecute = acDBConnectExecute
      OnUpdate = acDBConnectUpdate
    end
    object acExitApp: TAction
      Caption = #1042#1099#1093#1086#1076
      Hint = #1042#1099#1081#1090#1080' '#1080#1079' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
      ImageIndex = 18
      OnExecute = acExitAppExecute
    end
    object acSettingsEditor: TAction
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      ImageIndex = 19
      OnExecute = acSettingsEditorExecute
      OnUpdate = acSettingsEditorUpdate
    end
  end
  object dxSkinController1: TdxSkinController
    SkinName = 'WXICompact'
    Left = 901
    Top = 344
  end
end
