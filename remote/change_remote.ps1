$DCs = Get-ADComputer -Filter * -SearchBase "CN=Computers,DC=VIRT,DC=LAB"
Foreach ($DC in $DCs) {
Invoke-Command -ComputerName $DC.Name -ScriptBlock {
param ($DC)
Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\" -Name PortNumber | Select-Object PortNumber
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\" -Name PortNumber -Value 3395
New-NetFirewallRule -DisplayName "Remote Desktop - User Mode (TCP-In) 3395" -Direction Inbound –Protocol TCP -Profile Any –LocalPort 3395 -Action allow
New-NetFirewallRule -DisplayName "Remote Desktop - User Mode (UDP-In) 3395" -Direction Inbound –Protocol UDP -Profile Any –LocalPort 3395 -Action allow
[ValidateSet('Yes','No')]$Answer = Read-Host "`nAre you sure you want to restart $($DC.Name) ? Enter Yes/No"
If ($Answer -eq 'Yes') { Restart-Computer -Force }
 } -ArgumentList $DC
}