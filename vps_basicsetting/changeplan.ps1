# if($Args[1] -eq "change_rdp"){
#     # write-host $Args[0]
#     set-NetFirewallRule -DisplayName "Remote Desktop - User Mode (TCP-In)" -Direction Inbound -LocalPort $Args[0] -Protocol TCP -Action allow
# }elseif( $Args[1] -eq "change_rdip" ){
#     Set-NetFirewallRule -DisplayName "Remote Desktop - User Mode (TCP-In)" -RemoteAddress $Args[0]
# }elseif( $Args[1] -eq "change_webrdp" ){
#     set-NetFirewallRule -DisplayName "World Wide Web Services (HTTP Traffic-In)" -Direction Inbound -LocalPort $Args[0] -Protocol TCP -Action allow
# }elseif( $Args[1] -eq "change_webrdip" ){
#     Set-NetFirewallRule -DisplayName "World Wide Web Services (HTTP Traffic-In)" -RemoteAddress $Args[0]
# }

. "E:\scripts\vm_manager\winrm-session.ps1"

# $BAT_DIR_PATH = "E:\scripts\vm_manager"
$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$vm_name = $Args[4]
$changedate = $Args[5]

try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        
        "changeplan"{
            $result = Invoke-Command -Session $session -Scriptblock{E:\vm_manager\changeplantask.ps1 $Args[0] $Args[1]} -ArgumentList $vm_name, $changedate
         return "success"
        }default {
            return "Invalid command."
        }
    }
    remove_session $session
} catch {
    return $_.Exception
}
return $false

