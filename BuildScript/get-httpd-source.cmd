@IF DEFINED NOECHO echo off

echo ====== Get httpd Source code ======
echo ====== Get httpd Source code ====== > %LOG_DIR%\get-httpd-source.log
%SVNBINPATH%\svn co https://svn.apache.org/repos/asf/httpd/httpd/tags/%HTTPDFULLVER% %ROOT%\%HTTPDDIR% >> %LOG_DIR%\get-httpd-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

echo ====== Patch httpd ======
echo ====== Patch httpd ====== >> %LOG_DIR%\get-httpd-source.log
IF NOT %HTTPDVER%==22 GOTO SKIP_PATCH
rem remove references to openssl\store.h in mod_ssl\mod_ssl.dep
del %ROOT%\%HTTPDDIR%\modules\ssl\mod_ssl.dep.in >> %LOG_DIR%\get-httpd-source.log 2>>&1
ren %ROOT%\%HTTPDDIR%\modules\ssl\mod_ssl.dep mod_ssl.dep.in >> %LOG_DIR%\get-httpd-source.log 2>>&1
%AWKDIR%\awk.exe "!/store.h/" %ROOT%\%HTTPDDIR%\modules\ssl\mod_ssl.dep.in > %ROOT%\%HTTPDDIR%\modules\ssl\mod_ssl.dep 2>> %LOG_DIR%\get-httpd-source.log
IF ERRORLEVEL 1 GOTO PATCH_FAIL

:SKIP_PATCH

exit /B 0

:CO_FAIL
echo ****** httpd Checkout failed ****** >> %LOG_DIR%\get-httpd-source.log
type %LOG_DIR%\get-httpd-source.log
exit /B 1

:PATCH_FAIL
echo ****** httpd Patch failed ****** >> %LOG_DIR%\get-httpd-source.log
type %LOG_DIR%\get-httpd-source.log
exit /B 1
