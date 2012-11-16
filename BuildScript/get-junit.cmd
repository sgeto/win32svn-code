@IF DEFINED %NOECHO% echo off

echo ====== Get junit ======
echo ====== Get junit ====== > %LOG_DIR%\get-junit.log
%WGET% -N --no-check-certificate --directory-prefix=%DLDIR% --no-check-certificate https://github.com/downloads/KentBeck/junit/junit%JUNITVER%.zip >> %LOG_DIR%\get-junit.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

echo ====== Extract junit ======
echo ====== Extract junit ====== >> %LOG_DIR%\get-junit.log
%ZZIP% x -y %DLDIR%\junit%JUNITVER%.zip -o%ROOT% >> %LOG_DIR%\get-junit.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL

exit /B 0

:CO_FAIL
echo ****** junit Checkout failed ****** >> %LOG_DIR%\get-junit.log
type %LOG_DIR%\get-junit.log
exit /B 1

:EXTRACT_FAIL
echo ****** junit Extraction failed ****** >> %LOG_DIR%\get-junit.log
type %LOG_DIR%\get-junit.log
exit /B 1
