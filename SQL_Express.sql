@echo off
del C:\UNC_PATH\db\*.bak
SQLCMD.EXE -S .\SQLEXPRESS -Q "EXEC sp_BackupDatabases @backupLocation='C:\UNC_PATH\db\', @backupType='F'"
rem optional
Move "C:\UNC_PATH\db\*.bak" "\\UNC_PATH\Backups"
