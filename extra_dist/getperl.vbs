'   script to download perl install file and save on local disc
'   the location of which is provided by first argument 


Const WindowsFolder = 0
Const SystemFolder = 1
Const TemporaryFolder = 2
Dim fso: Set fso = CreateObject("Scripting.FileSystemObject")
Dim tempFolder: tempFolder = fso.GetSpecialFolder(TemporaryFolder)

strHDLocation = Wscript.Arguments.Item(0)
' Later versions are provided at github instead of strawberryperl.com
' and this script gets a Permission Denied error from MSXML2 when
' trying to access them.
strVersion = "5.32.1.1"

' Set your settings
    strFileURL    = "https://strawberryperl.com/download/" & strVersion & "/strawberry-perl-" & strVersion & "-32bit.msi"

    Wscript.Echo "   copying " & strFileURL
    Wscript.Echo "   to "  & strHDLocation

' Fetch the file
    Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP")

    objXMLHTTP.open "GET", strFileURL, false
    objXMLHTTP.send()

If objXMLHTTP.Status = 200 Then
   Set objADOStream = CreateObject("ADODB.Stream")
   objADOStream.Open
   objADOStream.Type = 1 'adTypeBinary

   objADOStream.Write objXMLHTTP.Responody
   objADOStream.Position = 0    'Set the stream position to the start

   Set objFSO = Createobject("Scripting.FileSystemObject")
   If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation

   objADOStream.SaveToFile strHDLocation
   objADOStream.Close
   Set objADOStream = Nothing
   If objFSO.Fileexists(strHDLocation) Then 
      Wscript.Echo " "
      Wscript.Echo "   " & strHDLocation & " downloaded OK"
      Wscript.Echo " "
      Set objFSO = Nothing
      wscript.quit 0
  End if
End if

wscript.quit 1
