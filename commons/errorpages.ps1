. "E:\scripts\vm_manager\winrm-session.ps1"

# $BAT_DIR_PATH = "E:\scripts\vm_manager"
$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$webuser = $Args[4]
$code = $Args[5] 
$status_code = $Args[6] 
$url_spec = $Args[7] 
$status = $Args[8] 
$action = $Args[9] 

try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "new"{
            $res=Invoke-Command -Session $session -Scriptblock{param($webuser, $code, $status_code, $url_spec , $status) E:/scripts/error_pages/error_pages_init.ps1 $webuser $code $status_code  $url_spec $status} -ArgumentList $webuser, $code, $status_code, $url_spec , $status
            return $res
        }
        "edit"{
            $res=Invoke-Command -Session $session -Scriptblock{param($webuser, $code, $status_code, $url_spec , $status, $action) E:/scripts/error_pages/error_pages_init.ps1 $webuser $code $status_code  $url_spec $status $action} -ArgumentList $webuser, $code, $status_code, $url_spec , $status, $action
            return $res
        }
        
        "delete"{
            $res=Invoke-Command -Session $session -Scriptblock{param($webuser, $code, $status_code, $url_spec , $status, $action) E:/scripts/error_pages/error_pages_init.ps1 $webuser $code $status_code  $url_spec $status $action} -ArgumentList $webuser, $code, $status_code, $url_spec , $status, $action
            return $res
        }
        
        "onoff"{
            $res=Invoke-Command -Session $session -Scriptblock{param($webuser, $code, $status_code, $url_spec , $status) E:/scripts/error_pages/error_pages_init.ps1 $webuser $code $status_code  $url_spec $status} -ArgumentList $webuser, $code, $status_code, $url_spec , $status
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


