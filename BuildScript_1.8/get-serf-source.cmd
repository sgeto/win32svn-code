@IF DEFINED NOECHO echo off

echo ====== Get Serf Source code ======
echo ====== Get Serf Source code ====== > %LOG_DIR%\get-serf-source.log
rem Get Serf Source code
%SVNBINPATH%\svn co http://svn.apache.org/repos/asf/serf/tags/%SERFVER% %ROOT%\serf >> %LOG_DIR%\get-serf-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

::echo ====== Patch Serf ======
::echo ====== Patch Serf ====== >> %LOG_DIR%\get-serf-source.log
::%SVNBINPATH%\svn patch %SCRIPT_DIR%\serf.patch %ROOT%\serf >> %LOG_DIR%\get-serf-source.log 2>>&1
::IF ERRORLEVEL 1 GOTO PATCH_FAIL


exit /B 0

:CO_FAIL
echo ****** Serv Checkout failed ****** >> %LOG_DIR%\get-serf-source.log
type %LOG_DIR%\get-serf-source.log
exit /B 1


:PATCH_FAIL
echo ****** apr Serf failed ****** >> %LOG_DIR%\get-serf-source.log
type %LOG_DIR%\get-serf-source.log
exit /B 1
