@IF DEFINED NOECHO echo off

echo ====== Check Directories ======
echo ====== Check Directories====== > %LOG_DIR%\check-dirs.log

rem Check that the subversion code exists here.
pushd %ROOT%\%DIR%
if not exist subversion goto wrongstartdir
cd %ROOT%

rem ====== Check the prerequisites are at least in the right place.
if not exist %HTTPDDIR% goto httpderr
if not exist %HTTPDDIR%\srclib\openssl goto opensslerr
if not exist %DIR% goto svnerr
if not exist %HTTPDDIR%\srclib\zlib goto zliberr
if not exist db-%BDBFULLVER% goto bdberr
if not exist %DIR%\neon goto neonerr
if not exist cyrus-sasl-%SASLVER% goto cyrussaslerr
popd
exit /B 0

:wrongstartdir
echo Unable to find %ROOT%\%DIR%\subversion >> %LOG_DIR%\check-dirs.log
goto FAIL
:httpderr
echo Unable to find %HTTPDDIR% >> %LOG_DIR%\check-dirs.log
goto FAIL
:opensslerr
echo Unable to find openssl-%OPENSSLVER% >> %LOG_DIR%\check-dirs.log
goto FAIL
:svnerr
echo Unable to find Subversion source in %DIR% >> %LOG_DIR%\check-dirs.log
goto FAIL
:zliberr
echo Unable to find zlib >> %LOG_DIR%\check-dirs.log
goto FAIL
:bdberr
echo Unable to find Berekely DB >> %LOG_DIR%\check-dirs.log
goto FAIL
:neonerr
echo Unable to find neon >> %LOG_DIR%\check-dirs.log
goto FAIL
:cyrussaslerr
echo Unable to find cyrus-sasl >> %LOG_DIR%\check-dirs.log
goto FAIL

:FAIL
popd
echo ****** Directory check failed ****** >> %LOG_DIR%\check-dirs.log
type %LOG_DIR%\check-dirs.log
exit /B 1
