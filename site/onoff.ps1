. "E:\scripts\vm_manager\winrm-session.ps1"

# $BAT_DIR_PATH = "E:\scripts\vm_manager"
$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$startstop = $Args[4]
$actname = $Args[5]

try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "site"{
            Invoke-Command -Session $session -Scriptblock{C:\Windows\system32\inetsrv\appcmd.exe $Args[0] sites $Args[1]} -ArgumentList $startstop, $actname
            return "$startstop Successfully"
        }
        "app"{
            Invoke-Command -Session $session -Scriptblock{param($startstop, $actname) C:\Windows\system32\inetsrv\appcmd.exe $startstop apppool /apppool.name:$actname} -ArgumentList $startstop, $actname
            return "$startstop Successfully"
        }
        "sitedelete"{
            Invoke-Command -Session $session -Scriptblock{C:\Windows\system32\inetsrv\appcmd.exe $Args[0] sites $Args[1]} -ArgumentList $startstop, $actname
            
            Invoke-Command -Session $session -Scriptblock{param($startstop, $actname) C:\Windows\system32\inetsrv\appcmd.exe $startstop apppool /apppool.name:$actname} -ArgumentList $startstop, $actname
            return "$startstop Successfully"
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


