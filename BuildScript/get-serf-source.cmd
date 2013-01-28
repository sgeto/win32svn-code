@IF DEFINED NOECHO echo off

echo ====== Get Serf Source code ======
echo ====== Get Serf Source code ====== > %LOG_DIR%\get-serf-source.log
rem Get Serf Source code
%SVNBINPATH%\svn co http://serf.googlecode.com/svn/tags/%SERFVER% %ROOT%\%DIR%\serf >> %LOG_DIR%\get-serf-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

exit /B 0

:CO_FAIL
echo ****** Serv Checkout failed ****** >> %LOG_DIR%\get-serf-source.log
type %LOG_DIR%\get-serf-source.log
exit /B 1
