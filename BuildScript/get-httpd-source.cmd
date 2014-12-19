@IF DEFINED NOECHO echo off

echo ====== Get httpd Source code ======
echo ====== Get httpd Source code ====== > %LOG_DIR%\get-httpd-source.log
%SVNBINPATH%\svn co https://svn.apache.org/repos/asf/httpd/httpd/tags/%HTTPDFULLVER% %ROOT%\%HTTPDDIR% >> %LOG_DIR%\get-httpd-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

echo ====== Patch httpd ======
echo ====== Patch httpd ====== >> %LOG_DIR%\get-httpd-source.log

IF NOT %HTTPDVER%==22 GOTO SKIP_PATCH_22
echo ====== Patch httpd 2.2 ======
echo ====== Patch httpd 2.2 ====== >> %LOG_DIR%\get-httpd-source.log
%SVNBINPATH%\svn patch %SCRIPT_DIR%\httpd_22.patch %ROOT%\%HTTPDDIR% >> %LOG_DIR%\get-httpd-source.log 2>>&1
IF ERRORLEVEL 1 GOTO PATCH_FAIL

:SKIP_PATCH_22
IF NOT %HTTPDVER%==24 GOTO SKIP_PATCH_24
echo ====== Patch httpd 2.4 ======
echo ====== Patch httpd 2.4 ====== >> %LOG_DIR%\get-httpd-source.log
%SVNBINPATH%\svn patch %SCRIPT_DIR%\httpd_24.patch %ROOT%\%HTTPDDIR% >> %LOG_DIR%\get-httpd-source.log 2>>&1
IF ERRORLEVEL 1 GOTO PATCH_FAIL

:SKIP_PATCH_24

exit /B 0

:CO_FAIL
echo ****** httpd Checkout failed ****** >> %LOG_DIR%\get-httpd-source.log
type %LOG_DIR%\get-httpd-source.log
exit /B 1

:PATCH_FAIL
echo ****** httpd Patch failed ****** >> %LOG_DIR%\get-httpd-source.log
type %LOG_DIR%\get-httpd-source.log
exit /B 1
