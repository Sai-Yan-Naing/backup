$strString = "Hello World"
write-host $strString
$arg1 = $Args[0]
$arg2 = $Args[1]
$arg3 = $Args[2]

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""E:\scripts\create_ftp_main.ps1 $arg1 $arg2 $arg3""' -Verb RunAs}"

echo system('powershell.exe -executionpolicy bypass -NoProfile -File "E:\scripts/test.ps1" '.$domain.' '.$ftp_user.' '.$password.' '.$ip);
