@IF DEFINED NOECHO echo off

echo ====== Get openssl Source code ======
echo ====== Get openssl Source code ====== > %LOG_DIR%\get-openssl-source.log
%WGET% -N --directory-prefix=%DLDIR% http://www.openssl.org/source/openssl-%OPENSSLVER%.tar.gz >> %LOG_DIR%\get-openssl-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

echo ====== Extract openssl ======
echo ====== Extract openssl ====== >> %LOG_DIR%\get-openssl-source.log
%ZZIP% x -y %DLDIR%\openssl-%OPENSSLVER%.tar.gz -o%DLDIR% >> %LOG_DIR%\get-openssl-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL
%ZZIP% x -y %DLDIR%\openssl-%OPENSSLVER%.tar -o%ROOT%\%HTTPDDIR%\srclib\ >> %LOG_DIR%\get-openssl-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL
rmdir /Q /S %ROOT%\%HTTPDDIR%\srclib\openssl >> %LOG_DIR%\get-openssl-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL
ren %ROOT%\%HTTPDDIR%\srclib\openssl-%OPENSSLVER% openssl >> %LOG_DIR%\get-openssl-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL

exit /B 0

:CO_FAIL
echo ****** openssl Checkout failed ****** >> %LOG_DIR%\get-openssl-source.log
type %LOG_DIR%\get-openssl-source.log
exit /B 1

:EXTRACT_FAIL
echo ****** openssl Extraction failed ****** >> %LOG_DIR%\get-openssl-source.log
type %LOG_DIR%\get-openssl-source.log
exit /B 1
