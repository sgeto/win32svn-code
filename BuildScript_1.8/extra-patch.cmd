@IF DEFINED NOECHO echo off

echo ====== Extra Patch ======
echo ====== Extra Patch ====== > %LOG_DIR%\extra-patch.log
::%SVNBINPATH%\svn merge -r1535138:r1535139 http://svn.apache.org/repos/asf/subversion/branches/1.8.x-openssl-dirs %ROOT%\src-%VER%\  >> %LOG_DIR%\extra-patch.log 2>>&1
::IF ERRORLEVEL 1 GOTO PATCH_FAIL
::%SVNBINPATH%\svn merge -r1537215:r1537216 https://svn.apache.org/repos/asf/subversion/branches/1.8.x-r1537193 %ROOT%\src-%VER%\  >> %LOG_DIR%\extra-patch.log 2>>&1
::IF ERRORLEVEL 1 GOTO PATCH_FAIL
::%SVNBINPATH%\svn merge -r1537222:r1537223 https://svn.apache.org/repos/asf/subversion/branches/1.8.x-r1537193 %ROOT%\src-%VER%\  >> %LOG_DIR%\extra-patch.log 2>>&1
::IF ERRORLEVEL 1 GOTO PATCH_FAIL
exit /B 0


:PATCH_FAIL
echo ****** Extra Patch failed ****** >> %LOG_DIR%\extra-patch.log
type %LOG_DIR%\extra-patch.log
exit /B 1
