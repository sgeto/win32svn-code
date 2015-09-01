@IF DEFINED NOECHO echo off

echo ====== Configure httpd ======
echo ====== Configure httpd ====== > %LOG_DIR%\configure-httpd.log


rem *** CONFIGURE HTTPD ****
IF EXIST "%HTTPDINSTDIR%\conf\httpd.conf.in" goto PATCH
copy "%HTTPDINSTDIR%\conf\httpd.conf" "%HTTPDINSTDIR%\conf\httpd.conf.in" >> %LOG_DIR%\configure-httpd.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL


:PATCH
copy "%HTTPDINSTDIR%\conf\httpd.conf.in" "%HTTPDINSTDIR%\conf\httpd.conf" >> %LOG_DIR%\configure-httpd.log 2>>&1
IF ERRORLEVEL 1 GOTO COPY_FAIL

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo LoadModule dav_module modules/mod_dav.so>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo LoadModule dav_fs_module modules/mod_dav_fs.so>> "%HTTPDINSTDIR%\conf\httpd.conf"
::echo LoadModule sspi_auth_module   modules/mod_auth_sspi-1.0.4/bin/mod_auth_sspi.so>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo LoadModule dav_svn_module     %ROOT%/svn-win32-%VER%/svn-win32-%VER%/bin/mod_dav_svn.so>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo LoadModule authz_svn_module   %ROOT%/svn-win32-%VER%/svn-win32-%VER%/bin/mod_authz_svn.so>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo ^<Location /svn-test-work/repositories^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  DAV svn>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  SVNParentPath %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/repositories>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  SVNAdvertiseV2Protocol on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  SVNPathAuthz on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  SVNAllowBulkUpdates on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  SVNListParentPath On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  AuthzSVNAccessFile %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/authz>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  AuthType Basic>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  AuthName "Subversion Repository">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  AuthUserFile "%HTTPDINSTDIR%/conf/users">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  Require valid-user>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo ^</Location^>>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo ^<Location /svn-test-work/local_tmp^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  DAV svn>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  SVNParentPath %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/local_tmp>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  SVNAdvertiseV2Protocol on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  SVNPathAuthz on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  SVNAllowBulkUpdates on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  SVNListParentPath On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  AuthzSVNAccessFile %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/authz>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  AuthType Basic>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  AuthName "Subversion Repository">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  AuthUserFile "%HTTPDINSTDIR%/conf/users">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  Require valid-user>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo ^</Location^>>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^<Location /authz-test-work/anon^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    DAV               svn>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNParentPath     %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/local_tmp>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSVNAccessFile %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/authz>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNAdvertiseV2Protocol on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNListParentPath On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    ^<IfModule mod_authz_core.c^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo      Require all granted>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    ^</IfModule^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    ^<IfModule !mod_authz_core.c^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo      Allow from all>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    ^</IfModule^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNPathAuthz on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^</Location^>>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^<Location /authz-test-work/mixed^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    DAV               svn>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNParentPath     %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/local_tmp>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSVNAccessFile %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/authz>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNAdvertiseV2Protocol on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNListParentPath On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthType          Basic>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthName          "Subversion Repository">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthUserFile    "%HTTPDINSTDIR%/conf/users">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    Require           valid-user>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    Satisfy Any>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNPathAuthz on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^</Location^>>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^<Location /authz-test-work/mixed-noauthwhenanon^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    DAV               svn>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNParentPath     %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/local_tmp>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSVNAccessFile %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/authz>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNAdvertiseV2Protocol on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNListParentPath On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthType          Basic>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthName          "Subversion Repository">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthUserFile    "%HTTPDINSTDIR%/conf/users">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    Require           valid-user>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSVNNoAuthWhenAnonymousAllowed On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNPathAuthz On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^</Location^>>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^<Location /authz-test-work/authn^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    DAV               svn>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNParentPath     %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/local_tmp>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSVNAccessFile %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/authz>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNAdvertiseV2Protocol on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNListParentPath On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthType          Basic>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthName          "Subversion Repository">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthUserFile    "%HTTPDINSTDIR%/conf/users">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    Require           valid-user>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNPathAuthz on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^</Location^>>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^<Location /authz-test-work/authn-anonoff^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    DAV               svn>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNParentPath     %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/local_tmp>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSVNAccessFile %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/authz>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNAdvertiseV2Protocol on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNListParentPath On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthType          Basic>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthName          "Subversion Repository">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthUserFile    "%HTTPDINSTDIR%/conf/users">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    Require           valid-user>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSVNAnonymous Off>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNPathAuthz On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^</Location^>>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^<Location /authz-test-work/authn-lcuser^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    DAV               svn>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNParentPath     %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/local_tmp>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSVNAccessFile %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/authz>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNAdvertiseV2Protocol on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNListParentPath On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthType          Basic>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthName          "Subversion Repository">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthUserFile    "%HTTPDINSTDIR%/conf/users">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    Require           valid-user>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzForceUsernameCase Lower>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNPathAuthz on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^</Location^>>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^<Location /authz-test-work/authn-lcuser^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    DAV               svn>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNParentPath     %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/local_tmp>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSVNAccessFile %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/authz>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNAdvertiseV2Protocol on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNListParentPath On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthType          Basic>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthName          "Subversion Repository">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthUserFile    "%HTTPDINSTDIR%/conf/users">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    Require           valid-user>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzForceUsernameCase Lower>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNPathAuthz on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^</Location^>>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^<Location /authz-test-work/authn-group^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    DAV               svn>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNParentPath     %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/local_tmp>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSVNAccessFile %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/authz>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNAdvertiseV2Protocol on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNListParentPath On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthType          Basic>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthName          "Subversion Repository">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthUserFile    "%HTTPDINSTDIR%/conf/users">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthGroupFile    "%HTTPDINSTDIR%/conf/groups">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    Require           group random>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSVNAuthoritative Off>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNPathAuthz On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^</Location^>>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo ^<IfModule mod_authz_core.c^>>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^<Location /authz-test-work/sallrany^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    DAV               svn>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNParentPath     %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/local_tmp>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSVNAccessFile %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/authz>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNAdvertiseV2Protocol on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNListParentPath On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthType          Basic>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthName          "Subversion Repository">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthUserFile    "%HTTPDINSTDIR%/conf/users">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSendForbiddenOnFailure On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    Satisfy All>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    ^<RequireAny^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo      Require valid-user>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo      Require expr req('ALLOW') == 1 >> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    ^</RequireAny^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNPathAuthz on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^</Location^>>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^<Location /authz-test-work/sallrall^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    DAV               svn>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNParentPath     %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/local_tmp>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSVNAccessFile %ROOT%/src-%VER%/Release/subversion/tests/cmdline/svn-test-work/authz>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNAdvertiseV2Protocol on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNListParentPath On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthType          Basic>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthName          "Subversion Repository">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthUserFile    "%HTTPDINSTDIR%/conf/users">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    AuthzSendForbiddenOnFailure On>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    Satisfy All>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    ^<RequireAll^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo      Require valid-user>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo      Require expr req('ALLOW') == 1 >> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    ^</RequireAll^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo    SVNPathAuthz on>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  ^</Location^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo ^</IfModule^>>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo RedirectMatch permanent ^^/svn-test-work/repositories/REDIRECT-PERM-(.*)$ /svn-test-work/repositories/$1>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo RedirectMatch           ^^/svn-test-work/repositories/REDIRECT-TEMP-(.*)$ /svn-test-work/repositories/$1>> "%HTTPDINSTDIR%\conf\httpd.conf"

echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo ^<Location /testsvn^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  DAV svn>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  SVNPath C:/TestSVN/repository>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  AuthzSVNAccessFile C:/TestSVN/authz>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  AuthType Basic>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  AuthName "Subversion Repository">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  AuthUserFile "C:/TestSVN/users">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  Require valid-user>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo  SVNIndexXSLT "/svnindex.xsl">> "%HTTPDINSTDIR%\conf\httpd.conf"
echo ^</Location^>>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo(>> "%HTTPDINSTDIR%\conf\httpd.conf"
echo CustomLog "logs/svn.log" "%%t %%u %%{SVN-ACTION}e" env=SVN-ACTION>> "%HTTPDINSTDIR%\conf\httpd.conf"


echo jrandom:$apr1$3p1.....$FQW6RceW5QhJ2blWDQgKn0 > "%HTTPDINSTDIR%\conf\users"
echo jconstant:$apr1$jp1.....$Usrqji1c9H6AbOxOGAzzb0 >> "%HTTPDINSTDIR%\conf\users"
echo JRANDOM:rayjandom >> "%HTTPDINSTDIR%\conf\users"
echo JCONSTANT:rayjandom >> "%HTTPDINSTDIR%\conf\users"

echo random: jrandom > "%HTTPDINSTDIR%\conf\groups"
echo constant: jconstant >> "%HTTPDINSTDIR%\conf\groups

::net stop Apache%HTTPDVERDIR%  >> %LOG_DIR%\configure-httpd.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL

::net start Apache%HTTPDVERDIR%  >> %LOG_DIR%\configure-httpd.log 2>>&1
IF ERRORLEVEL 1 GOTO FAIL

exit /B 0

:COPY_FAIL
echo ****** Copy of httpd.conf failed ****** >> %LOG_DIR%\configure-httpd.log
type %LOG_DIR%\configure-httpd.log
exit /B 1

:FAIL
echo ****** Configure httpd failed ****** >> %LOG_DIR%\configure-httpd.log
type %LOG_DIR%\configure-httpd.log
exit /B 1
