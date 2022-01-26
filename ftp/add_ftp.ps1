$strString = "Hello World"
write-host $strString
$arg1 = $Args[0]
$arg2 = $Args[1]
$arg3 = $Args[2]
$arg4 = $Args[3]
$arg5 = $Args[4]
$arg6 = $Args[5]

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""E:\scripts\ftp\create_ftp_main.ps1 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6""' -Verb RunAs}"
