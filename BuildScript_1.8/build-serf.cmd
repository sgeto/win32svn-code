@IF DEFINED NOECHO echo off

echo ====== Build serf ======
echo ====== Build serf ====== > %LOG_DIR%\build-serf.log
pushd %ROOT%\serf
IF ERRORLEVEL 1 GOTO DIR_FAIL

echo ----- Build -----
python C:\Python27\scripts\scons.py ^
    APR=%ROOT%\%HTTPDDIR%\srclib\apr ^
    APU=%ROOT%\%HTTPDDIR%\srclib\apr-util ^
    OPENSSL=%ROOT%\%HTTPDDIR%\srclib\openssl ^
    ZLIB=%ROOT%\%HTTPDDIR%\srclib\zlib ^
    PREFIX=%ROOT%\serf\Release ^
    LIBDIR=%ROOT%\serf\Release ^
    CPPFLAGS=/I"C:\Progra~1\Micros~3\include" ^
    LINKFLAGS=/LIBPATH:"C:\Progra~1\Micros~3\lib" ^
	>> %LOG_DIR%\build-serf.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

echo ----- TEST -----
python C:\Python27\scripts\scons.py check >> %LOG_DIR%\build-serf.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL

echo ----- INSTALL -----
python C:\Python27\scripts\scons.py install >> %LOG_DIR%\build-serf.log 2>>&1
IF ERRORLEVEL 1 GOTO INSTALL_FAIL


popd
exit /B 0

:DIR_FAIL
echo ****** serf dir does not exists ******
echo ****** serf dir does not exists ****** >> %LOG_DIR%\build-serf.log
type %LOG_DIR%\build-serf.log
popd
exit /B 1

:BUILD_FAIL
echo ****** serf Build failed ******
echo ****** serf Build failed ****** >> %LOG_DIR%\build-serf.log
type %LOG_DIR%\build-serf.log
popd
exit /B 1

:TEST_FAIL
echo ****** serf TEST failed ******
echo ****** serf TEST failed ****** >> %LOG_DIR%\build-serf.log
type %LOG_DIR%\build-serf.log
popd
exit /B 1

:INSTALL_FAIL
echo ****** serf INSTALL failed ******
echo ****** serf INSTALL failed ****** >> %LOG_DIR%\build-serf.log
type %LOG_DIR%\build-serf.log
popd
exit /B 1
