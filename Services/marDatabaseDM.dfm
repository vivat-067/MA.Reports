object dmDB: TdmDB
  Height = 394
  Width = 440
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=W:\FDB\SYSTEM200626.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Port=3050'
      'Protocol=TCPIP'
      'DriverID=FB')
    Left = 152
    Top = 104
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 'D:\LAB\DX\FBTest\Win32\Debug\fbclient\fbclient.dll'
    Left = 152
    Top = 184
  end
end
