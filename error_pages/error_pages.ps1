
$arg1 = $Args[0]
$arg2 = $Args[1]
$arg3 = $Args[2]
$arg4 = $Args[3]
$arg5 = $Args[4]
$arg6 = $Args[5]
# $arg2 = "hello"
write-host $arg2
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""E:\scripts\error_pages\error_pages_con.ps1 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6""' -Verb RunAs}"

