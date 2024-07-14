Stop-Service -Name wuauserv -Force
Remove-Item -Path "C:\Windows\SoftwareDistribution\Download" -Recurse -Force
Start-Service -Name wuauserv
