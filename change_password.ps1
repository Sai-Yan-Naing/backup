#dbのパスワードを変更

if ($Args.count -ne 3) {
    echo "引数が3つではありません"
    exit 1
}
php change_password.php $Args[0] $Args[1] $Args[2]

#Windowsのパスワードを変更

net user $Args[1] $Args[2]