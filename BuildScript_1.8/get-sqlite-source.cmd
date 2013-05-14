@IF DEFINED NOECHO echo off

echo ====== Get sqlite Source code ======
echo ====== Get sqlite Source code ====== > %LOG_DIR%\get-sqlite-source.log
%WGET% -N --directory-prefix=%DLDIR% http://www.sqlite.org/%SQLITEYEAR%/sqlite-amalgamation-%SQLITEFILEVER%.zip >> %LOG_DIR%\get-sqlite-source.log 2>>&1
IF ERRORLEVEL 1 GOTO CO_FAIL

echo ====== Extract sqlite ======
echo ====== Extract sqlite ====== >> %LOG_DIR%\get-sqlite-source.log
%ZZIP% x -y %DLDIR%\sqlite-amalgamation-%SQLITEFILEVER%.zip -o%ROOT%\%DIR% >> %LOG_DIR%\get-sqlite-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL
rmdir /Q /S %ROOT%\%DIR%\sqlite-amalgamation >> %LOG_DIR%\get-sqlite-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL
ren %ROOT%\%DIR%\sqlite-amalgamation-%SQLITEFILEVER% sqlite-amalgamation >> %LOG_DIR%\get-sqlite-source.log 2>>&1
IF ERRORLEVEL 1 GOTO EXTRACT_FAIL

echo ====== Patch sqlite ======
echo ====== Patch sqlite ====== >> %LOG_DIR%\get-sqlite-source.log
del /Q %ROOT%\%DIR%\sqlite-amalgamation\sqlite3.c.in >> %LOG_DIR%\get-sqlite-source.log 2>>&1
IF ERRORLEVEL 1 GOTO PATCH_FAIL
ren %ROOT%\%DIR%\sqlite-amalgamation\sqlite3.c sqlite3.c.in >> %LOG_DIR%\get-sqlite-source.log 2>>&1
IF ERRORLEVEL 1 GOTO PATCH_FAIL
%AWKDIR%\awk.exe "{gsub(/SQLITE_API extern void/,\"SQLITE_API void\")};1" %ROOT%\%DIR%\sqlite-amalgamation\sqlite3.c.in > %ROOT%\%DIR%\sqlite-amalgamation\sqlite3.c 2>> %LOG_DIR%\get-sqlite-source.log
IF ERRORLEVEL 1 GOTO PATCH_FAIL

exit /B 0

:CO_FAIL
echo ****** sqlite Checkout failed ****** >> %LOG_DIR%\get-sqlite-source.log
type %LOG_DIR%\get-sqlite-source.log
exit /B 1

:EXTRACT_FAIL
echo ****** sqlite Extraction failed ****** >> %LOG_DIR%\get-sqlite-source.log
type %LOG_DIR%\get-sqlite-source.log
exit /B 1

:PATCH_FAIL
echo ****** Neon Patch failed ****** >> %LOG_DIR%\get-neon-source.log
type %LOG_DIR%\get-neon-source.log
exit /B 1
