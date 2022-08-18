. "E:\scripts\vm_manager\winrm-session.ps1"

# $BAT_DIR_PATH = "E:\scripts\vm_manager"
$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$ftp_user = $Args[4]
$ftp_pass = $Args[5]
$webuser = $Args[6]
$per = $Args[7]
$action = $Args[8]
$originuser = $Args[9]

try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "new"{
            Invoke-Command -Session $session -Scriptblock{param($dir) New-Item -ItemType "directory" -Path $dir} -ArgumentList "E:\webroot\LocalUser\${webuser}"
            Invoke-Command -Session $session -Scriptblock{param($ftp_user, $ftp_pass, $webuser, $per, $action , $originuser) E:\scripts\ftp\create_ftp.ps1 $ftp_user $ftp_pass $webuser $per $action $originuser} -ArgumentList $ftp_user, $ftp_pass, $webuser, $per, $action , $originuser
            return "Successfully"
        }
        "edit"{
            Invoke-Command -Session $session -Scriptblock{param($ftp_user, $ftp_pass, $webuser, $per, $action , $originuser) E:\scripts\ftp\create_ftp.ps1 $ftp_user $ftp_pass $webuser $per $action $originuser} -ArgumentList $ftp_user, $ftp_pass, $webuser, $per, $action , $originuser
            return "Successfully"
        }
        "delete"{

            Invoke-Command -Session $session -Scriptblock{param($dir) Remove-Item $dir -Recurse} -ArgumentList "E:\webroot\LocalUser\${webuser}"

            Invoke-Command -Session $session -Scriptblock{param($ftp_user, $ftp_pass, $webuser, $per, $action , $originuser) E:\scripts\ftp\create_ftp.ps1 $ftp_user $ftp_pass $webuser $per $action $originuser} -ArgumentList $ftp_user, $ftp_pass, $webuser, $per, $action , $originuser
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


