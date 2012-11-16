@IF DEFINED %NOECHO% echo off

echo ====== Build openssl ======
echo ====== Build openssl ====== > %LOG_DIR%\build-openssl.log
pushd %ROOT%\%HTTPDDIR%\srclib\openssl
IF ERRORLEVEL 1 GOTO DIR_FAIL

echo ----- Configure -----
perl Configure VC-WIN32 >> %LOG_DIR%\build-openssl.log 2>>&1
IF ERRORLEVEL 1 GOTO CONFIG_FAIL

echo ----- NASM -----
call ms\do_nasm >> %LOG_DIR%\build-openssl.log 2>>&1
IF ERRORLEVEL 1 GOTO NASM_FAIL

echo ----- MAKE -----
nmake -f ms\ntdll.mak >> %LOG_DIR%\build-openssl.log 2>>&1
IF ERRORLEVEL 1 GOTO MAKE_FAIL

echo ----- TEST -----
cd out32dll
call ..\ms\test >> %LOG_DIR%\build-openssl.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL
popd

exit /B 0

:DIR_FAIL
echo ****** openssl dir does not exists ****** >> %LOG_DIR%\build-openssl.log
type %LOG_DIR%\build-openssl.log
popd
exit /B 1

:CONFIG_FAIL
echo ****** openssl config failed ****** >> %LOG_DIR%\build-openssl.log
type %LOG_DIR%\build-openssl.log
popd
exit /B 1

:NASM_FAIL
echo ****** openssl NASM failed ****** >> %LOG_DIR%\build-openssl.log
type %LOG_DIR%\build-openssl.log
popd
exit /B 1

:MAKE_FAIL
echo ****** openssl MAKE failed ****** >> %LOG_DIR%\build-openssl.log
type %LOG_DIR%\build-openssl.log
popd
exit /B 1

:TEST_FAIL
echo ****** openssl TEST failed ****** >> %LOG_DIR%\build-openssl.log
type %LOG_DIR%\build-openssl.log
popd
exit /B 1
