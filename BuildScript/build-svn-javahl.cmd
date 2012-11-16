@IF DEFINED %NOECHO% echo off

echo ====== Build svn javahl bindings ======
echo ====== Build svn javahl bindings ====== > %LOG_DIR%\build-svn-javahl.log
pushd %ROOT%\%DIR%
IF ERRORLEVEL 1 GOTO DIR_FAIL

echo ----- Build -----
msdev subversion_msvc.dsw /USEENV /MAKE "__JAVAHL__ - Win32 Release" >> %LOG_DIR%\build-svn-javahl.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

echo ----- Build test -----
msdev subversion_msvc.dsw /USEENV /MAKE "test_javahl - Win32 Release" >> %LOG_DIR%\build-svn-javahl.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_TEST_FAIL

popd
exit /B 0

:DIR_FAIL
echo ****** svn dir does not exists ****** >> %LOG_DIR%\build-svn-javahl.log
type %LOG_DIR%\build-svn-javahl.log
popd
exit /B 1

:BUILD_FAIL
echo ****** svn javahl build failed ****** >> %LOG_DIR%\build-svn-javahl.log
type %LOG_DIR%\build-svn-javahl.log
popd
exit /B 1

:BUILD_TEST_FAIL
echo ****** svn javahl-test build failed ****** >> %LOG_DIR%\build-svn-javahl.log
type %LOG_DIR%\build-svn-javahl.log
popd
exit /B 1
