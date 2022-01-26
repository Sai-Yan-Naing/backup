netsh advfirewall firewall set rule name="Remote Desktop - User Mode (TCP-In)" new remoteip=8.8.8.8


netsh advfirewall firewall set rule name="Remote Desktop ( 3389 )" new remoteip=8.8.8.8


netsh advfirewall firewall delete rule name="Remote Desktop ( 3389 )" protocol=TCP localport=3389

netsh advfirewall firewall add rule name="Remote Desktop ( 3389 )" dir=in action=allow protocol=TCP localport=6624