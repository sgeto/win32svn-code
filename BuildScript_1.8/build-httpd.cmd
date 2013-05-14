@IF DEFINED NOECHO echo off

echo ====== Build httpd ======
echo ====== Build httpd ====== > %LOG_DIR%\build-httpd.log
pushd %ROOT%
IF ERRORLEVEL 1 GOTO DIR_FAIL

echo ----- Configure -----
%HTTPDDIR%\srclib\apr-util\build\w32locatedb.pl dll %BDBDIR%\include %BDBDIR%\lib >> %LOG_DIR%\build-httpd.log 2>>&1
IF ERRORLEVEL 1 GOTO CONFIG_FAIL

echo ----- Build -----
msdev %HTTPDDIR%\apache.dsw /MAKE "BuildBin - Win32 %MODE%" >> %LOG_DIR%\build-httpd.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

popd
exit /B 0

:DIR_FAIL
echo ****** httpd dir does not exists ****** >> %LOG_DIR%\build-httpd.log
type %LOG_DIR%\build-httpd.log
popd
exit /B 1

:CONFIG_FAIL
echo ****** httpd configure failed ****** >> %LOG_DIR%\build-httpd.log
type %LOG_DIR%\build-httpd.log
popd
exit /B 1

:BUILD_FAIL
echo ****** httpd build failed ****** >> %LOG_DIR%\build-httpd.log
type %LOG_DIR%\build-httpd.log
popd
exit /B 1
