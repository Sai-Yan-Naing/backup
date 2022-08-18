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
$vm_user = $Args[5]
$vm_pass = $Args[6]
$vm_action = $Args[7]
$chport  = $Args[8]
$chip = $Args[9]

try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "firewall"{
            Invoke-Command -Session $session -Scriptblock{E:\vm_manager\firewall.ps1 $Args[0] $Args[1] $Args[2] $Args[3] $Args[4] $Args[5]} -ArgumentList $vm_name, $vm_user, $vm_pass, $vm_action, $chport, $chip
            return "Complete Add new Port $vm_name, $vm_user, $vm_pass, $vm_action, $chport, $chip"
        }default {
            return "Invalid command."
        }
    }
    remove_session $session
} catch {
    return $_.Exception
}
return $false

