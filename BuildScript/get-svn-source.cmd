@IF DEFINED %NOECHO% echo off

echo ====== Get Subversion Source code ======
echo ====== Get Subversion Source code ====== > %LOG_DIR%\get-svn-source.log
%SVNBINPATH%\svn co https://svn.apache.org/repos/asf/subversion/tags/%VER% %ROOT%\%DIR% >> %LOG_DIR%\get-svn-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

echo ====== Patch Subversion ======
echo ====== Patch Subversion ====== >> %LOG_DIR%\get-svn-source.log
%SVNBINPATH%\svn patch C:\win32svn\BuildScript\svn.patch %ROOT%\%DIR% >> %LOG_DIR%\get-svn-source.log 2>>&1
IF ERRORLEVEL 1 GOTO PATCH_FAIL

exit /B 0

:CO_FAIL
echo ****** Subversion Checkout failed ****** >> %LOG_DIR%\get-svn-source.log
type %LOG_DIR%\get-svn-source.log
exit /B 1

:PATCH_FAIL
echo ****** Subversion Patch failed ****** >> %LOG_DIR%\get-svn-source.log
type %LOG_DIR%\get-svn-source.log
exit /B 1
