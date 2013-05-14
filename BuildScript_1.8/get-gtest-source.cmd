@IF DEFINED NOECHO echo off

echo ====== Get gtest Source code ======
echo ====== Get gtest Source code ====== > %LOG_DIR%\get-gtest-source.log
%WGET% -nc --directory-prefix=%DLDIR% http://googletest.googlecode.com/files/gtest-%GTESTVER%.zip >> %LOG_DIR%\get-gtest-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

echo ====== Extract gtest ======
echo ====== Extract gtest ====== >> %LOG_DIR%\get-gtest-source.log
%ZZIP% x -y %DLDIR%\gtest-%GTESTVER%.zip -o%ROOT%\%DIR% >> %LOG_DIR%\get-gtest-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL
rmdir /Q /S %ROOT%\%DIR%\gtest >> %LOG_DIR%\get-openssl-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL
ren %ROOT%\%DIR%\gtest-%GTESTVER% gtest >> %LOG_DIR%\get-openssl-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL


exit /B 0

:CO_FAIL
echo ****** gtest Download failed ****** >> %LOG_DIR%\get-gtest-source.log
type %LOG_DIR%\get-gtest-source.log
exit /B 1

:EXTRACT_FAIL
echo ****** gtest Extraction failed ****** >> %LOG_DIR%\get-gtest-source.log
type %LOG_DIR%\get-gtest-source.log
exit /B 1
