$strString = "Hello World"
# write-host $strString
# write-host $arg1 = $Args[0]
# write-host $arg2 = $Args[1]
# write-host $arg3 = $Args[2]
# write-host $arg4 = $Args[3]
# write-host $arg5 = $Args[4]

$arg1 = $Args[0]
$arg2 = $Args[1]
$arg3 = $Args[2]
$arg4 = $Args[3]
$arg5 = $Args[4]
# pause
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""E:\scripts\addsitecon.ps1 $arg1 $arg2 $arg3 $arg4 $arg5""' -Verb RunAs}"