. "E:\scripts\vm_manager\winrm-session.ps1"

$BAT_DIR_PATH = "E:\scripts\vm_manager"



$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$vm_name = $Args[4]
$backupname = $Args[5]
$oldbackupname = $Args[6]

try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "restore_backup" {
            $restult = Invoke-Command -Session $session -Scriptblock{E:\vm_manager\backuprestore.ps1 $Args[0] $Args[1]} -ArgumentList $vm_name, $backupname
            return "Complete restore."
        }
        "delete" {
            $restult = Invoke-Command -Session $session -Scriptblock{E:\vm_manager\backupdelete.ps1 $Args[0] $Args[1]} -ArgumentList $vm_name, $backupname
            return "Complete restore."
        }
        "export_vm" {
            $restult = Invoke-Command -Session $session -Scriptblock{E:\vm_manager\backup.ps1 $Args[0] $Args[1] $Args[2]} -ArgumentList $vm_name, $backupname, $oldbackupname
            return "Complete export."
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