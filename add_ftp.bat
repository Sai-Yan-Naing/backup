@echo on

powershell -Command "Start-Process PowerShell –Verb RunAs -ArgumentList ""-File E:\scripts\create_ftp_main.ps1  %1 %2 %3 %4 %5"""
rem powershell -Command "Start-Process PowerShell –Verb RunAs -ArgumentList ""-File E:\scripts\create_ftp_main.ps1  ethical_sai9 welcome mgmg F new"""
