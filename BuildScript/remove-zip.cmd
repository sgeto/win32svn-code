@IF DEFINED NOECHO echo off

echo ====== Remove zip ======
echo ====== Remove zip ====== > %LOG_DIR%\remove-zip.log

echo ------ Remove old dirs -----
echo ------ Remove old dirs ----- >> %LOG_DIR%\create-zip.log
rmdir /S /Q %ROOT%\svn-win32-%VER% >> %LOG_DIR%\create-zip.log 2>>&1
IF ERRORLEVEL 1 GOTO CLEAN_FAIL

echo ====== Remove zip success ======
echo ====== Remove zip success ====== >> %LOG_DIR%\create-zip.log
exit /B 0


:CLEAN_FAIL
echo ****** remove of old dirs failed ****** >> %LOG_DIR%\create-zip.log
type %LOG_DIR%\create-zip.log
popd
exit /B 1
