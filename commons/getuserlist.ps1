. "E:\scripts\vm_manager\winrm-session.ps1"

# $BAT_DIR_PATH = "E:\scripts\vm_manager"
$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$checker = $Args[4]

try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "users"{
            $list = Invoke-Command -Session $session -Scriptblock{wmic useraccount get name}
            return $list
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


