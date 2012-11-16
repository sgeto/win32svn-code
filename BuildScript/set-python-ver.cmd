@IF DEFINED %NOECHO% echo off

echo ====== Set Python version environment variables ======
set PYTHONVER=%1

for /f "tokens=1,2 delims=/." %%a in ("%PYTHONVER%") do set PYTHONFILEVER=%%a%%b

set PYTHONDIR=C:\Python%PYTHONFILEVER%

set PATHBASE=%PATH%
PATH=%PATHBASE%;%PYTHONDIR%