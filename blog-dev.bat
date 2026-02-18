@echo off
setlocal

REM === Ścieżki lokalnych repozytoriów bloga ===
set "PL=E:\OneDrive - Politechnika Warszawska\!GitHub\blog-pl"
set "EN=E:\OneDrive - Politechnika Warszawska\!GitHub\blog-en"

REM === Ścieżka do Double Commander ===
set "DC=E:\Program files\Double Commander\doublecmd.exe"

REM === Ścieżka do Google Chrome ===
set "CHROME=C:\Program Files\Google\Chrome\Application\chrome.exe"

REM === CMD – po jednym oknie na repo ===
start "BLOG-PL" cmd /k "cd /d ""%PL%"""
start "BLOG-EN" cmd /k "cd /d ""%EN%"""

REM === Double Commander (lewy=blog_pl, prawy=blog_en) ===
start "DoubleCommander" "%DC%" -C "%PL%" "%EN%"

REM === Chrome – otwarcie bloga ===
start "Chrome-Blog" "%CHROME%" "https://blog.marcinszewczyk.net"

endlocal
