#
# �ϐ��錾
#

# if ($Args.count -lt 3){
#     echo "����������܂���"
#     exit 1
# }
# if ($Args.count -gt 4){
#     echo "�������������܂�"
#     exit 1
# }
$USER_NAME = $Args[1]
$USER_PASSWORD = $Args[2]
$ORIGIN_USER = $Args[4]

$IP = "203.137.93.207"
if ($Args.length -gt 3) {
  $IP = $Args[3]
  netsh interface ip add address name="�C�[�T�l�b�g 3" addr=$IP mask=255.255.252.0
}

.\hosts.bat $IP $Args[0]
# Web�R���g���[���p�l���p�f�[�^�x�[�X�ɓo�^
# php add_db.php $Args[0] $Args[1] $Args[2] 4
import-module WebAdministration

#
# ���[�J�����[�U�[�쐬
#
$computer = [ADSI]"WinNT://."
$user = $computer.Create("user", $USER_NAME)
$user.SetPassword($USER_PASSWORD)
$user.SetInfo()
$user.FullName = $USER_NAME
$user.Description = $USER_NAME
$user.UserFlags = 0x10000 #�p�X���[�h�𖳊����ɐݒ�
$user.SetInfo()

# �N�I�[�^�̐ݒ�
fsutil quota modify E: 10737418240 10737418240 $USER_NAME

# ���[�J���O���[�v�Ƀ��[�J�����[�U�[��ǉ�

net localgroup Users $USER_NAME /add
copy-item tmpl E:\webroot\LocalUser\$ORIGIN_USER\$USER_NAME -Recurse

# echo y | cacls E:\webroot\LocalUser\$ORIGIN_USER\$USER_NAME /T /G "Users:R"

# IIS�ݒ�����邽�߂̃��W���[����ǂݍ���
import-module  WebAdministration

#
# IIS�ݒ菉������
#
$SITE_NAME = $Args[0]
$APPLICATIONPOOL_NAME = $USER_NAME

New-Item iis:\Sites\${USER_NAME} -bindings @{protocol="http";bindingInformation="${IP}:80:${SITE_NAME}"} -PhysicalPath "E:\webroot\LocalUser\$ORIGIN_USER\${USER_NAME}\web"

if ($SITE_NAME -notlike "*.happywinds.net") {
  New-WebBinding -Name $USER_NAME -IP $IP -Port "80" -Protocol http -HostHeader www.${SITE_NAME}
}

New-item iis:\AppPools\${APPLICATIONPOOL_NAME}
Set-ItemProperty iis:\apppools\${APPLICATIONPOOL_NAME} -name processModel -value @{userName=$USER_NAME;password=$USER_PASSWORD;identitytype=3}
Set-ItemProperty "IIS:\Sites\${USER_NAME}" -name Applicationpool -value $APPLICATIONPOOL_NAME

$pool = Get-Item "IIS:\AppPools\${APPLICATIONPOOL_NAME}"
$pool.enable32BitAppOnWin64 = $true
$pool | Set-Item

# ���O�f�B���N�g���̐ݒ�
Set-ItemProperty iis:\Sites\${USER_NAME} -name logFile -value @{directory="E:\webroot\LocalUser\$ORIGIN_USER\$USER_NAME\logs";localTimeRollover="True"}

# �ш�̐ݒ�
Set-ItemProperty iis:\Sites\${USER_NAME} -name limits -value @{maxBandwidth=1048576}

# Python�ݒ�
#$PY_Handler = 'C:\Program Files\Python\v2.7.15\Env\Scripts\python.exe %s %s'
#Add-Webconfiguration -filter /system.webServer/handlers -location $USER_NAME -pspath "IIS:" -value @{name='Python2.7.15_via_CGI';path='*.py';verb='*';modules='CgiModule';scriptProcessor=$PY_Handler}

#$PY_Handler = 'C:\Program Files\Python\v3.6.6\Env\Scripts\python.exe %s %s'
#Add-Webconfiguration -filter /system.webServer/handlers -location $USER_NAME -pspath "IIS:" -value @{name='Python3.6.6_via_CGI';path='*.py';verb='*';modules='CgiModule';scriptProcessor=$PY_Handler}

# PHP�ݒ�
#Add-WebConfiguration /system.webServer/fastCGI -value @{fullPath="C:\PHP7.4.15\php-cgi.exe";arguments="-d open_basedir=E:\webroot\LocalUser\$ORIGIN_USER\${USER_NAME}"}
#$PHP_Handler = 'C:\PHP7.4.15\php-cgi.exe|-d open_basedir=E:\webroot\LocalUser\$ORIGIN_USER\'+${USER_NAME}
#Add-Webconfiguration -filter /system.webServer/handlers -location $USER_NAME -pspath "IIS:" -value @{name='PHP5.6.37-nts-x86_via_FastCGI';path='*.php';verb='*';modules='FastCgiModule';scriptProcessor=$PHP_Handler}

#Add-WebConfiguration /system.webServer/fastCGI -value @{fullPath="C:\PHP7.4.15\php-cgi.exe";arguments="-d open_basedir=E:\webroot\LocalUser\$ORIGIN_USER\${USER_NAME}"}
#$PHP_Handler = 'C:\PHP7.4.15\php-cgi.exe|-d open_basedir=E:\webroot\LocalUser\$ORIGIN_USER\'+${USER_NAME}
#Add-Webconfiguration -filter /system.webServer/handlers -location $USER_NAME -pspath "IIS:" -value @{name='PHP5.6.37-nts-x64_via_FastCGI';path='*.php';verb='*';modules='FastCgiModule';scriptProcessor=$PHP_Handler}

Add-WebConfiguration /system.webServer/fastCGI -value @{fullPath="C:\Program Files\PHP\v7.3\php-cgi.exe";arguments="-d open_basedir=E:\webroot\LocalUser\$ORIGIN_USER\${USER_NAME}"}
$PHP_Handler = 'C:\Program Files\PHP\v7.3\php-cgi.exe|-d open_basedir=E:\webroot\LocalUser\$ORIGIN_USER\'+${USER_NAME}
Add-Webconfiguration -filter /system.webServer/handlers -location $USER_NAME -pspath "IIS:" -value @{name='PHP7.3-FastCGI';path='*.php';verb='*';modules='FastCgiModule';scriptProcessor=$PHP_Handler}

Set-Webconfiguration -filter /system.webServer/isapiFilters -location $USER_NAME -pspath "IIS:" -value @{name='bassman';path="E:\webroot\LocalUser\$ORIGIN_USER\$USER_NAME\bassman\Bassman.dll";preCondition='bitness32'}

cacls E:\webroot\LocalUser\$ORIGIN_USER\$USER_NAME /T /E /G "${USER_NAME}:F"
cacls E:\webroot\LocalUser\$ORIGIN_USER\$USER_NAME\web /T /E /G "IUSR:F"
cacls E:\webroot\LocalUser\$ORIGIN_USER\$USER_NAME\web /T /E /G "NETWORK SERVICE:F"

$webReq = [Net.HttpWebRequest]::Create("http://${SITE_NAME}/")
$webReq.Method = "GET"
$webReq.UserAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.0.3705; .NET CLR 1.1.4322)"

$webRes = $webReq.GetResponse()
$webRes.Close()

pause