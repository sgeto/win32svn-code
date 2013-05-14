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
rem patch APR for Win2k
del %ROOT%\%HTTPDDIR%\srclib\apr\include\apr.hw.in >> %LOG_DIR%\get-apr-source.log 2>>&1
ren %ROOT%\%HTTPDDIR%\srclib\apr\include\apr.hw apr.hw.in >> %LOG_DIR%\get-apr-source.log 2>>&1
%AWKDIR%\awk.exe "{gsub(/<ws2tcpip.h>/,\"^<ws2tcpip.h^>\n#include ^<wspiapi.h^>\") };1" %ROOT%\%HTTPDDIR%\srclib\apr\include\apr.hw.in > %ROOT%\%HTTPDDIR%\srclib\apr\include\apr.hw 2>> %LOG_DIR%\get-apr-source.log
IF ERRORLEVEL 1 GOTO PATCH_FAIL
rem patch srclib\apr-util\dbd\apr_dbd_odbc.c with 'typedef INT32 SQLLEN;' and 'typedef UINT32 SQLULEN;'  på rad 50
del %ROOT%\%HTTPDDIR%\srclib\apr-util\dbd\apr_dbd_odbc.c.in >> %LOG_DIR%\get-apr-source.log 2>>&1
ren %ROOT%\%HTTPDDIR%\srclib\apr-util\dbd\apr_dbd_odbc.c apr_dbd_odbc.c.in >> %LOG_DIR%\get-apr-source.log 2>>&1
%AWKDIR%\awk.exe "{gsub(/\/\* Driver name/,\"\ntypedef INT32 SQLLEN;\ntypedef UINT32 SQLULEN;\n\/* Driver name\") };1" %ROOT%\%HTTPDDIR%\srclib\apr-util\dbd\apr_dbd_odbc.c.in > %ROOT%\%HTTPDDIR%\srclib\apr-util\dbd\apr_dbd_odbc.c 2>> %LOG_DIR%\get-apr-source.log

exit /B 0

:CO_FAIL
echo ****** apr Checkout failed ****** >> %LOG_DIR%\get-apr-source.log
type %LOG_DIR%\get-apr-source.log
exit /B 1

:PATCH_FAIL
echo ****** apr Patch failed ****** >> %LOG_DIR%\get-apr-source.log
type %LOG_DIR%\get-apr-source.log
exit /B 1
