@IF DEFINED NOECHO echo off

echo ====== Build bdb ======
echo ====== Build bdb ====== > %LOG_DIR%\build-bdb.log
pushd %ROOT%\db-%BDBFULLVER%\build_windows
IF ERRORLEVEL 1 GOTO DIR_FAIL

echo ----- Build Release -----
msdev Berkeley_DB.dsw /USEENV /MAKE "build_all - Win32 Release x86" >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO RELEASE_FAIL

echo ----- Build Debug -----
msdev Berkeley_DB.dsw /USEENV /MAKE "build_all - Win32 Debug x86" >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO DEBUGFAIL

echo ----- Copy -----
cd ..
rmdir /S /Q %BDBDIR%\include >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
mkdir %BDBDIR%\include >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
rmdir /S /Q %BDBDIR%\bin >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
mkdir %BDBDIR%\bin >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
rmdir /S /Q %BDBDIR%\lib >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
mkdir %BDBDIR%\lib >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL

copy /Y build_windows\win32\release\*.exe %BDBDIR%\bin\ >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
copy /Y build_windows\win32\release\libdb%BDBVER%.dll %BDBDIR%\bin\ >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
copy /Y build_windows\win32\release\libdb%BDBVER%.lib %BDBDIR%\lib\ >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
copy /Y build_windows\win32\release\libdb%BDBVER%.exp %BDBDIR%\lib\ >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
copy /Y build_windows\win32\debug\libdb%BDBVER%d.dll %BDBDIR%\bin\ >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
copy /Y build_windows\win32\debug\libdb%BDBVER%d.lib %BDBDIR%\lib\ >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
copy /Y build_windows\win32\debug\libdb%BDBVER%d.exp %BDBDIR%\lib\ >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
copy /Y build_windows\db.h %BDBDIR%\include\ >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
copy /Y build_windows\db_cxx.h %BDBDIR%\include\ >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
copy /Y LICENSE %BDBDIR%\ >> %LOG_DIR%\build-bdb.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL
popd

exit /B 0



:DIR_FAIL
echo ****** bdb dir does not exists ****** >> %LOG_DIR%\build-bdb.log
type %LOG_DIR%\build-bdb.log
popd
exit /B 1

:RELEASE_FAIL
echo ****** bdb release build failed ****** >> %LOG_DIR%\build-bdb.log
type %LOG_DIR%\build-bdb.log
popd
exit /B 1

:DEBUG_FAIL
echo ****** bdb debug build failed ****** >> %LOG_DIR%\build-bdb.log
type %LOG_DIR%\build-bdb.log
popd
exit /B 1

:COPY_FAIL
echo ****** bdb copy failed ****** >> %LOG_DIR%\build-bdb.log
type %LOG_DIR%\build-bdb.log
popd
exit /B 1
