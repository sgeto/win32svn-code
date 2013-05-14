@IF DEFINED NOECHO echo off

echo ====== Build sasl ======
echo ====== Build sasl ====== > %LOG_DIR%\build-sasl.log
pushd %ROOT%\cyrus-sasl-%SASLVER%
IF ERRORLEVEL 1 GOTO DIR_FAIL

set VERBOSE=1
set prefix=%ROOT%\cyrus-sasl-%SASLVER%\Build
set CFG=%MODE%
set DB_LIB=libdb%BDBVER%.lib
set DB_INCLUDE=%ROOT%\db-%BDBFULLVER%\build_windows
set DB_LIBPATH=%ROOT%\db-%BDBFULLVER%\build_windows\Win32\%MODE%
set OPENSSL_INCLUDE=%ROOT%\%HTTPDDIR%\srclib\openssl\inc32
set OPENSSL_LIBPATH=%ROOT%\%HTTPDDIR%\srclib\openssl\out32dll
set GSSAPI=CyberSafe 
set GSSAPI_INCLUDE=C:\Program Files\CyberSafe\Developer Pack\ApplicationSecuritySDK\include
set GSSAPI_LIBPATH=C:\Program Files\CyberSafe\Developer Pack\ApplicationSecuritySDK\lib
::set SQL=SQLITE
::set SQLITE_INCLUDES=/I%ROOT%\%DIR%\sqlite-amalgamation
::set SQLITE_LIBPATH=%ROOT%\%DIR%\sqlite-amalgamation
set LDAP_LIB_BASE=c:\work\open_source\openldap\openldap-head\ldap\Debug
set LDAP_INCLUDE=c:\work\open_source\openldap\openldap-head\ldap\include
set NTLM=1
set SRP=1
set DO_SRP_SETPASS=1
set OTP=1

echo ----- Build -----
nmake /f NTMakefile >> %LOG_DIR%\build-sasl.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL
popd
exit /B 0


:DIR_FAIL
echo ****** sasl dir does not exists ****** >> %LOG_DIR%\build-sasl.log
type %LOG_DIR%\build-sasl.log
popd
exit /B 1

:BUILD_FAIL
echo ****** sasl build failed ****** >> %LOG_DIR%\build-sasl.log
type %LOG_DIR%\build-sasl.log
popd
exit /B 1
