. "E:\scripts\vm_manager\winrm-session.ps1"

# $BAT_DIR_PATH = "E:\scripts\vm_manager"
$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$site = $Args[4]
$ip = $Args[5]
$action = $Args[6]

try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "ip"{
            Invoke-Command -Session $session -Scriptblock{param($site, $ip, $action) E:\scripts\blockip/blockip_init.ps1 $site $ip $action} -ArgumentList $site, $ip, $action
            return "Successfully"
        }
        default {
            return "Invalid command."
        }
    }
    remove_session $session
} catch {
    return $_.Exception
}
return $false


