@IF DEFINED NOECHO echo off

echo ====== Create zip ======
echo ====== Create zip ====== > %LOG_DIR%\create-zip.log
pushd %ROOT%
set PATHORG=%PATH%
PATH=%ROOT%\svn-win32-%VER%\svn-win32-%VER%\bin;%PATH%

%AWKDIR%\awk.exe "{gsub(/bdbver = [0-9]*/,\"bdbver = %BDBVER%\"); };1" %DIR%\build\win32\make_dist.conf.template > %DIR%\build\win32\make_dist.conf.temp1 2>> %LOG_DIR%\create-zip.log
IF ERRORLEVEL 1 GOTO AWK_FAIL
%AWKDIR%\awk.exe "{gsub(/zip.exe/,\"%ZIPEXE%\"); };1" %DIR%\build\win32\make_dist.conf.temp1 > %DIR%\build\win32\make_dist.conf.temp2 2>> %LOG_DIR%\create-zip.log
IF ERRORLEVEL 1 GOTO AWK_FAIL
%AWKDIR%\awk.exe "{gsub(/jdk1.5.0_04/,\"jdk%JAVAVER%\"); };1" %DIR%\build\win32\make_dist.conf.temp2 > %DIR%\build\win32\make_dist.conf.temp3 2>> %LOG_DIR%\create-zip.log
IF ERRORLEVEL 1 GOTO AWK_FAIL
%AWKDIR%\awk.exe "{gsub(/C:\/Program Files\/ruby/,\"%RUBYDIRAWK%\"); };1" %DIR%\build\win32\make_dist.conf.temp3 > %DIR%\build\win32\make_dist.conf 2>> %LOG_DIR%\create-zip.log
IF ERRORLEVEL 1 GOTO AWK_FAIL


rem copy ReadMe to right folder
copy /Y C:\win32svn\BuildScript\README.txt %ROOT%\README.txt >> %LOG_DIR%\create-zip.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL

rem ====== Regenerate VC project files - make_dist doesn't like junit-dir
cd %ROOT%\%DIR%
python gen-make.py -t dsp --with-httpd=..\%HTTPDDIR% --with-berkeley-db=%BDBDIR% --with-openssl=..\%HTTPDDIR%\srclib\openssl --with-zlib=..\%HTTPDDIR%\srclib\zlib --with-sasl=..\cyrus-sasl-%SASLVER% --enable-nls --with-libintl=..\svn-win32-libintl --with-serf=..\%DIR%\serf --with-swig=%SWIGDIR% --enable-bdb-in-apr-util --with-junit=%JUNITDIR%  >> %LOG_DIR%\create-zip.log 2>>&1
IF ERRORLEVEL 1 GOTO GENMAKE_FAIL

cd %ROOT%
python %DIR%\build\win32\make_dist.py --readme=%ROOT%\README.txt svn-win32-%VER% svn-win32-%VER% >> %LOG_DIR%\create-zip.log 2>>&1
IF ERRORLEVEL 1 GOTO MAKEDIST_FAIL
del /Q svn-win32-%VER%\svn-win32-%VER%_py%PYTHONFILEVER%.zip >> %LOG_DIR%\create-zip.log 2>>&1
IF ERRORLEVEL 1 GOTO MAKEDIST_FAIL
ren svn-win32-%VER%\svn-win32-%VER%_py.zip svn-win32-%VER%_py%PYTHONFILEVER%.zip >> %LOG_DIR%\create-zip.log 2>>&1
IF ERRORLEVEL 1 GOTO MAKEDIST_FAIL

popd
PATH=%PATHORG%

echo ====== Create zip success ======
echo ====== Create zip success ====== >> %LOG_DIR%\create-zip.log
exit /B 0


:AWK_FAIL
echo ****** modification to make_dist.conf failed ****** >> %LOG_DIR%\create-zip.log
type %LOG_DIR%\create-zip.log
popd
exit /B 1

:COPY_FAIL
echo ****** copy of readme failed ****** >> %LOG_DIR%\create-zip.log
type %LOG_DIR%\create-zip.log
popd
exit /B 1

:GENMAKE_FAIL
echo ****** genmake failed ****** >> %LOG_DIR%\create-zip.log
type %LOG_DIR%\create-zip.log
popd
exit /B 1

:MAKEDIST_FAIL
echo ****** make dist failed ****** >> %LOG_DIR%\create-zip.log
type %LOG_DIR%\create-zip.log
popd
exit /B 1
