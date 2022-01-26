$strString = "Hello World"
write-host $strString
write-host $Args[0]
write-host $Args[1]
write-host $Args[2]
write-host $Args[3]

cd "E:\scripts"; & ".\start_STARTER2019.ps1"  $Args[0] $Args[1] $Args[2] $Args[3]
