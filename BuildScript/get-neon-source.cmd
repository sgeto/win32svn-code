@IF DEFINED NOECHO echo off

echo ====== Get Neon Source code ======
echo ====== Get Neon Source code ====== > %LOG_DIR%\get-neon-source.log
%SVNBINPATH%\svn co http://svn.webdav.org/repos/projects/neon/tags/%NEONVER% %ROOT%\%DIR%\neon >> %LOG_DIR%\get-neon-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

echo ====== Patch Neon ======
echo ====== Patch Neon ====== >> %LOG_DIR%\get-neon-source.log
rem ****** patch neon\.version and neon\config.hw with neon version number
echo %NEONVER%>%ROOT%\%DIR%\neon\.version
%AWKDIR%\awk.exe "{gsub(/@VERSION@/,\"%NEONVER%\");gsub(/@MAJOR@/,\"%NEONMAJORVER%\");gsub(/@MINOR@/,\"%NEONMINORVER%\")};1" %ROOT%\%DIR%\neon\config.hw.in > %ROOT%\%DIR%\neon\config.hw 2>> %LOG_DIR%\get-neon-source.log
IF ERRORLEVEL 1 GOTO PATCH_FAIL

rem ****** patch error in ne_pkcs11 (ne_ssl.h doesn't have size_t defined in Neon 0.30.0)
del %ROOT%\%DIR%\neon\src\ne_pkcs11.c.in >> %LOG_DIR%\get-neon-source.log 2>>&1
ren %ROOT%\%DIR%\neon\src\ne_pkcs11.c ne_pkcs11.c.in >> %LOG_DIR%\get-neon-source.log 2>>&1
%AWKDIR%\awk.exe "{gsub(/\"config.h\"/,\"\\\"config.h\\\"\n#include ^<stdlib.h^>\") };1" %ROOT%\%DIR%\neon\src\ne_pkcs11.c.in > %ROOT%\%DIR%\neon\src\ne_pkcs11.c 2>> %LOG_DIR%\get-neon-source.log
IF ERRORLEVEL 1 GOTO PATCH_FAIL

exit /B 0

:CO_FAIL
echo ****** Neon Checkout failed ****** >> %LOG_DIR%\get-neon-source.log
type %LOG_DIR%\get-neon-source.log
exit /B 1

:PATCH_FAIL
echo ****** Neon Patch failed ****** >> %LOG_DIR%\get-neon-source.log
type %LOG_DIR%\get-neon-source.log
exit /B 1
