@IF DEFINED NOECHO echo off

echo ====== Get pcre Source code ======
echo ====== Get pcre Source code ====== > %LOG_DIR%\get-pcre-source.log
IF %HTTPDVER%==22 GOTO SKIP_PCRE

%WGET% -N --directory-prefix=%DLDIR% http://sourceforge.net/projects/pcre/files/pcre/%PCREVER%/pcre-%PCREVER%.zip/download >> %LOG_DIR%\get-pcre-source.log 2>>&1
IF ERRORLEVEL 1 GOTO DL_FAIL

echo ====== Extract pcre ======
echo ====== Extract pcre ====== >> %LOG_DIR%\get-pcre-source.log
%ZZIP% x -y %DLDIR%\pcre-%PCREVER%.zip -o%ROOT%\%HTTPDDIR%\srclib\ >> %LOG_DIR%\get-pcre-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL
rmdir /S /Q %ROOT%\%HTTPDDIR%\srclib\pcre >> %LOG_DIR%\get-pcre-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL
ren %ROOT%\%HTTPDDIR%\srclib\pcre-%PCREVER% pcre >> %LOG_DIR%\get-pcre-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL

copy /y  %ROOT%\%HTTPDDIR%\srclib\pcre\config.h.generic  %ROOT%\%HTTPDDIR%\srclib\pcre\config.h >> %LOG_DIR%\get-pcre-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL

copy /y  %ROOT%\%HTTPDDIR%\srclib\pcre\pcre.h.generic  %ROOT%\%HTTPDDIR%\srclib\pcre\pcre.h >> %LOG_DIR%\get-pcre-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL

exit /B 0


:DL_FAIL
echo ****** pcre Download failed ****** >> %LOG_DIR%\get-pcre-source.log
type %LOG_DIR%\get-pcre-source.log
exit /B 1

:EXTRACT_FAIL
echo ****** pcre Extraction failed ****** >> %LOG_DIR%\get-pcre-source.log
type %LOG_DIR%\get-pcre-source.log
exit /B 1

:SKIP_PCRE
echo ****** pcre skipped (HTTPD ver 2.2) ****** 
echo ****** pcre skipped (HTTPD ver 2.2) ****** >> %LOG_DIR%\get-pcre-source.log
exit /B 0
