#
# 変数宣言
#

if ($Args.count -lt 3){
    echo "引数が足りません"
    exit 1
}
if ($Args.count -gt 4){
    echo "引数が多すぎます"
    exit 1
}

$USER_NAME = $Args[1]
$USER_PASSWORD = $Args[2]

$IP = "203.137.93.207"
if ($Args.length -gt 3) {
  $IP = $Args[3]
  netsh interface ip add address name="イーサネット 3" addr=$IP mask=255.255.252.0
}

#
# ローカルユーザー作成
#
$computer = [ADSI]"WinNT://."
$user = $computer.Create("user", $USER_NAME)
$user.SetPassword($USER_PASSWORD)
$user.SetInfo()
$user.FullName = $USER_NAME
$user.Description = $USER_NAME
$user.UserFlags = 0x10000 #パスワードを無期限に設定
$user.SetInfo()

# クオータの設定
fsutil quota modify E: 10737418240 10737418240 $USER_NAME

# ローカルグループにローカルユーザーを追加

net localgroup Users $USER_NAME /add
copy-item tmpl E:\webroot\LocalUser\$USER_NAME -Recurse

# echo y | cacls E:\webroot\LocalUser\$USER_NAME /T /G "Users:R"

# IIS設定をするためのモジュールを読み込み
import-module  WebAdministration

#
# IIS設定初期処理
#
