$USER_NAME=$Args[0]
$USER_PASSWORD=$Args[1]
$FOLDER=$Args[2]
$PERMISSION=$Args[3]
$TYPE=$Args[4]
$ORIGIN_USER=$Args[5]

if( $TYPE -eq "new" )
{

	$computer = [ADSI]"WinNT://."
	$user = $computer.Create("user", $USER_NAME)
	$user.SetPassword($USER_PASSWORD)
	$user.SetInfo()
	$user.FullName = $USER_NAME
	$user.Description = $USER_NAME
	$user.UserFlags = 0x10000 #ƒpƒXƒ[ƒh‚ð–³ŠúŒÀ‚ÉÝ’è
	$user.SetInfo()

	# ƒNƒI[ƒ^‚ÌÝ’è
	fsutil quota modify E: 10737418240 10737418240 $USER_NAME

	# ƒ[ƒJƒ‹ƒOƒ‹[ƒv‚Éƒ[ƒJƒ‹ƒ†[ƒU[‚ð’Ç‰Á

	net localgroup Users $USER_NAME /add

# Create Sub User FTP Directory
#$user_name = "sub_user"
$target_path = "E:\webroot\LocalUser\$ORIGIN_USER\$FOLDER"
$junction_path = "E:\webroot\LocalUser\" + $USER_NAME

# If Not Exist $junction_path
if (-not (Test-Path -Path $junction_path)){
    # Create junction
    cmd.exe /C "mklink /J $junction_path $target_path"
    # Set Permission
    cacls $target_path /T /E /G "${USER_NAME}:F" > $null
    cacls $junction_path /E /G "${USER_NAME}:F" > $null
}

	#cacls E:\webroot\LocalUser\$ORIGIN_USER\$FOLDER /T /E /G "${USER_NAME}:${PERMISSION}"

}elseif( $TYPE -eq "edit" ){

	$NewPassword = ConvertTo-SecureString $USER_PASSWORD -AsPlainText -Force
	Set-LocalUser -Name $USER_NAME -Password $NewPassword

	cacls E:\webroot\LocalUser\$ORIGIN_USER\$FOLDER /T /E /P "${USER_NAME}:${PERMISSION}"

}else{
	 $acl=get-acl E:\webroot\LocalUser\$ORIGIN_USER\$FOLDER
	 $accessrule = New-Object system.security.AccessControl.FileSystemAccessRule($USER_NAME,"Read",,,"Allow")
	 $acl.RemoveAccessRuleAll($accessrule)
	 Set-Acl -Path "E:\webroot\LocalUser\$ORIGIN_USER\$FOLDER" -AclObject $acl
	 Remove-LocalUser -Name $USER_NAME
}
