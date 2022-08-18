. "E:\scripts\vm_manager\winrm-session.ps1"

# $BAT_DIR_PATH = "E:\scripts\vm_manager"
$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$sitename = $Args[4] 
$webdomain = $Args[5] 
$action = $Args[6] 


try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "ssl"{
            $list = Invoke-Command -Session $session -Scriptblock{param($action,$sitename,$webdomain,$host_ip)  E:\scripts\ssl\ssl.ps1 $action $sitename $webdomain $host_ip } -ArgumentList $action,$sitename,$webdomain,$host_ip
            return 'hello'
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


