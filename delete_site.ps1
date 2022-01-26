$DOMAIN = $Args[0]
$USER = $Args[1]

if ($Args.count -eq 2) {
    .\stop_server.ps1 $DOMAIN
    php C:\Users\Administrator\Desktop\deleteuser.php $DOMAIN
    move E:\webroot\LocalUser\$USER E:\deleted\$USER 
} else {
    echo "ˆø”ƒGƒ‰[‚Å‚·"
}