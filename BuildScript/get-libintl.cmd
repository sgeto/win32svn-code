@IF DEFINED %NOECHO% echo off

echo ====== Get libintl ======
echo ====== Get libintl ====== > %LOG_DIR%\get-libintl.log
%WGET% -N --directory-prefix=%DLDIR% http://subversion.tigris.org/files/documents/15/20739/svn-win32-libintl.zip >> %LOG_DIR%\get-libintl.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

echo ====== Extract libintl ======
echo ====== Extract libintl ====== >> %LOG_DIR%\get-libintl.log
%ZZIP% x -y %DLDIR%\svn-win32-libintl.zip -o%ROOT% >> %LOG_DIR%\get-libintl.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL

exit /B 0

:CO_FAIL
echo ****** libintl Checkout failed ****** >> %LOG_DIR%\get-libintl.log
type %LOG_DIR%\get-libintl.log
exit /B 1

:EXTRACT_FAIL
echo ****** libintl Extraction failed ****** >> %LOG_DIR%\get-libintl.log
type %LOG_DIR%\get-libintl.log
exit /B 1
