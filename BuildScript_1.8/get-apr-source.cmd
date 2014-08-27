@IF DEFINED NOECHO echo off

echo ====== Get apr Source code ======
echo ====== Get apr Source code ====== > %LOG_DIR%\get-apr-source.log
%SVNBINPATH%\svn co https://svn.apache.org/repos/asf/apr/apr/tags/%APRVER% %ROOT%\%HTTPDDIR%\srclib\apr >> %LOG_DIR%\get-apr-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL
%SVNBINPATH%\svn co https://svn.apache.org/repos/asf/apr/apr-util/tags/%APRUTILVER% %ROOT%\%HTTPDDIR%\srclib\apr-util >> %LOG_DIR%\get-apr-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL
%SVNBINPATH%\svn co https://svn.apache.org/repos/asf/apr/apr-iconv/tags/%APRICONVVER% %ROOT%\%HTTPDDIR%\srclib\apr-iconv >> %LOG_DIR%\get-apr-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL


echo ====== Patch apr ======
echo ====== Patch apr ====== >> %LOG_DIR%\get-apr-source.log
%SVNBINPATH%\svn patch %SCRIPT_DIR%\apr.patch %ROOT%\%HTTPDDIR%\srclib\apr >> %LOG_DIR%\get-apr-source.log 2>>&1
IF ERRORLEVEL 1 GOTO PATCH_FAIL

echo ====== Patch apr-util ======
echo ====== Patch apr-util ====== >> %LOG_DIR%\get-apr-source.log
%SVNBINPATH%\svn patch %SCRIPT_DIR%\apr-util.patch %ROOT%\%HTTPDDIR%\srclib\apr-util >> %LOG_DIR%\get-apr-source.log 2>>&1
IF ERRORLEVEL 1 GOTO PATCH_FAIL

exit /B 0

:CO_FAIL
echo ****** apr Checkout failed ****** >> %LOG_DIR%\get-apr-source.log
type %LOG_DIR%\get-apr-source.log
exit /B 1

:PATCH_FAIL
echo ****** apr Patch failed ****** >> %LOG_DIR%\get-apr-source.log
type %LOG_DIR%\get-apr-source.log
exit /B 1
