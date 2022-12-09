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
$folder = $Args[4]

try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {

        "os"{
            $result = Invoke-Command -Session $session -Scriptblock{Get-ChildItem -Path  E:\Temp -Directory -Name}
         return $result
            }
        "osfile"{
            $result = Invoke-Command -Session $session -Scriptblock{param([string] $folder)Get-ChildItem -Path  E:\Temp\$folder\*.vhdx -file -Name} -ArgumentList $folder
         return $result
        }default {
            return "Invalid command."
        }
    }
    remove_session $session
} catch {
    return $_.Exception
}
return $false

