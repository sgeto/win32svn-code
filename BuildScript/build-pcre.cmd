@IF DEFINED NOECHO echo off

echo ====== Build pcre ======
echo ====== Build pcre ====== > %LOG_DIR%\build-pcre.log
IF %HTTPDVER%==22 GOTO SKIP_PCRE

pushd %ROOT%\%HTTPDDIR%\srclib\pcre
IF ERRORLEVEL 1 GOTO DIR_FAIL

echo ----- compile dftables -----
echo ----- compile dftables -----
cl -DHAVE_CONFIG_H -DSUPPORT_UCP -DSUPPORT_UTF ^
dftables.c >> %LOG_DIR%\build-pcre.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

echo ----- run dftables -----
echo ----- run dftables ----- >> %LOG_DIR%\build-pcre.log 2>>&1
dftables.exe pcre_chartables.c >> %LOG_DIR%\build-pcre.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

echo ----- compile -----
echo ----- compile ----- >> %LOG_DIR%\build-pcre.log 2>>&1
cl -DHAVE_CONFIG_H -DSUPPORT_UCP -DSUPPORT_UTF -DSUPPORT_PCRE8 ^
 /c pcre_byte_order.c pcre_chartables.c pcre_compile.c pcre_config.c ^
 pcre_dfa_exec.c pcre_exec.c pcre_fullinfo.c pcre_get.c pcre_globals.c ^
 pcre_jit_compile.c pcre_maketables.c pcre_newline.c pcre_ord2utf8.c ^
 pcre_refcount.c pcre_string_utils.c pcre_study.c pcre_tables.c ^
 pcre_ucd.c pcre_valid_utf8.c pcre_version.c pcre_xclass.c >> %LOG_DIR%\build-pcre.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

echo ----- lib -----
echo ----- lib ----- >> %LOG_DIR%\build-pcre.log 2>>&1
lib /NAME:pcre.dll /DEF /OUT:pcre.lib ^
 pcre_byte_order.obj pcre_chartables.obj pcre_compile.obj pcre_config.obj ^
 pcre_dfa_exec.obj pcre_exec.obj pcre_fullinfo.obj pcre_get.obj pcre_globals.obj ^
 pcre_jit_compile.obj pcre_maketables.obj pcre_newline.obj pcre_ord2utf8.obj ^
 pcre_refcount.obj pcre_string_utils.obj pcre_study.obj pcre_tables.obj ^
 pcre_ucd.obj pcre_valid_utf8.obj pcre_version.obj pcre_xclass.obj >> %LOG_DIR%\build-pcre.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

echo ----- link -----
echo ----- link ----- >> %LOG_DIR%\build-pcre.log 2>>&1
link /DLL /OUT:pcre.dll ^
 pcre_byte_order.obj pcre_chartables.obj pcre_compile.obj pcre_config.obj ^
 pcre_dfa_exec.obj pcre_exec.obj pcre_fullinfo.obj pcre_get.obj pcre_globals.obj ^
 pcre_jit_compile.obj pcre_maketables.obj pcre_newline.obj pcre_ord2utf8.obj ^
 pcre_refcount.obj pcre_string_utils.obj pcre_study.obj pcre_tables.obj ^
 pcre_ucd.obj pcre_valid_utf8.obj pcre_version.obj pcre_xclass.obj >> %LOG_DIR%\build-pcre.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

echo ----- compile pcreposix -----
echo ----- compile pcreposix ----- >> %LOG_DIR%\build-pcre.log 2>>&1
cl -DHAVE_CONFIG_H -DSUPPORT_UCP -DSUPPORT_UTF -DSUPPORT_PCRE8 ^
 /c pcreposix.c >> %LOG_DIR%\build-pcre.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

echo ----- lib pcreposix -----
echo ----- lib pcreposix ----- >> %LOG_DIR%\build-pcre.log 2>>&1
lib /NAME:pcreposix.dll /DEF /OUT:pcreposix.lib pcreposix.obj >> %LOG_DIR%\build-pcre.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

echo ----- link pcreposix -----
echo ----- link pcreposix ----- >> %LOG_DIR%\build-pcre.log 2>>&1
link /DLL /OUT:pcreposix.dll pcreposix.obj pcre.lib >> %LOG_DIR%\build-pcre.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

echo ----- compile pcretest -----
echo ----- compile pcretest ----- >> %LOG_DIR%\build-pcre.log 2>>&1
cl -DHAVE_CONFIG_H -DSUPPORT_UCP -DSUPPORT_UTF -DSUPPORT_PCRE8 ^
 pcretest.c pcre_printint.c pcre.lib pcreposix.lib >> %LOG_DIR%\build-pcre.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL

echo ----- compile pcregrep -----
echo ----- compile pcregrep ----- >> %LOG_DIR%\build-pcre.log 2>>&1
cl -DHAVE_CONFIG_H -DSUPPORT_UCP -DSUPPORT_UTF ^
 pcregrep.c pcre.lib >> %LOG_DIR%\build-pcre.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL
:: if no unistd.h and dirent.h files, please delete same lines in config.h

echo ----- test -----
echo ----- test ----- >> %LOG_DIR%\build-pcre.log 2>>&1
pcretest testdata\testinput1 testdata\myoutput1 >> %LOG_DIR%\build-pcre.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL
%AWKDIR%\awk.exe "FNR>2" testdata\myoutput1 > testdata\myoutput2 2>> %LOG_DIR%\build-pcre.log
IF ERRORLEVEL 1 GOTO BUILD_FAIL
fc testdata\testoutput1 testdata\myoutput2 >> %LOG_DIR%\build-pcre.log 2>>&1
IF ERRORLEVEL 1 GOTO BUILD_FAIL
popd
exit /B 0


:DIR_FAIL
echo ****** pcre dir does not exists ****** >> %LOG_DIR%\build-pcre.log
type %LOG_DIR%\build-pcre.log
popd
exit /B 1

:BUILD_FAIL
echo ****** pcre build failed ****** >> %LOG_DIR%\build-pcre.log
type %LOG_DIR%\build-pcre.log
popd
exit /B 1

:SKIP_PCRE
echo ****** pcre skipped (HTTPD ver 2.2) ****** 
echo ****** pcre skipped (HTTPD ver 2.2) ****** >> %LOG_DIR%\get-pcre-source.log
type %LOG_DIR%\get-pcre-source.log
exit /B 0
