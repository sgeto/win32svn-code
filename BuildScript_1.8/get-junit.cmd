@IF DEFINED NOECHO echo off

echo ====== Get junit ======
echo ====== Get junit ====== > %LOG_DIR%\get-junit.log
rmdir /S /Q %JUNITDIR% >> %LOG_DIR%\get-junit.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL
mkdir %JUNITDIR% >> %LOG_DIR%\get-junit.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

%WGET% -O %JUNITDIR%\junit-%JUNITVER%.jar "http://search.maven.org/remotecontent?filepath=junit/junit/%JUNITVER%/junit-%JUNITVER%.jar" >> %LOG_DIR%\get-junit.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

exit /B 0

:CO_FAIL
echo ****** junit Checkout failed ****** >> %LOG_DIR%\get-junit.log
type %LOG_DIR%\get-junit.log
exit /B 1
