@IF DEFINED NOECHO echo off

echo ====== Build svn main ======
echo ====== Build svn main  ====== > %LOG_DIR%\build-svn-main.log
pushd %ROOT%\%DIR%
IF ERRORLEVEL 1 GOTO DIR_FAIL

echo ----- Build -----
msdev subversion_msvc.dsw /USEENV /MAKE "__ALL_TESTS__ - Win32 Release" >> %LOG_DIR%\build-svn-main.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

popd
exit /B 0

:DIR_FAIL
echo ****** svn dir does not exists ****** >> %LOG_DIR%\build-svn-main.log
type %LOG_DIR%\build-svn-main.log
popd
exit /B 1

:BUILD_FAIL
echo ****** svn main build failed ****** >> %LOG_DIR%\build-svn-main.log
type %LOG_DIR%\build-svn-main.log
popd
exit /B 1
