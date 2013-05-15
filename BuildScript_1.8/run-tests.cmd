@IF DEFINED NOECHO echo off

echo ====== Run tests ======
echo ====== Run tests ====== > %LOG_DIR%\run-tests.log
set PATHORG=%PATH%
PATH=%ROOT%\svn-win32-%VER%\svn-win32-%VER%\bin;%PATH%
pushd %ROOT%\%DIR%


echo ----- Test fsfs ------
echo ----- Test fsfs ------ >> %LOG_DIR%\run-tests.log
echo ----- Logging tests to run-tests-fsfs.log ------ >> %LOG_DIR%\run-tests.log
echo ----- Test fsfs ------ > %LOG_DIR%\run-tests-fsfs.log
python win-tests.py -c -r -v >> %LOG_DIR%\run-tests-fsfs.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL

echo ----- Test bdb ------
echo ----- Test bdb ------ >> %LOG_DIR%\run-tests.log
echo ----- Logging tests to run-tests-bdb.log ------ >> %LOG_DIR%\run-tests.log
echo ----- Test bdb ------ > %LOG_DIR%\run-tests-bdb.log
python win-tests.py -c -r -v -f bdb >> %LOG_DIR%\run-tests-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL

echo ----- Test svn ------
echo ----- Test svn ------ >> %LOG_DIR%\run-tests.log
echo ----- Logging tests to run-tests-svn.log ------ >> %LOG_DIR%\run-tests.log
echo ----- Test svn ------ > %LOG_DIR%\run-tests-svn.log
netsh firewall add allowedprogram "%ROOT%\%DIR%\Release\subversion\svnserve\svnserve.exe" svnserve-%VER%-%HTTPDVER% >> %LOG_DIR%\run-tests.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL
python win-tests.py -c -r -v -u svn://localhost >> %LOG_DIR%\run-tests-svn.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL
%SYSINTERNALS%\pskill.exe -t svnserve.exe

echo ----- Test http-serf ------
echo ----- Test http-serf ------ >> %LOG_DIR%\run-tests.log
echo ----- Logging tests to run-tests-http-serf.log ------ >> %LOG_DIR%\run-tests.log
echo ----- Test http-serf ------ > %LOG_DIR%\run-tests-http-serf.log
start "HTTPD" "%HTTPDINSTDIR%\bin\httpd.exe" >> %LOG_DIR%\run-tests.log
IF ERRORLEVEL 1 GOTO TEST_FAIL
python win-tests.py -c -r -v -u http://localhost:80%HTTPDVER% >> %LOG_DIR%\run-tests-http-serf.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL

PATH=%PATHORG%
popd
exit /B 0

:TEST_FAIL
echo ****** Tests failed ****** >> %LOG_DIR%\run-tests.log
type %LOG_DIR%\run-tests.log
PATH=%PATHORG%
popd
exit /B 1
