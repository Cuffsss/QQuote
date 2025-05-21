@echo off
echo Committing changes to GitHub repository...

"C:\Program Files\Git\bin\git.exe" add .
"C:\Program Files\Git\bin\git.exe" commit -m "Clean up installation files and add utility scripts"
"C:\Program Files\Git\bin\git.exe" push

echo.
echo Changes committed and pushed to GitHub!
pause 