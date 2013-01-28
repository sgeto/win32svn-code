@IF DEFINED NOECHO echo off

echo ====== Collect binaries ======
echo ====== Collect binaries ====== > %LOG_DIR%\collect-binaries.log

rem Check that the subversion code exists here.
pushd %ROOT%

set DEST=%ROOT%\svn-win32-%VER%\bin\
set ICONV=%ROOT%\svn-win32-%VER%\iconv\

rmdir /Q /S %ROOT%\svn-win32-%VER% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
mkdir %ROOT%\svn-win32-%VER% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
mkdir %DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
mkdir %ICONV% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL

echo ----- Collect openssl -----
echo ----- Collect openssl ----- >> %LOG_DIR%\collect-binaries.log
copy /Y %ROOT%\%HTTPDDIR%\srclib\openssl\out32dll\libeay32.dll				%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%HTTPDDIR%\srclib\openssl\out32dll\ssleay32.dll				%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%HTTPDDIR%\srclib\openssl\out32dll\openssl.exe				%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL

echo ----- Collect BDB -----
echo ----- Collect BDB ----- >> %LOG_DIR%\collect-binaries.log
copy /Y %BDBDIR%\bin\libdb%BDBVER%.dll										%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL

echo ----- Collect libintl -----
echo ----- Collect libintl ----- >> %LOG_DIR%\collect-binaries.log
copy /Y svn-win32-libintl\bin\intl3_svn.dll									%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL

echo ----- Collect SVN exes -----
echo ----- Collect SVN exes ----- >> %LOG_DIR%\collect-binaries.log
copy /Y %ROOT%\%DIR%\Release\subversion\svn\svn.exe							%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\svnadmin\svnadmin.exe				%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\svndumpfilter\svndumpfilter.exe		%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\svnlook\svnlook.exe					%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\svnserve\svnserve.exe				%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\svnsync\svnsync.exe					%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\svnversion\svnversion.exe			%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\tools\client-side\svnmucc\svnmucc.exe			%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\tools\server-side\svn-populate-node-origins-index.exe %DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\tools\server-side\svnauthz-validate.exe		%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL

echo ----- Collect SVN dlls -----
echo ----- Collect SVN dlls ----- >> %LOG_DIR%\collect-binaries.log
copy /Y %ROOT%\%DIR%\Release\subversion\mod_dav_svn\mod_dav_svn.so			%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\mod_authz_svn\mod_authz_svn.so		%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\libsvn_client\libsvn_client-1.dll	%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\libsvn_delta\libsvn_delta-1.dll		%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\libsvn_diff\libsvn_diff-1.dll		%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\libsvn_fs\libsvn_fs-1.dll			%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\libsvn_ra\libsvn_ra-1.dll			%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\libsvn_repos\libsvn_repos-1.dll		%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\libsvn_subr\libsvn_subr-1.dll		%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%DIR%\Release\subversion\libsvn_wc\libsvn_wc-1.dll			%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL


echo ----- Collect APR -----
echo ----- Collect APR ----- >> %LOG_DIR%\collect-binaries.log
copy /Y %ROOT%\%HTTPDDIR%\srclib\apr\Release\libapr-1.dll				%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%HTTPDDIR%\srclib\apr-iconv\Release\libapriconv-1.dll	%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%HTTPDDIR%\srclib\apr-iconv\Release\iconv\*.so			%ICONV% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\%HTTPDDIR%\srclib\apr-util\Release\libaprutil-1.dll		%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL

echo ----- Collect SASL -----
echo ----- Collect SASL ----- >> %LOG_DIR%\collect-binaries.log
copy /Y %ROOT%\cyrus-sasl-%SASLVER%\utils\pluginviewer.exe					%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\cyrus-sasl-%SASLVER%\utils\sasldblistusers2.exe 				%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\cyrus-sasl-%SASLVER%\utils\saslpasswd2.exe					%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\cyrus-sasl-%SASLVER%\lib\libsasl.dll							%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\cyrus-sasl-%SASLVER%\plugins\saslANONYMOUS.dll				%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\cyrus-sasl-%SASLVER%\plugins\saslDIGESTMD5.dll				%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\cyrus-sasl-%SASLVER%\plugins\saslCRAMMD5.dll					%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\cyrus-sasl-%SASLVER%\plugins\saslLOGIN.dll					%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\cyrus-sasl-%SASLVER%\plugins\saslNTLM.dll					%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\cyrus-sasl-%SASLVER%\plugins\saslPLAIN.dll					%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL
copy /Y %ROOT%\cyrus-sasl-%SASLVER%\plugins\saslSASLDB.dll					%DEST% >> %LOG_DIR%\collect-binaries.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL

popd
exit /B 0

:FAIL
popd
echo ****** Collection of binaries failed ****** >> %LOG_DIR%\collect-binaries.log
type %LOG_DIR%\collect-binaries.log
exit /B 1
