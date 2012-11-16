@IF DEFINED %NOECHO% echo off

echo ====== Get Cyrus SASL Source code ======
echo ====== Get Cyrus SASL Source code ====== > %LOG_DIR%\get-sasl-source.log
%WGET% -N --directory-prefix=%DLDIR% http://ftp.andrew.cmu.edu/pub/cyrus-mail/cyrus-sasl-%SASLVER%.tar.gz >> %LOG_DIR%\get-sasl-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

echo ====== Extract Cyrus SASL ======
echo ====== Extract Cyrus SASL ====== >> %LOG_DIR%\get-sasl-source.log
%ZZIP% x -y %DLDIR%\cyrus-sasl-%SASLVER%.tar.gz -o%DLDIR% >> %LOG_DIR%\get-sasl-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL
%ZZIP% x -y %DLDIR%\cyrus-sasl-%SASLVER%.tar -o%ROOT% >> %LOG_DIR%\get-sasl-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL
del %ROOT%\cyrus-sasl-%SASLVER%\win32\common.mak.in >> %LOG_DIR%\get-sasl-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL
ren %ROOT%\cyrus-sasl-%SASLVER%\win32\common.mak common.mak.in >> %LOG_DIR%\get-sasl-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL


echo ====== Patch Cyrus SASL ======
echo ====== Patch Cyrus SASL ====== >> %LOG_DIR%\get-sasl-source.log
%AWKDIR%\awk.exe "{gsub(/#VCVER=6/,\"VCVER=6\") };1" %ROOT%\cyrus-sasl-%SASLVER%\win32\common.mak.in > %ROOT%\cyrus-sasl-%SASLVER%\win32\common.mak 2>> %LOG_DIR%\get-sasl-source.log
IF ERRORLEVEL 1 GOTO PATCH_FAIL

exit /B 0

:CO_FAIL
echo ****** Cyrus SASL Checkout failed ****** >> %LOG_DIR%\get-sasl-source.log
type %LOG_DIR%\get-sasl-source.log
exit /B 1

:PATCH_FAIL
echo ****** Cyrus SASL Patch failed ****** >> %LOG_DIR%\get-sasl-source.log
type %LOG_DIR%\get-sasl-source.log
exit /B 1
