@IF DEFINED %NOECHO% echo off

echo ====== Get swig Source code ======
echo ====== Get swig Source code ====== > %LOG_DIR%\get-swig-source.log
%WGET% -N --directory-prefix=%DLDIR% http://downloads.sourceforge.net/project/swig/swigwin/swigwin-%SWIGVER%/swigwin-%SWIGVER%.zip >> %LOG_DIR%\get-swig-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

echo ====== Extract swig ======
echo ====== Extract swig ====== >> %LOG_DIR%\get-swig-source.log
%ZZIP% x -y %DLDIR%\swigwin-%SWIGVER%.zip -o%ROOT% >> %LOG_DIR%\get-swig-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL

exit /B 0

:CO_FAIL
echo ****** swig Checkout failed ****** >> %LOG_DIR%\get-swig-source.log
type %LOG_DIR%\get-swig-source.log
exit /B 1

:EXTRACT_FAIL
echo ****** swig Extraction failed ****** >> %LOG_DIR%\get-swig-source.log
type %LOG_DIR%\get-swig-source.log
exit /B 1
