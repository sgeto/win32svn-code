@IF DEFINED %NOECHO% echo off

echo ====== Build zlib ======
echo ====== Build zlib ====== > %LOG_DIR%\build-zlib.log
pushd %ROOT%\%HTTPDDIR%\srclib\zlib
IF ERRORLEVEL 1 GOTO DIR_FAIL

echo ----- Build -----
nmake -f win32\Makefile.msc LOC="-DASMV -DASMINF" OBJA="inffas32.obj match686.obj" >> %LOG_DIR%\build-zlib.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

echo ----- Test -----
nmake -f win32\Makefile.msc test >> %LOG_DIR%\build-zlib.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL

echo ----- Copy -----
copy /Y zlib.lib zlibstat.lib >> %LOG_DIR%\build-zlib.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
popd

exit /B 0


:DIR_FAIL
echo ****** zlib dir does not exists ****** >> %LOG_DIR%\build-zlib.log
type %LOG_DIR%\build-zlib.log
popd
exit /B 1

:BUILD_FAIL
echo ****** zlib build failed ****** >> %LOG_DIR%\build-zlib.log
type %LOG_DIR%\build-zlib.log
popd
exit /B 1

:TEST_FAIL
echo ****** zlib test failed ****** >> %LOG_DIR%\build-zlib.log
type %LOG_DIR%\build-zlib.log
popd
exit /B 1

:COPY_FAIL
echo ****** zlib copy failed ****** >> %LOG_DIR%\build-zlib.log
type %LOG_DIR%\build-zlib.log
popd
exit /B 1
