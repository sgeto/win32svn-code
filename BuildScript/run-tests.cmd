@IF DEFINED NOECHO echo off

echo ====== Run tests ======
echo ====== Run tests ====== > %LOG_DIR%\run-tests.log
set PATHORG=%PATH%
PATH=%ROOT%\svn-win32-%VER%\svn-win32-%VER%\bin;%PATH%
pushd %ROOT%\%DIR%

::goto BDB

:FSFS
echo ----- Test fsfs ------
echo ----- Test fsfs ------ >> %LOG_DIR%\run-tests.log
python win-tests.py -c -r -v >> %LOG_DIR%\run-tests.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL

:BDB
echo ----- Test bdb ------
echo ----- Test bdb ------ >> %LOG_DIR%\run-tests.log
python win-tests.py -c -r -v -f bdb >> %LOG_DIR%\run-tests.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL

:SVN
echo ----- Test svn ------
echo ----- Test svn ------ >> %LOG_DIR%\run-tests.log
netsh firewall add allowedprogram "%ROOT%\%DIR%\Release\subversion\svnserve\svnserve.exe" svnserve-%VER%-%HTTPDVER% >> %LOG_DIR%\run-tests.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL
python win-tests.py -c -r -v -u svn://127.0.0.1 >> %LOG_DIR%\run-tests.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL
%SYSINTERNALS%\pskill.exe -t svnserve.exe

:NEON
start "HTTPD" "%HTTPDINSTDIR%\bin\httpd.exe"
echo ----- Test http-neon ------
echo ----- Test http-neon ------ >> %LOG_DIR%\run-tests.log
python win-tests.py -c -r -v -u http://127.0.0.1:80%HTTPDVER% --http-library=neon --httpd-version=%HTTPDFULLVER% >> %LOG_DIR%\run-tests.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL

:SERF
start "HTTPD" "%HTTPDINSTDIR%\bin\httpd.exe"
echo ----- Test http-serf ------
echo ----- Test http-serf ------ >> %LOG_DIR%\run-tests.log
python win-tests.py -c -r -v -u http://127.0.0.1:80%HTTPDVER% --http-library=serf --httpd-version=%HTTPDFULLVER% >> %LOG_DIR%\run-tests.log 2>>&1
IF ERRORLEVEL 1 GOTO TEST_FAIL

:END
PATH=%PATHORG%
popd
exit /B 0

:TEST_FAIL
echo ****** Tests failed ****** >> %LOG_DIR%\run-tests.log
type %LOG_DIR%\run-tests.log
PATH=%PATHORG%
popd
exit /B 1
