@echo off
cd /d "%~dp0"

echo ===============================
echo        GIT ADD COMMIT PUSH
echo ===============================
echo.

git status
echo.

set "MSG="
set /p MSG=Commit message (ENTER = Update local changes): 

if "%MSG%"=="" set "MSG=Update local changes"

echo.
echo Using commit message:
echo "%MSG%"
echo.

git add .
if errorlevel 1 goto :err

git commit -m "%MSG%"
REM Jesli nie ma zmian, commit moze zwrocic blad - to OK.

git push
if errorlevel 1 goto :err

echo.
echo DONE.
pause
exit /b 0

:err
echo.
echo ERROR: cos poszlo nie tak (sprawdz output powyzej).
pause
exit /b 1
