$dir = $Args[0]
$user = $Args[1]
$date = $Args[2]
$dstdir = G:\backup\$user

if (Test-Path -Path $dstdir) {
    Remove-Item $dstdir -Recurse
}
copy-item $dir G:\backup\$user\$user+$date -Recurse