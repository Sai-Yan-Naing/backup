. "E:\scripts\vm_manager\winrm-session.ps1"

# $BAT_DIR_PATH = "E:\scripts\vm_manager"
$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$dir = $Args[4]
$user = $Args[5]
$date = $Args[6]

try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "backup"{
            $list = Invoke-Command -Session $session -Scriptblock{param($dir,$user,$date) E:\scripts\backup\share\backup.ps1  $dir $user $date} -ArgumentList $dir,$user,$date
            return $list
        }
        "restore"{
            $list = Invoke-Command -Session $session -Scriptblock{param($dir,$user,$date) E:\scripts\backup\share\restore.ps1  $dir $user $date} -ArgumentList $dir,$user,$date
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


