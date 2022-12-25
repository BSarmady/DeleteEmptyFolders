object fmDeleteEmptyFolders: TfmDeleteEmptyFolders
  Left = 216
  Top = 81
  BorderWidth = 5
  Caption = 'Delete Empty Folders'
  ClientHeight = 604
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 460
    Height = 89
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 456
    DesignSize = (
      460
      89)
    object lblCaption: TLabel
      Left = 8
      Top = 8
      Width = 116
      Height = 30
      Caption = 'lblCaption'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 8
      Top = 40
      Width = 81
      Height = 13
      Caption = 'Folder to Browse'
    end
    object btnStart: TButton
      Left = 392
      Top = 56
      Width = 57
      Height = 21
      Anchors = [akTop, akRight]
      Caption = 'Start'
      TabOrder = 0
      OnClick = btnStartClick
      ExplicitLeft = 388
    end
    object edtPath: TEdit
      Left = 8
      Top = 56
      Width = 357
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      ExplicitWidth = 353
    end
    object btnSelectFolder: TButton
      Left = 364
      Top = 56
      Width = 20
      Height = 21
      Anchors = [akTop, akRight]
      Caption = #8230
      TabOrder = 2
      OnClick = edtPathButtonClick
      ExplicitLeft = 360
    end
  end
  object logtext: TRichEdit
    Left = 0
    Top = 89
    Width = 460
    Height = 515
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitWidth = 456
    ExplicitHeight = 514
  end
end
