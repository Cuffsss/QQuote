@echo off
echo Checking Git Status...

"C:\Program Files\Git\bin\git.exe" status
echo.

echo Remote Repositories:
"C:\Program Files\Git\bin\git.exe" remote -v
echo.

pause 