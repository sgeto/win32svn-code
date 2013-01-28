@IF DEFINED NOECHO echo off

echo ====== Build svn ruby bindings ======
echo ====== Build svn ruby bindings ====== > %LOG_DIR%\build-svn-ruby.log
pushd %ROOT%\%DIR%
IF ERRORLEVEL 1 GOTO DIR_FAIL

echo ----- Build -----
msdev subversion_msvc.dsw /USEENV /MAKE "__SWIG_RUBY__ - Win32 Release" >> %LOG_DIR%\build-svn-ruby.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

popd
exit /B 0

:DIR_FAIL
echo ****** svn dir does not exists ****** >> %LOG_DIR%\build-svn-ruby.log
type %LOG_DIR%\build-svn-ruby.log
popd
exit /B 1

:BUILD_FAIL
echo ****** svn ruby build failed ****** >> %LOG_DIR%\build-svn-ruby.log
type %LOG_DIR%\build-svn-ruby.log
popd
exit /B 1
