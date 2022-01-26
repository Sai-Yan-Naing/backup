
$arg1 = $Args[0]
$arg2 = $Args[1]
$arg3 = $Args[2]
$arg4 = $Args[3]

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""E:\scripts\testps.ps1 $arg1 $arg2 $arg3 $arg4""' -Verb RunAs}"