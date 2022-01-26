if ($Args.count -ne 1){
    echo "ˆø”‚ª‘«‚è‚Ü‚¹‚ñ"
    exit 1
}

C:\\Windows\\System32\\inetsrv\\appcmd.exe stop site /site.name:$Args
C:\\Windows\\System32\\inetsrv\\appcmd.exe stop apppool /apppool.name:$Args
net user $Args /active:no
php stop_server.php $Args