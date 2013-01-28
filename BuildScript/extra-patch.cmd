@IF DEFINED NOECHO echo off

echo ====== Extra Patch ======
echo ====== Extra Patch ====== > %LOG_DIR%\extra-patch.log
%SVNBINPATH%\svn merge -r1397427:1397428 https://svn.apache.org/repos/asf/subversion/branches/1.7.x %ROOT%\src-%VER%\  >> %LOG_DIR%\extra-patch.log 2>>&1
IF ERRORLEVEL 1 GOTO PATCH_FAIL

exit /B 0


:PATCH_FAIL
echo ****** Extra Patch failed ****** >> %LOG_DIR%\extra-patch.log
type %LOG_DIR%\extra-patch.log
exit /B 1
