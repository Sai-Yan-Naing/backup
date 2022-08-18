. "E:\scripts\vm_manager\winrm-session.ps1"

# $BAT_DIR_PATH = "E:\scripts\vm_manager"
$cmd = $Args[0]
$host_ip = $Args[1]
$host_user = $Args[2]
$host_password = $Args[3]
$dir = $Args[4]
if($Args[5] -ne $null){
    $arg5 = $Args[5]
}
try {
    $session = get_session $host_ip $host_user $host_password
    switch ($cmd) {
        "newdir"{
            Invoke-Command -Session $session -Scriptblock{param($dir) New-Item -ItemType "directory" -Path $dir} -ArgumentList $dir
            return "Successfully"
        }
        "deletedir"{

            Invoke-Command -Session $session -Scriptblock{param($dir) Remove-Item $dir -Recurse} -ArgumentList $dir
            return "Successfully"
        }
        "renamedir"{

            Invoke-Command -Session $session -Scriptblock{param($dir,$dir2) Rename-Item $dir2 $dir } -ArgumentList $dir,$arg5
            return "Successfully"
        }
        "newfile"{
            Invoke-Command -Session $session -Scriptblock{param($dir) New-Item -Path $dir -ItemType File -Force} -ArgumentList $dir
            return "Successfully"
        }

        "zip"{
            Invoke-Command -Session $session -Scriptblock{param($dir,$fname) Compress-Archive -Path ${dir}\${fname} -DestinationPath ${dir}\${fname}.zip -Force} -ArgumentList $dir, $arg5
            return "Successfully"
        }
        "unzip"{
            Invoke-Command -Session $session -Scriptblock{param($dir,$fname) Expand-Archive -Path ${dir}\${fname} -DestinationPath ${dir}} -ArgumentList $dir, $arg5
            return "Successfully"
        }
        "dirlist"{
            $list = Invoke-Command -Session $session -Scriptblock{param($dir) Get-ChildItem -Name  $dir -Attributes Directory} -ArgumentList $dir
            return $list
        }
        "copy"{
            Invoke-Command -Session $session -Scriptblock{param($dir1,$dir2) Copy-Item -Path ${dir1} -Destination ${dir2} -Recurse} -ArgumentList $dir, $arg5
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


