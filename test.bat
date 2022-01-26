@echo on


%systemroot%\system32\inetsrv\appcmd.exe set config "maungsaiyannaing1" -section:system.webServer/handlers /-"[name='PHP-FastCGI-v7.3.0-nts',path='*.php',verb='*',modules='FastCgiModule',scriptProcessor='C:\Program Files\PHP\v7.3.0-nts\php-cgi.exe',resourceType='Either']"
%systemroot%\system32\inetsrv\appcmd.exe set config "maungsaiyannaing1" -section:system.webServer/handlers /+"[name='PHP-FastCGI-v7.3.0-nts',path='*.php',verb='*',modules='FastCgiModule',scriptProcessor='C:\Program Files\PHP\v7.3.0-nts\php-cgi.exe',resourceType='Either']"
