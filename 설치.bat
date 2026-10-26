@echo off
rem Download the latest installer from GitHub and run it
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol='Tls12'; Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/thesleff2000/minecamp/main/install.ps1' -OutFile $env:TEMP\tsmine-install.ps1" || (echo [FAIL] Could not download installer. Check internet. & pause & exit /b 1)
powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\tsmine-install.ps1"
pause
