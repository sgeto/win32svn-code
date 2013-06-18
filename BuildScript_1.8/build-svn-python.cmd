@IF DEFINED NOECHO echo off

echo ====== Build svn python bindings ver %PYTHONVER% ======
echo ====== Build svn python bindings ver %PYTHONVER% ====== > %LOG_DIR%\build-svn-python.%PYTHONVER%.log
pushd %ROOT%\%DIR%
IF ERRORLEVEL 1 GOTO DIR_FAIL

echo ----- Build -----
msdev subversion_msvc.dsw /USEENV /MAKE "__SWIG_PYTHON__ - Win32 Release" >> %LOG_DIR%\build-svn-python.%PYTHONVER%.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

popd
exit /B 0

:DIR_FAIL
echo ****** svn dir does not exists ****** >> %LOG_DIR%\build-svn-python.%PYTHONVER%.log
type %LOG_DIR%\build-svn-python.%PYTHONVER%.log
popd
exit /B 1

:BUILD_FAIL
echo ****** svn python build failed ****** >> %LOG_DIR%\build-svn-python.%PYTHONVER%.log
type %LOG_DIR%\build-svn-python.%PYTHONVER%.log
popd
exit /B 1
