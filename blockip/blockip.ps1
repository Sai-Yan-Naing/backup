
$arg1 = $Args[0]
$arg2 = $Args[1]
$arg3 = $Args[2]

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""E:\scripts\blockip\blockip_con.ps1 $arg1 $arg2 $arg3""' -Verb RunAs}"
write-host $arg2