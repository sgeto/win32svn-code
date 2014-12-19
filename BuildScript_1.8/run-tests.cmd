@IF DEFINED NOECHO echo off

echo ====== Run tests ======
echo ====== Run tests ====== > %LOG_DIR%\run-tests.log
set PATHORG=%PATH%
PATH=%ROOT%\svn-win32-%VER%\svn-win32-%VER%\bin;%PATH%
pushd %ROOT%\%DIR%

::goto svn

:fsfs
echo ----- Test fsfs ------
echo ----- Test fsfs ------ >> %LOG_DIR%\run-tests.log
echo ----- Logging tests to run-tests-fsfs.log ------ >> %LOG_DIR%\run-tests.log
echo ----- Test fsfs ------ > %LOG_DIR%\run-tests-fsfs.log
python win-tests.py -c -r -v >> %LOG_DIR%\run-tests-fsfs.log 2>>&1
IF ERRORLEVEL 1 GOTO fsfstest_fail
goto fsfssuccess
:fsfstest_fail
set FSFSERROR=1
:fsfssuccess

:bdb
echo ----- Test bdb ------
echo ----- Test bdb ------ >> %LOG_DIR%\run-tests.log
echo ----- Logging tests to run-tests-bdb.log ------ >> %LOG_DIR%\run-tests.log
echo ----- Test bdb ------ > %LOG_DIR%\run-tests-bdb.log
python win-tests.py -c -r -v -f bdb >> %LOG_DIR%\run-tests-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO bdbtest_fail
goto bdbsuccess
:bdbtest_fail
set BDBERROR=1
:bdbsuccess

:svn
echo ----- Test svn ------
echo ----- Test svn ------ >> %LOG_DIR%\run-tests.log
echo ----- Logging tests to run-tests-svn.log ------ >> %LOG_DIR%\run-tests.log
echo ----- Test svn ------ > %LOG_DIR%\run-tests-svn.log
netsh firewall add allowedprogram "%ROOT%\%DIR%\Release\subversion\svnserve\svnserve.exe" svnserve-%VER%-%HTTPDVER% >> %LOG_DIR%\run-tests.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL
python win-tests.py -c -r -v -u svn://localhost >> %LOG_DIR%\run-tests-svn.log 2>>&1
IF ERRORLEVEL 1 GOTO svntest_fail
goto svnsuccess 
:svntest_fail
set SVNERROR=1
:svnsuccess
%SYSINTERNALS%\pskill.exe -t svnserve.exe

:httpd
echo ----- Test http-serf ------
echo ----- Test http-serf ------ >> %LOG_DIR%\run-tests.log
echo ----- Logging tests to run-tests-http-serf.log ------ >> %LOG_DIR%\run-tests.log
echo ----- Test http-serf ------ > %LOG_DIR%\run-tests-http-serf.log
start "HTTPD" "%HTTPDINSTDIR%\bin\httpd.exe" >> %LOG_DIR%\run-tests.log
IF ERRORLEVEL 1 GOTO TEST_FAIL
python win-tests.py -c -r -v -u http://localhost:80%HTTPDVER% >> %LOG_DIR%\run-tests-http-serf.log 2>>&1
IF ERRORLEVEL 1 GOTO httptest_fail
goto httpsuccess 
:httptest_fail
set HTTPERROR=1
:httpsuccess
%SYSINTERNALS%\pskill.exe -t httpd.exe

if defined FSFSERROR goto TEST_FAIL
if defined BDBERROR goto TEST_FAIL
if defined SVNERROR goto TEST_FAIL
if defined HTTPERROR goto TEST_FAIL

:SUCCESS
PATH=%PATHORG%
popd
echo ----- Tests OK ------
echo ----- Tests OK ------ >> %LOG_DIR%\run-tests.log
exit /B 0

:TEST_FAIL
echo ****** Tests failed ****** >> %LOG_DIR%\run-tests.log
if defined FSFSERROR type %LOG_DIR%\run-tests-fsfs.log
if defined BDBERROR type %LOG_DIR%\run-tests-bdb.log
if defined SVNERROR type %LOG_DIR%\run-tests-svn.log
if defined HTTPERROR type %LOG_DIR%\run-tests-http-serf.log

type %LOG_DIR%\run-tests.log
PATH=%PATHORG%
popd
exit /B 1
