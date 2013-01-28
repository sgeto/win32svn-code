@setlocal
@IF '%1'=='OFF' set NOECHO=NOECHO
@IF '%1'=='off' set NOECHO=NOECHO
@IF DEFINED NOECHO echo off

set SCRIPT_DIR=%cd%
set LOG_DIR=%SCRIPT_DIR%\log
rmdir /s /q %LOG_DIR%
mkdir %LOG_DIR%

call set-vc-env.cmd
IF ERRORLEVEL 1 GOTO END

call set-versions.cmd
IF ERRORLEVEL 1 GOTO END

call set-dirs.cmd
IF ERRORLEVEL 1 GOTO END

call set-python-ver.cmd 2.7
IF ERRORLEVEL 1 GOTO END



rem ===== Get Sources =====
call get-svn-source.cmd
IF ERRORLEVEL 1 GOTO END

call get-httpd-source.cmd
IF ERRORLEVEL 1 GOTO END

call get-apr-source.cmd
IF ERRORLEVEL 1 GOTO END

call get-pcre-source.cmd
IF ERRORLEVEL 1 GOTO END

call get-serf-source.cmd
IF ERRORLEVEL 1 GOTO END

call get-neon-source.cmd
IF ERRORLEVEL 1 GOTO END

call get-zlib-source.cmd
IF ERRORLEVEL 1 GOTO END

call get-openssl-source.cmd
IF ERRORLEVEL 1 GOTO END

call get-sqlite-source.cmd
IF ERRORLEVEL 1 GOTO END

call get-libintl.cmd
IF ERRORLEVEL 1 GOTO END

call get-junit.cmd
IF ERRORLEVEL 1 GOTO END

call get-bdb-source.cmd
IF ERRORLEVEL 1 GOTO END

call get-sasl-source.cmd
IF ERRORLEVEL 1 GOTO END

call get-swig-source.cmd
IF ERRORLEVEL 1 GOTO END

IF EXIST extra-patch.cmd call extra-patch.cmd
IF ERRORLEVEL 1 GOTO END

call check-dirs.cmd
IF ERRORLEVEL 1 GOTO END

call build-openssl.cmd
IF ERRORLEVEL 1 GOTO END

call build-bdb.cmd
IF ERRORLEVEL 1 GOTO END

call build-sasl.cmd
IF ERRORLEVEL 1 GOTO END

call build-zlib.cmd
IF ERRORLEVEL 1 GOTO END

call generate-vc-proj.cmd
IF ERRORLEVEL 1 GOTO END

call build-pcre.cmd
IF ERRORLEVEL 1 GOTO END

call build-httpd.cmd
IF ERRORLEVEL 1 GOTO END

call build-svn-main.cmd
IF ERRORLEVEL 1 GOTO END

call build-svn-perl.cmd
IF ERRORLEVEL 1 GOTO END

call build-svn-ruby.cmd
IF ERRORLEVEL 1 GOTO END

call build-svn-javahl.cmd
IF ERRORLEVEL 1 GOTO END

call remove-zip.cmd
IF ERRORLEVEL 1 GOTO END


call set-python-ver.cmd 2.7
IF ERRORLEVEL 1 GOTO END
call generate-vc-proj.cmd
IF ERRORLEVEL 1 GOTO END
call build-svn-python.cmd
IF ERRORLEVEL 1 GOTO END
call create-zip.cmd
IF ERRORLEVEL 1 GOTO END


call set-python-ver.cmd 2.6
IF ERRORLEVEL 1 GOTO END
call generate-vc-proj.cmd
IF ERRORLEVEL 1 GOTO END
call build-svn-python.cmd
IF ERRORLEVEL 1 GOTO END
call create-zip.cmd
IF ERRORLEVEL 1 GOTO END


call set-python-ver.cmd 2.5
IF ERRORLEVEL 1 GOTO END
call generate-vc-proj.cmd
IF ERRORLEVEL 1 GOTO END
call build-svn-python.cmd
IF ERRORLEVEL 1 GOTO END
call create-zip.cmd
IF ERRORLEVEL 1 GOTO END


call configure-httpd.cmd
IF ERRORLEVEL 1 GOTO END


call run-tests.cmd
IF ERRORLEVEL 1 GOTO END



:END
