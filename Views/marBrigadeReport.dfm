object fraBrigadeReport: TfraBrigadeReport
  Left = 0
  Top = 0
  Width = 1179
  Height = 642
  TabOrder = 0
  object dxLayoutControl1: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 1179
    Height = 642
    Align = alClient
    TabOrder = 0
    OptionsImage.Images = dmResources.ilButtons24
    object dePeriodStart: TcxDateEdit
      Left = 116
      Top = 12
      AutoSize = False
      Properties.ImmediatePost = True
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 0
      Height = 23
      Width = 121
    end
    object dePeriodEnd: TcxDateEdit
      Left = 267
      Top = 12
      Properties.ImmediatePost = True
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 1
      Width = 121
    end
    object cmbEmloyeeRole: TcxComboBox
      Left = 765
      Top = 12
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownSizeable = True
      Properties.ImmediatePost = True
      Properties.ImmediateUpdateText = True
      Properties.ReadOnly = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 3
      Width = 121
    end
    object grReport: TcxGrid
      Left = 12
      Top = 51
      Width = 1155
      Height = 579
      TabOrder = 6
      object gvReport: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.First.Visible = True
        Navigator.Buttons.PriorPage.Visible = True
        Navigator.Buttons.Prior.Visible = True
        Navigator.Buttons.Next.Visible = True
        Navigator.Buttons.NextPage.Visible = True
        Navigator.Buttons.Last.Visible = True
        Navigator.Buttons.Insert.Visible = True
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Delete.Visible = True
        Navigator.Buttons.Edit.Visible = True
        Navigator.Buttons.Post.Visible = True
        Navigator.Buttons.Cancel.Visible = True
        Navigator.Buttons.Refresh.Visible = True
        Navigator.Buttons.SaveBookmark.Visible = True
        Navigator.Buttons.GotoBookmark.Visible = True
        Navigator.Buttons.Filter.Visible = True
        FindPanel.Behavior = fcbFilter
        FindPanel.DisplayMode = fpdmAlways
        FindPanel.InfoText = #1042#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090' '#1076#1083#1103' '#1087#1086#1080#1089#1082#1072'...'
        FindPanel.Layout = fplCompact
        FindPanel.Position = fppBottom
        FindPanel.ShowClearButton = False
        FindPanel.ShowCloseButton = False
        FindPanel.ShowFindButton = False
        FindPanel.ShowNextButton = False
        FindPanel.ShowPreviousButton = False
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = gvReportCustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CellHints = True
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusFirstCellOnNewRecord = True
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsBehavior.IncSearch = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsCustomize.DataRowSizing = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.DataRowHeight = 42
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        OptionsView.HeaderEndEllipsis = True
        OptionsView.Indicator = True
        object gclN: TcxGridDBColumn
          Caption = 'N'
          DataBinding.ValueType = 'Integer'
          OnGetDataText = gclNGetDataText
          HeaderAlignmentHorz = taCenter
          Width = 42
        end
        object gclEmpRoleName: TcxGridDBColumn
          Caption = #1058#1080#1087
          DataBinding.FieldName = 'EMP_ROLE_NAME'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 93
        end
        object clFIO: TcxGridDBColumn
          Caption = #1060#1048#1054
          DataBinding.FieldName = 'FIO'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 112
        end
        object gclWorkTime: TcxGridDBColumn
          Caption = #1054#1090#1088#1072#1073'. '#1074#1088#1077#1084#1103
          DataBinding.FieldName = 'WORK_TIME'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          OnGetDataText = ConvertTimeToHHMM
          HeaderAlignmentHorz = taCenter
          Width = 77
        end
        object gclCallTime: TcxGridDBColumn
          Caption = #1042#1088#1077#1084#1103' '#1085#1072' '#1074#1099#1079#1086#1074#1072#1093' ('#1095#1095':'#1084#1084')'
          DataBinding.FieldName = 'CALL_HOURS'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          OnGetDataText = ConvertTimeToHHMM
          HeaderAlignmentHorz = taCenter
          Width = 86
        end
        object gclCallTimeHrs: TcxGridDBColumn
          Caption = #1042#1088#1077#1084#1103' '#1085#1072' '#1074#1099#1079#1086#1074#1072#1093' ('#1095#1095','#1095#1095')'
          DataBinding.FieldName = 'CALL_HOURS'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          OnGetDisplayText = gclCallTimeHrsGetDisplayText
          HeaderAlignmentHorz = taCenter
          Width = 82
        end
        object gclInsuranceCallsCount: TcxGridDBColumn
          AlternateCaption = 'gclnsuranceCallsCount'
          Caption = #1057#1090#1088#1072#1093'. '#1074#1099#1079#1086#1074#1099
          DataBinding.FieldName = 'DMS_CALLS'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 80
        end
        object gclPrivateCallsCount: TcxGridDBColumn
          Caption = #1063#1072#1089#1090#1085#1099#1077' '#1074#1099#1079#1086#1074#1099
          DataBinding.FieldName = 'PRIVATE_CALLS'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 92
        end
        object gclRevenue: TcxGridDBColumn
          Caption = #1042#1099#1088#1091#1095#1082#1072', '#1088#1091#1073
          DataBinding.FieldName = 'REVENUE_RUB'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCurrencyEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 110
        end
        object gclEmpRoleID: TcxGridDBColumn
          DataBinding.FieldName = 'EMP_ROLE_ID'
          DataBinding.IsNullValueType = True
          Visible = False
          Width = 101
        end
        object gvEmpID: TcxGridDBColumn
          DataBinding.FieldName = 'EMP_USER_ID'
          DataBinding.IsNullValueType = True
          Visible = False
          Width = 94
        end
      end
      object glReport: TcxGridLevel
        GridView = gvReport
      end
    end
    object btnGenerate: TcxButton
      Left = 893
      Top = 12
      Width = 120
      Height = 25
      Action = acGenerateReport
      TabOrder = 4
    end
    object btnExport: TcxButton
      Left = 1020
      Top = 12
      Width = 120
      Height = 25
      Action = acExportReport
      TabOrder = 5
    end
    object edEmployeeName: TcxMRUEdit
      Left = 463
      Top = 12
      Properties.ClearKey = 46
      Properties.ImmediatePost = True
      Properties.ImmediateUpdateText = True
      Properties.OnButtonClick = edEmployeeNamePropertiesButtonClick
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 2
      Width = 200
    end
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Visible = False
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object lgFilter: TdxLayoutGroup
      Parent = dxLayoutControl1Group_Root
      CaptionOptions.AlignVert = tavCenter
      CaptionOptions.Text = #1060#1080#1083#1100#1090#1088
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object lgReport: TdxLayoutGroup
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahClient
      AlignVert = avClient
      ShowBorder = False
      Index = 1
    end
    object liPeriodStart: TdxLayoutItem
      Parent = lgFilter
      CaptionOptions.Text = #1055#1077#1088#1080#1086#1076' '#1089':'
      Control = dePeriodStart
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liPeriodEnd: TdxLayoutItem
      Parent = lgFilter
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = #1087#1086':'
      Control = dePeriodEnd
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liEmployeeType: TdxLayoutItem
      Parent = lgFilter
      CaptionOptions.Text = #1058#1080#1087' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072':'
      Control = cmbEmloyeeRole
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object liReportGrid: TdxLayoutItem
      Parent = lgReport
      AlignHorz = ahClient
      AlignVert = avClient
      Control = grReport
      ControlOptions.OriginalHeight = 577
      ControlOptions.OriginalWidth = 250
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liGenerate: TdxLayoutItem
      Parent = lgFilter
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = btnGenerate
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object liExport: TdxLayoutItem
      Parent = lgFilter
      AlignHorz = ahLeft
      CaptionOptions.Text = 'cxButton2'
      CaptionOptions.Visible = False
      Control = btnExport
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 6
    end
    object liEmployeeName: TdxLayoutItem
      Parent = lgFilter
      CaptionOptions.Text = #1057#1086#1090#1088#1091#1076#1085#1080#1082':'
      Control = edEmployeeName
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 200
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object liFilterBlock: TdxLayoutLabeledItem
      Parent = lgFilter
      Padding.Right = 5
      Padding.AssignedValues = [lpavBottom, lpavRight]
      CaptionOptions.Hint = #1041#1083#1086#1082' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1080' '#1086#1090#1095#1077#1090#1072
      CaptionOptions.ImageIndex = 15
      Index = 0
    end
  end
  object ActionList1: TActionList
    Left = 965
    Top = 519
    object acGenerateReport: TAction
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
      Hint = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1095#1077#1090
      ImageIndex = 33
      OnExecute = acGenerateReportExecute
      OnUpdate = acGenerateReportUpdate
    end
    object acExportReport: TAction
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
      Hint = #1042#1099#1081#1090#1080' '#1080#1079' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
      OnExecute = acExportReportExecute
      OnUpdate = acExportReportUpdate
    end
  end
end
