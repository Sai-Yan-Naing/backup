. "E:\scripts\vm_manager\winrm-session.ps1"

# $BAT_DIR_PATH = "E:\scripts\vm_manager"
$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$domain = $Args[4]
$password = $Args[5]
$user = $Args[6]
$action = $Args[7]
$incsvlist = $Args[5]
$upcsvlist = $Args[6]

try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "new"{
            Invoke-Command -Session $session -Scriptblock{param($domain, $password, $action) E:\scripts\initRegistIMailDomain.ps1 $domain $password $action} -ArgumentList $domain, $password, $action
            return "Successfully"
        }
        "newuser"{
            Invoke-Command -Session $session -Scriptblock{param($domain, $password, $user, $action) E:\scripts\user_add_init.ps1 $domain $password $user $action} -ArgumentList $domain, $password, $user, $action
            return "Successfully"
        }
        "edit"{
            Invoke-Command -Session $session -Scriptblock{param($domain, $password, $user, $action) E:\scripts\user_edit_init.ps1 $domain $password $user $action} -ArgumentList $domain, $password, $user, $action
            return "Successfully"
        }
        "delete"{
            Invoke-Command -Session $session -Scriptblock{param($domain, $password, $user, $action) E:\scripts\user_remove_init.ps1 $domain $password $user $action} -ArgumentList $domain, $password, $user, $action
            return "kk $domain $password $user"
        }
        "csv"{
            
            Invoke-Command -Session $session -Scriptblock{param($domain, $incsvlist, $upcsvlist) E:\scripts\importlist.ps1 $domain $incsvlist $upcsvlist} -ArgumentList $domain, $incsvlist, $upcsvlist
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


