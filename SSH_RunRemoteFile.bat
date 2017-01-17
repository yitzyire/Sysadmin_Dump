@echo off

choice /M "Connect and Run?"
IF %errorlevel% EQU 1 GOTO flush
IF %errorlevel% EQU 2 GOTO quit
GOTO end

:flush
C:\path\plink.exe root@serveraddress -pw password /opt/whatever/bin/file.sh
rem can add as many connections under 
GOTO end

:quit
echo "Whelp!"

:end
pause
