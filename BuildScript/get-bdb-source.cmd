@IF DEFINED NOECHO echo off

echo ====== Get bdb Source code ======
echo ====== Get bdb Source code  ====== > %LOG_DIR%\get-bdb-source.log
%WGET% -N --directory-prefix=%DLDIR% --no-check-certificate http://download.oracle.com/berkeley-db/db-%BDBFULLVER%.zip >> %LOG_DIR%\get-bdb-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

echo ====== Extract bdb ======
echo ====== Extract bdb ====== >> %LOG_DIR%\get-bdb-source.log
%ZZIP% x -y %DLDIR%\db-%BDBFULLVER%.zip -o%ROOT% >> %LOG_DIR%\get-bdb-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL

exit /B 0

:CO_FAIL
echo ****** bdb Checkout failed ****** >> %LOG_DIR%\get-bdb-source.log
type %LOG_DIR%\get-bdb-source.log
exit /B 1

:EXTRACT_FAIL
echo ****** bdb Extraction failed ****** >> %LOG_DIR%\get-bdb-source.log
type %LOG_DIR%\get-bdb-source.log
exit /B 1
