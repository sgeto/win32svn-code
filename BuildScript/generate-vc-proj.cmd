@IF DEFINED %NOECHO% echo off

echo ====== Generate VC projects ======
echo ====== Generate VC projects ====== > %LOG_DIR%\generate-vc-proj.log

pushd %ROOT%\%DIR%
IF ERRORLEVEL 1 GOTO DIR_FAIL
python gen-make.py -t dsp --with-httpd=..\%HTTPDDIR% --with-berkeley-db=%BDBDIR% --with-openssl=..\%HTTPDDIR%\srclib\openssl --with-zlib=..\%HTTPDDIR%\srclib\zlib --with-sasl=..\cyrus-sasl-%SASLVER% --enable-nls --with-libintl=..\svn-win32-libintl --with-serf=..\%DIR%\serf --with-swig=%SWIGDIR% --enable-bdb-in-apr-util --with-junit=%JUNITJAR% >> %LOG_DIR%\generate-vc-proj.log 2>>&1
IF ERRORLEVEL 1 GOTO GENERATE_FAIL
popd

exit /B 0

:DIR_FAIL
echo ****** base dir does not exists ****** >> %LOG_DIR%\generate-vc-proj.log
type %LOG_DIR%\generate-vc-proj.log
popd
exit /B 1

:GENERATE_FAIL
echo ****** generate VC projects failed ****** >> %LOG_DIR%\generate-vc-proj.log
type %LOG_DIR%\generate-vc-proj.log
popd
exit /B 1

