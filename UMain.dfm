object fMain: TfMain
  Left = 697
  Top = 388
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Compare'
  ClientHeight = 111
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbArquivo1: TLabel
    Left = 5
    Top = 12
    Width = 48
    Height = 13
    Caption = 'Arquivo 1:'
  end
  object lbArquivo2: TLabel
    Left = 5
    Top = 46
    Width = 48
    Height = 13
    Caption = 'Arquivo 2:'
  end
  object sbArq1: TSpeedButton
    Left = 758
    Top = 9
    Width = 23
    Height = 23
    Caption = '...'
    OnClick = sbArq1Click
  end
  object sbArq2: TSpeedButton
    Left = 758
    Top = 43
    Width = 23
    Height = 23
    Caption = '...'
    OnClick = sbArq2Click
  end
  object cbArquivo1: TComboBox
    Left = 56
    Top = 8
    Width = 700
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 17
    ParentFont = False
    TabOrder = 0
  end
  object cbArquivo2: TComboBox
    Left = 56
    Top = 42
    Width = 700
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 17
    ParentFont = False
    TabOrder = 1
  end
  object bOK: TBitBtn
    Left = 276
    Top = 74
    Width = 231
    Height = 33
    Caption = 'Comparar'
    TabOrder = 2
    OnClick = bOKClick
    Kind = bkOK
  end
  object dlgOpen: TOpenDialog
    Filter = '*.*|*.*'
    Left = 102
    Top = 78
  end
end
