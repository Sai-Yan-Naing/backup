. "E:\scripts\vm_manager\winrm-session.ps1"

# $BAT_DIR_PATH = "E:\scripts\vm_manager"
$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$dir = $Args[4]
#file value
if($Args[5] -ne $null){
$value =$Args[5].replace('`sp;',' ')
$value =$value.replace('`n',"`n")
$value =$value.replace('`dbq;','"')
$value =$value.replace('`ex;','!')
}

try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "phpversion"{
            $list = Invoke-Command -Session $session -Scriptblock{param($dir) Get-ChildItem -Name  $dir} -ArgumentList $dir
            return $list
        }
        "openfile"{
            $list = Invoke-Command -Session $session -Scriptblock{param($dir) if (Test-Path -Path $dir) {Get-Content $dir}} -ArgumentList $dir
            return $list
        }
        "putfile"{
            $list = Invoke-Command -Session $session -Scriptblock{param($dir,$value) Clear-Content $dir} -ArgumentList $dir, $value
            $list = Invoke-Command -Session $session -Scriptblock{param($dir,[string]$value) Add-Content -Path $dir -Value  ${value}} -ArgumentList $dir, $value
            return $value
        }
        "dirlist"{
            $list = Invoke-Command -Session $session -Scriptblock{param($dir) if (Test-Path -Path $dir) {Get-ChildItem -path $dir  | Select Name, LastWriteTime , Mode, Length, Extension }} -ArgumentList $dir
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


