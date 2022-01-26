Param([string] $site,[string] $ip,[string] $action)
if($action -eq 'new'){
   Add-WebConfigurationProperty -Filter 'system.webServer/security/ipSecurity' -PSPath "IIS:\" -Location $site -Name "." -Value @{ipAddress=$ip;allowed="false";} -ErrorAction Stop
} else {
   Remove-WebConfigurationProperty -Location $site -filter /system.webServer/security/ipSecurity -Name '.' -AtElement @{ipAddress=$ip;allowed="False"}
}
