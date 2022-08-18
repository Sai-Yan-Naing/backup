. "E:\scripts\vm_manager\winrm-session.ps1"

# $BAT_DIR_PATH = "E:\scripts\vm_manager"
$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$webuser = $Args[4]
$version = $Args[5]

try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "change"{
            $res = Invoke-Command -Session $session -Scriptblock{param($webuser, $version) E:/scripts/php_version/php_version_change.bat $webuser $version} -ArgumentList $webuser, $version
            return $res
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


