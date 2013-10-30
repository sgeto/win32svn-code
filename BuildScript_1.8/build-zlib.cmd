@IF DEFINED NOECHO echo off

echo ====== Build zlib ======
echo ====== Build zlib ====== > %LOG_DIR%\build-zlib.log
pushd %ROOT%\%HTTPDDIR%\srclib\zlib
IF ERRORLEVEL 1 GOTO DIR_FAIL


if /I NOT %MODE%==Debug goto Build

echo ----- Patch for debug -----
copy /Y win32\Makefile.msc win32\Makefile.msc.in >> %LOG_DIR%\gbuild-zlib.log 2>>&1
IF ERRORLEVEL 1 GOTO PATCH_FAIL
%AWKDIR%\awk.exe "{gsub(/STATICLIB = zlib.lib/,\"STATICLIB = zlibD.lib\") }; 1" win32\Makefile.msc.in > win32\Makefile.msc.1 2>> %LOG_DIR%\build-zlib.log 
IF ERRORLEVEL 1 GOTO PATCH_FAIL
%AWKDIR%\awk.exe "{gsub(/SHAREDLIB = zlib1.dll/,\"SHAREDLIB = zlib1D.dll\") }; 1" win32\Makefile.msc.1 > win32\Makefile.msc.2 2>> %LOG_DIR%\build-zlib.log
IF ERRORLEVEL 1 GOTO PATCH_FAIL
%AWKDIR%\awk.exe "{gsub(/IMPLIB    = zdll.lib/,\"IMPLIB    = zdllD.lib\") } 1" win32\Makefile.msc.2 > win32\Makefile.msc.3 2>> %LOG_DIR%\build-zlib.log
IF ERRORLEVEL 1 GOTO PATCH_FAIL
%AWKDIR%\awk.exe "{gsub(/-MD/,\"-MDd\") }; 1" win32\Makefile.msc.3 > win32\Makefile.msc.4 2>> %LOG_DIR%\build-zlib.log
IF ERRORLEVEL 1 GOTO PATCH_FAIL
%AWKDIR%\awk.exe "{gsub(/WFLAGS  = /,\"WFLAGS  = -D_DEBUG \") }; 1" win32\Makefile.msc.4 > win32\Makefile.msc 2>> %LOG_DIR%\build-zlib.log
IF ERRORLEVEL 1 GOTO PATCH_FAIL


:Build
echo ----- Clean -----
nmake -f win32\Makefile.msc clean >> %LOG_DIR%\build-zlib.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

echo ----- Build -----
:nmake -f win32\Makefile.msc LOC="-DASMV -DASMINF" OBJA="inffas32.obj match686.obj" >> %LOG_DIR%\build-zlib.log 2>>&1
nmake -f win32\Makefile.msc >> %LOG_DIR%\build-zlib.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

echo ----- Test -----
nmake -f win32\Makefile.msc test >> %LOG_DIR%\build-zlib.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL

echo ----- Copy -----
if /I %MODE%==Debug goto CopyDebug
copy /Y zlib.lib zlibstat.lib >> %LOG_DIR%\build-zlib.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
goto CopyExit
:CopyDebug
copy /Y zlibD.lib zlibstatD.lib >> %LOG_DIR%\build-zlib.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
:CopyExit


if /I NOT %MODE%==Debug goto BuildExit
echo ----- UnPatch for debug -----
copy /Y win32\Makefile.msc.in win32\Makefile.msc >> %LOG_DIR%\gbuild-zlib.log 2>>&1
IF ERRORLEVEL 1 GOTO PATCH_FAIL
del /Q win32\Makefile.msc.1
IF ERRORLEVEL 1 GOTO PATCH_FAIL
del /Q win32\Makefile.msc.2
IF ERRORLEVEL 1 GOTO PATCH_FAIL
del /Q win32\Makefile.msc.3
IF ERRORLEVEL 1 GOTO PATCH_FAIL
del /Q win32\Makefile.msc.4
IF ERRORLEVEL 1 GOTO PATCH_FAIL
del /Q win32\Makefile.msc.in
IF ERRORLEVEL 1 GOTO PATCH_FAIL


:BuildExit

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

:PATCH_FAIL
echo ****** zlib debug patch failed ****** >> %LOG_DIR%\build-zlib.log
type %LOG_DIR%\build-zlib.log
popd
exit /B 1
