. "E:\scripts\vm_manager\winrm-session.ps1"

# $BAT_DIR_PATH = "E:\scripts\vm_manager"
$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$webdomain = $Args[4]
$user = $Args[5]
$password = $Args[6]
$web_host = $Args[7]
$origin_user = $Args[8]

try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "new"{
            $list = Invoke-Command -Session $session -Scriptblock{param($webdomain, $user, $password, $web_host, $origin_user) E:\scripts\start_STARTER2019_v2.ps1 $webdomain $user  $password $web_host $origin_user} -ArgumentList $webdomain, $user, $password, $web_host, $origin_user
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


