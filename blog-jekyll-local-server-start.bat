@echo off
cd /d "%~dp0"

echo ===============================
echo   JEKYLL LOCAL SERVER START
echo ===============================
echo.

bundle exec jekyll serve --livereload

echo.
echo Server stopped.
pause
