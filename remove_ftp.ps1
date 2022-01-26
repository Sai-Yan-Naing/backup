

$arg0 = $Args[0]
$arg1 = $Args[1]
write-host $arg0
write-host $arg1
Remove-IISSite -Name $Args[0] -confirm:$false;
Remove-Item E:\ftproot\$arg1
