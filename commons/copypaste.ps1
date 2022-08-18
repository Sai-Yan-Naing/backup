. "E:\scripts\vm_manager\winrm-session.ps1"

# $BAT_DIR_PATH = "E:\scripts\vm_manager"
$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$dir = $Args[4]
if($Args[5] -ne $null){
    $arg5 = $Args[5]
}
try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "copy"{
            Copy-Item "E:\webroot\LocalUser\temp\1654198850\.env" -Destination "E:\webroot" -ToSession $session
            
            
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


