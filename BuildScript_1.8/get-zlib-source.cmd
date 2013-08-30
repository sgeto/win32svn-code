@IF DEFINED NOECHO echo off

echo ====== Get zlib Source code ======
echo ====== Get zlib Source code ====== > %LOG_DIR%\get-zlib-source.log
%WGET% -N --directory-prefix=%DLDIR% http://zlib.net/zlib%ZLIBFILEVER%.zip >> %LOG_DIR%\get-zlib-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

echo ====== Extract zlib ======
echo ====== Extract zlib ====== >> %LOG_DIR%\get-zlib-source.log
%ZZIP% x -y %DLDIR%\zlib%ZLIBFILEVER%.zip -o%ROOT%\%HTTPDDIR%\srclib\ >> %LOG_DIR%\get-zlib-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL
rmdir /Q /S %ROOT%\%HTTPDDIR%\srclib\zlib >> %LOG_DIR%\get-zlib-source.log 2>>&1
ren %ROOT%\%HTTPDDIR%\srclib\zlib-%ZLIBVER% zlib >> %LOG_DIR%\get-zlib-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL

exit /B 0

:CO_FAIL
echo ****** zlib Checkout failed ****** >> %LOG_DIR%\get-zlib-source.log
type %LOG_DIR%\get-zlib-source.log
exit /B 1

:EXTRACT_FAIL
echo ****** zlib Extraction failed ****** >> %LOG_DIR%\get-zlib-source.log
type %LOG_DIR%\get-zlib-source.log
exit /B 1
