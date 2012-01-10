rem ******************************************************************************
rem * This script is used when building Subversion for Windows with Visual C++ 6 *
rem *                                                                            *
rem * OBS!!! The script is merely a template for copy and pasting into the VC++  *
rem *        command prompt. Do NOT run it directly, there are steps not yet     *
rem *        automated and there is no error handling or test run analysis       *
rem *        Patches are welcome ;-)                                             *
rem ******************************************************************************



rem ====== Environment change lives only for the duration of the script
setlocal

rem ====== Set Visual studio environment ======
set VSCommonDir=C:\Program Files\Microsoft Visual Studio\Common
set MSDevDir=C:\Program Files\Microsoft Visual Studio\Common\msdev98
set MSVCDir=C:\Program Files\Microsoft Visual Studio\VC98
PATH=%MSDevDir%\BIN;%MSVCDir%\BIN;%VSCommonDir%\TOOLS\WINNT;%VSCommonDir%\TOOLS;%PATH%
set INCLUDE=%MSVCDir%\ATL\INCLUDE;%MSVCDir%\INCLUDE;%MSVCDir%\MFC\INCLUDE;%INCLUDE%
set LIB=%MSVCDir%\LIB;%MSVCDir%\MFC\LIB;%LIB%
set VSCommonDir=

rem ====== Set these shell variables before doing a build.
rem VER is used to name the output bin dir as svn-win32-%VER%
set VER=1.7.2
set DIR=src-%VER%
set DRIVE=C
set ROOT=%DRIVE%:\SVN-%VER%
set DLDIR=%ROOT%\Download
set PYTHONVER=27
set PYTHONDIR=C:\Python%PYTHONVER%
set PERLDIR=C:\Perl
set RUBYDIR=C:\Ruby186
set RUBYVER=1.8.6
set AWKDIR=C:\awk
set NASMDIR=C:\asm
set SDKINC=C:\Program Files\Microsoft SDK\include
set SDKLIB=C:\Program Files\Microsoft SDK\lib
set APACHEDIR=C:\Program Files\Apache2.2
set GETTEXTINC=C:\gettext\include
set GETTEXTLIB=C:\gettext\lib
set GETTEXTBIN=C:\gettext\bin
set BDBFULLVER=4.8.30
set BDBVER=48
set BDBDIR=%ROOT%\db-%BDBFULLVER%\build_windows\Win32
set SWIGVER=1.3.40
set SWIGDIR=%ROOT%\SWIGWIN-%SWIGVER%
set JAVADIR=C:\Program Files\Java\jdk1.6.0_29
set JUNITVER=4.10
set JUNITDIR=%ROOT%\junit%JUNITVER%
set JUNITJAR=%JUNITDIR%\junit-%JUNITVER%.jar
set OPENSSLVER=1.0.0e
set HTTPDVER=2.2.21
set SASLVER=2.1.23
set APRVER=1.4.5
set APRUTILVER=1.3.12
set APRICONVVER=1.2.1
set NEONVER=0.29.6
set NEONMAJORVER=0
set NEONMINORVER=29
set SERFVER=1.0.0
set SVNBINPATH="C:\Program Files\Subversion\bin\"
set ZLIBVER=1.2.5
set ZLIBFILEVER=125
set SQLITEVER=3070900
set 7ZIP="C:\Program Files\7-Zip\7z.exe"
set WGET="C:\Program Files\GnuWin32\bin\wget.exe"
rem ====== End of shell variables which need to be set.

rem Set up path to include Python and BDB.
PATH=%PATH%;%NASMDIR%;%BDBDIR%;%PYTHONDIR%;%AWKDIR%;%GETTEXTBIN%;%RUBYDIR%\bin;%JAVADIR%\bin

rem set Classpath for javahl tests
SET CLASSPATH=%JUNITJAR%;%JUNITDIR%

rem Set INCLUDE and LIB for the msdev builds.
set INCLUDE=%SDKINC%;%INCLUDE%;%GETTEXTINC%;%PERLDIR%\lib\CORE;%PYTHONDIR%\include;%RUBYDIR%\include\ruby-1.9.1;%JAVADIR%\include
set LIB=%SDKLIB%;%LIB%;%GETTEXTLIB%;%PERLDIR%\lib\CORE;%PYTHONDIR%\libs;%RUBYDIR%\lib;%JAVADIR%\lib

rem ====== Create release dir
mkdir %ROOT%\svn-win32-%VER%
mkdir %ROOT%\svn-win32-%VER%\bin
mkdir %ROOT%\svn-win32-%VER%\iconv

rem Get Subversion Source code
%SVNBINPATH%\svn co https://svn.apache.org/repos/asf/subversion/tags/%VER% %ROOT%\%DIR%
rem ===========PATCH SUBVERSION =========
rem use patch file

rem Get Apache httpd Source code
%SVNBINPATH%\svn co https://svn.apache.org/repos/asf/httpd/httpd/tags/%HTTPDVER% %ROOT%\httpd-%HTTPDVER%
rem remove references to openssl\store.h in mod_ssl\mod_ssl.dep
ren %ROOT%\httpd-%HTTPDVER%\modules\ssl\mod_ssl.dep mod_ssl.dep.in
%AWKDIR%\awk.exe "!/store.h/" %ROOT%\httpd-%HTTPDVER%\modules\ssl\mod_ssl.dep.in > %ROOT%\httpd-%HTTPDVER%\modules\ssl\mod_ssl.dep

rem Get Apache APR Source code
%SVNBINPATH%\svn co https://svn.apache.org/repos/asf/apr/apr/tags/%APRVER% %ROOT%\httpd-%HTTPDVER%\srclib\apr
rem patch APR for Win2k
ren %ROOT%\httpd-%HTTPDVER%\srclib\apr\include\apr.hw apr.hw.in
%AWKDIR%\awk.exe "{gsub(/<ws2tcpip.h>/,\"^<ws2tcpip.h^>\n#include ^<wspiapi.h^>\") };1" %ROOT%\httpd-%HTTPDVER%\srclib\apr\include\apr.hw.in > %ROOT%\httpd-%HTTPDVER%\srclib\apr\include\apr.hw

rem Get Apache APR-Util Source code
%SVNBINPATH%\svn co https://svn.apache.org/repos/asf/apr/apr-util/tags/%APRUTILVER% %ROOT%\httpd-%HTTPDVER%\srclib\apr-util
rem patch srclib\apr-util\dbd\apr_dbd_odbc.c with 'typedef INT32 SQLLEN;' and 'typedef UINT32 SQLULEN;'  på rad 50
ren %ROOT%\httpd-%HTTPDVER%\srclib\apr-util\dbd\apr_dbd_odbc.c apr_dbd_odbc.c.in
%AWKDIR%\awk.exe "{gsub(/\/\* Driver name/,\"\ntypedef INT32 SQLLEN;\ntypedef UINT32 SQLULEN;\n\/* Driver name\") };1" %ROOT%\httpd-%HTTPDVER%\srclib\apr-util\dbd\apr_dbd_odbc.c.in > %ROOT%\httpd-%HTTPDVER%\srclib\apr-util\dbd\apr_dbd_odbc.c

rem Get Apache APR-Iconv Source code
%SVNBINPATH%\svn co https://svn.apache.org/repos/asf/apr/apr-iconv/tags/%APRICONVVER% %ROOT%\httpd-%HTTPDVER%\srclib\apr-iconv

rem Get Serf Source code
%SVNBINPATH%\svn co http://serf.googlecode.com/svn/tags/%SERFVER% %ROOT%\%DIR%\serf

rem Get Neon Source code
%SVNBINPATH%\svn co http://svn.webdav.org/repos/projects/neon/tags/%NEONVER% %ROOT%\%DIR%\neon
echo %NEONVER%>%ROOT%\%DIR%\neon\.version
rem ****** patch neon\config.hw with neon version number
%AWKDIR%\awk.exe "{gsub(/@VERSION@/,\"%NEONVER%\");gsub(/@MAJOR@/,\"%NEONMAJORVER%\");gsub(/@MINOR@/,\"%NEONMINORVER%\")};1" %ROOT%\%DIR%\neon\config.hw.in > %ROOT%\%DIR%\neon\config.hw

rem Get zlib
%WGET% --directory-prefix=%DLDIR% http://zlib.net/zlib%ZLIBFILEVER%.zip 
%7ZIP% x %DLDIR%\zlib%ZLIBFILEVER%.zip -o%ROOT%\httpd-%HTTPDVER%\srclib\
rename %ROOT%\httpd-%HTTPDVER%\srclib\zlib-%ZLIBVER% zlib

rem Get and build openssl
%WGET% --directory-prefix=%DLDIR% http://www.openssl.org/source/openssl-%OPENSSLVER%.tar.gz
%7ZIP% x %DLDIR%\openssl-%OPENSSLVER%.tar.gz -o%DLDIR%
%7ZIP% x %DLDIR%\openssl-%OPENSSLVER%.tar -o%ROOT%\httpd-%HTTPDVER%\srclib\
rename %ROOT%\httpd-%HTTPDVER%\srclib\openssl-%OPENSSLVER% openssl
pushd %ROOT%\httpd-%HTTPDVER%\srclib\openssl
perl Configure VC-WIN32
call ms\do_nasm
nmake -f ms\ntdll.mak
cd out32dll
call ..\ms\test
popd

rem Get sqlite amalgamation
%WGET% --directory-prefix=%DLDIR% http://www.sqlite.org/sqlite-amalgamation-%SQLITEVER%.zip
%7ZIP% x %DLDIR%\sqlite-amalgamation-%SQLITEVER%.zip -o%ROOT%\%DIR%
rename %ROOT%\%DIR%\sqlite-amalgamation-%SQLITEVER% sqlite-amalgamation

rem Get svn-win32-libintl
%WGET% --directory-prefix=%DLDIR% http://subversion.tigris.org/files/documents/15/20739/svn-win32-libintl.zip
%7ZIP% x %DLDIR%\svn-win32-libintl.zip -o%ROOT%

rem Get JUnit
%WGET% --directory-prefix=%DLDIR% --no-check-certificate https://github.com/downloads/KentBeck/junit/junit%JUNITVER%.zip
%7ZIP% x %DLDIR%\junit%JUNITVER%.zip -o%ROOT%

rem Get BDB Source Code and build it
%WGET% --directory-prefix=%DLDIR% --no-check-certificate http://download.oracle.com/berkeley-db/db-%BDBFULLVER%.zip
%7ZIP% x %DLDIR%\db-%BDBFULLVER%.zip -o%ROOT%
pushd %ROOT%\db-%BDBFULLVER%\build_windows
msdev Berkeley_DB.dsw /USEENV /MAKE "build_all - Win32 Release x86"
msdev Berkeley_DB.dsw /USEENV /MAKE "build_all - Win32 Debug x86"
cd ..
mkdir %BDBDIR%\include
mkdir %BDBDIR%\bin
mkdir %BDBDIR%\lib
copy build_windows\win32\release\*.exe %BDBDIR%\bin\
copy build_windows\win32\release\libdb%BDBVER%.dll %BDBDIR%\bin\
copy build_windows\win32\release\libdb%BDBVER%.lib %BDBDIR%\lib\
copy build_windows\win32\release\libdb%BDBVER%.exp %BDBDIR%\lib\
copy build_windows\win32\debug\libdb%BDBVER%d.dll %BDBDIR%\bin\
copy build_windows\win32\debug\libdb%BDBVER%d.lib %BDBDIR%\lib\
copy build_windows\win32\debug\libdb%BDBVER%d.exp %BDBDIR%\lib\
copy build_windows\db.h %BDBDIR%\include\
copy build_windows\db_cxx.h %BDBDIR%\include\
copy LICENSE %BDBDIR%\
popd

rem Get Cyrus-SASL
%WGET% --directory-prefix=%DLDIR% http://ftp.andrew.cmu.edu/pub/cyrus-mail/cyrus-sasl-%SASLVER%.tar.gz
%7ZIP% x %DLDIR%\cyrus-sasl-%SASLVER%.tar.gz -o%DLDIR%
%7ZIP% x %DLDIR%\cyrus-sasl-%SASLVER%.tar -o%ROOT%
ren %ROOT%\cyrus-sasl-%SASLVER%\win32\common.mak common.mak.in
%AWKDIR%\awk.exe "{gsub(/#VCVER=6/,\"VCVER=6\") };1" %ROOT%\cyrus-sasl-%SASLVER%\win32\common.mak.in > %ROOT%\cyrus-sasl-%SASLVER%\win32\common.mak

set VERBOSE=1
set prefix=%ROOT%\cyrus-sasl-%SASLVER%\Build
set CFG=Release
set DB_LIB=libdb%BDBVER%.lib
set DB_INCLUDE=%ROOT%\db-%BDBFULLVER%\build_windows
set DB_LIBPATH=%ROOT%\db-%BDBFULLVER%\build_windows\Win32\Release
set OPENSSL_INCLUDE=%ROOT%\httpd-%HTTPDVER%\srclib\openssl\inc32
set OPENSSL_LIBPATH=%ROOT%\httpd-%HTTPDVER%\srclib\openssl\out32dll
set GSSAPI=CyberSafe 
set GSSAPI_INCLUDE=C:\Program Files\CyberSafe\Developer Pack\ApplicationSecuritySDK\include
set GSSAPI_LIBPATH=C:\Program Files\CyberSafe\Developer Pack\ApplicationSecuritySDK\lib
::set SQL=SQLITE
::set SQLITE_INCLUDES=/I%ROOT%\%DIR%\sqlite-amalgamation
::set SQLITE_LIBPATH=%ROOT%\%DIR%\sqlite-amalgamation
set LDAP_LIB_BASE=c:\work\open_source\openldap\openldap-head\ldap\Debug
set LDAP_INCLUDE=c:\work\open_source\openldap\openldap-head\ldap\include
set NTLM=1
set SRP=1
set DO_SRP_SETPASS=1
set OTP=1

pushd %ROOT%\cyrus-sasl-%SASLVER%
nmake /f NTMakefile
popd


rem Get SWIG
%WGET% --directory-prefix=%DLDIR% http://downloads.sourceforge.net/project/swig/swigwin/swigwin-%SWIGVER%/swigwin-%SWIGVER%.zip
%7ZIP% x %DLDIR%\swigwin-%SWIGVER%.zip -o%ROOT%

rem Get Asm
rem Get AWK
rem Get Python
rem Get Ruby
rem Get Perl


rem Check that the subversion code exists here.
cd %ROOT%\%DIR%
if not exist subversion goto wrongstartdir
cd %ROOT%

rem ====== Check the prerequisites are at least in the right place.
if not exist httpd-%HTTPDVER% goto httpderr
if not exist nasm goto nasmerr
if not exist openssl-%OPENSSLVER% goto opensslerr
if not exist %DIR% goto svnerr
if not exist zlib goto zliberr
if not exist zlib\zlibstat.lib goto zlibstaterr
if not exist %BDBDIR% goto bdberr
if not exist %DIR%\neon goto neonerr
if not exist gettext goto gettexterr
if not exist cyrus-sasl-%SASLVER% goto cyrussaslerr
goto allok

:wrongstartdir
echo Unable to find %ROOT%\%DIR%\subversion
goto theveryend
:httpderr
echo Unable to find httpd-%HTTPDVER%
goto end
:nasmerr
echo Unable to find nasm
goto end
:opensslerr
echo Unable to find openssl-%OPENSSLVER%
goto end
:svnerr
echo Unable to find Subversion source in %DIR%
goto end
:zliberr
echo Unable to find zlib
goto end
:zlibstaterr
echo Please copy zlib\static32\zlibstat.lib to zlib\zlibstat.lib
goto end
:bdberr
echo Unable to find Berekely DB
goto end
:neonerr
echo Unable to find neon
goto end
:gettexterr
echo Unable to find gettext
goto end
:cyrussaslerr
echo Unable to find cyrus-sasl
goto end
:allok


cd %ROOT%
copy /Y httpd-%HTTPDVER%\srclib\openssl\out32dll\libeay32.dll svn-win32-%VER%\bin
copy /Y httpd-%HTTPDVER%\srclib\openssl\out32dll\ssleay32.dll svn-win32-%VER%\bin
copy /Y httpd-%HTTPDVER%\srclib\openssl\out32dll\openssl.exe  svn-win32-%VER%\bin

rem ======= Builde zlib
cd %ROOT%\httpd-%HTTPDVER%\srclib\zlib
nmake -f win32/Makefile.msc LOC="-DASMV -DASMINF" OBJA="inffas32.obj match686.obj"   
nmake -f win32\Makefile.msc test 
copy /Y zlib.lib zlibstat.lib

rem ====== Build cyrus-sasl
cd %ROOT%
copy /Y cyrus-sasl-%SASLVER%\utils\pluginviewer.exe      svn-win32-%VER%\bin
copy /Y cyrus-sasl-%SASLVER%\utils\sasldblistusers2.exe  svn-win32-%VER%\bin
copy /Y cyrus-sasl-%SASLVER%\utils\saslpasswd2.exe       svn-win32-%VER%\bin
copy /Y cyrus-sasl-%SASLVER%\lib\libsasl.dll             svn-win32-%VER%\bin
copy /Y cyrus-sasl-%SASLVER%\plugins\saslANONYMOUS.dll   svn-win32-%VER%\bin
copy /Y cyrus-sasl-%SASLVER%\plugins\saslDIGESTMD5.dll   svn-win32-%VER%\bin
copy /Y cyrus-sasl-%SASLVER%\plugins\saslCRAMMD5.dll     svn-win32-%VER%\bin
copy /Y cyrus-sasl-%SASLVER%\plugins\saslLOGIN.dll       svn-win32-%VER%\bin
copy /Y cyrus-sasl-%SASLVER%\plugins\saslNTLM.dll        svn-win32-%VER%\bin
copy /Y cyrus-sasl-%SASLVER%\plugins\saslPLAIN.dll       svn-win32-%VER%\bin
copy /Y cyrus-sasl-%SASLVER%\plugins\saslSASLDB.dll      svn-win32-%VER%\bin

rem ====== Generate VC project files
cd %ROOT%\%DIR%
python gen-make.py -t dsp --with-httpd=..\httpd-%HTTPDVER% --with-berkeley-db=%BDBDIR% --with-openssl=..\httpd-%HTTPDVER%\srclib\openssl --with-zlib=..\httpd-%HTTPDVER%\srclib\zlib --with-sasl=..\cyrus-sasl-%SASLVER% --enable-nls --with-libintl=..\svn-win32-libintl --with-serf=..\%DIR%\serf --with-swig=%SWIGDIR% --enable-bdb-in-apr-util --with-junit=%JUNITJAR%

rem ====== Build Apache 2
cd %ROOT%
httpd-%HTTPDVER%\srclib\apr-util\build\w32locatedb.pl dll %BDBDIR%\include %BDBDIR%\lib
msdev httpd-%HTTPDVER%\apache.dsw /MAKE "BuildBin - Win32 Release"
copy /Y httpd-%HTTPDVER%\srclib\apr\Release\libapr-1.dll svn-win32-%VER%\bin
copy /Y httpd-%HTTPDVER%\srclib\apr-iconv\Release\libapriconv-1.dll svn-win32-%VER%\bin
copy /Y httpd-%HTTPDVER%\srclib\apr-iconv\Release\iconv\*.so svn-win32-%VER%\iconv
copy /Y httpd-%HTTPDVER%\srclib\apr-util\Release\libaprutil-1.dll svn-win32-%VER%\bin

rem ====== Subversion
cd %ROOT%\%DIR%
msdev subversion_msvc.dsw /USEENV /MAKE "__ALL_TESTS__ - Win32 Release"
msdev subversion_msvc.dsw /USEENV /MAKE "__SWIG_PYTHON__ - Win32 Release"
msdev subversion_msvc.dsw /USEENV /MAKE "__SWIG_PERL__ - Win32 Release"
msdev subversion_msvc.dsw /USEENV /MAKE "__SWIG_RUBY__ - Win32 Release"
msdev subversion_msvc.dsw /USEENV /MAKE "__JAVAHL__ - Win32 Release"
msdev subversion_msvc.dsw /USEENV /MAKE "test_javahl - Win32 Release"

rem ====== Prepare for tests
mkdir Release\subversion\tests\cmdline
xcopy /S /Y subversion\tests\cmdline Release\subversion\tests\cmdline
cd %ROOT%

rem ====== Copy the binaries into a tree suitable for zipping.
copy /Y %BDBDIR%\bin\libdb%BDBVER%.dll svn-win32-%VER%\bin
copy /Y svn-win32-libintl\bin\intl3_svn.dll svn-win32-%VER%\bin

copy /Y %DIR%\Release\subversion\svn\svn.exe svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\svnadmin\svnadmin.exe svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\svndumpfilter\svndumpfilter.exe svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\svnlook\svnlook.exe svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\svnserve\svnserve.exe svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\svnsync\svnsync.exe svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\svnversion\svnversion.exe svn-win32-%VER%\bin
copy /Y %DIR%\Release\tools\client-side\svnmucc\svnmucc.exe svn-win32-%VER%\bin
copy /Y %DIR%\Release\tools\server-side\svn-populate-node-origins-index.exe svn-win32-%VER%\bin
copy /Y %DIR%\Release\tools\server-side\svnauthz-validate.exe svn-win32-%VER%\bin

copy /Y %DIR%\Release\subversion\mod_dav_svn\mod_dav_svn.so svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\mod_authz_svn\mod_authz_svn.so svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\libsvn_client\libsvn_client-1.dll svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\libsvn_delta\libsvn_delta-1.dll svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\libsvn_diff\libsvn_diff-1.dll svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\libsvn_fs\libsvn_fs-1.dll svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\libsvn_ra\libsvn_ra-1.dll svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\libsvn_repos\libsvn_repos-1.dll svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\libsvn_subr\libsvn_subr-1.dll svn-win32-%VER%\bin
copy /Y %DIR%\Release\subversion\libsvn_wc\libsvn_wc-1.dll svn-win32-%VER%\bin

mkdir svn-win32-%VER%\share\locale\de\LC_MESSAGES
mkdir svn-win32-%VER%\share\locale\es\LC_MESSAGES
mkdir svn-win32-%VER%\share\locale\fr\LC_MESSAGES
mkdir svn-win32-%VER%\share\locale\it\LC_MESSAGES
mkdir svn-win32-%VER%\share\locale\ja\LC_MESSAGES
mkdir svn-win32-%VER%\share\locale\ko\LC_MESSAGES
mkdir svn-win32-%VER%\share\locale\nb\LC_MESSAGES
mkdir svn-win32-%VER%\share\locale\pl\LC_MESSAGES
mkdir svn-win32-%VER%\share\locale\pt_BR\LC_MESSAGES
mkdir svn-win32-%VER%\share\locale\sv\LC_MESSAGES
mkdir svn-win32-%VER%\share\locale\zh_CN\LC_MESSAGES
mkdir svn-win32-%VER%\share\locale\zh_TW\LC_MESSAGES
copy /Y %DIR%\Release\mo\de.mo svn-win32-%VER%\share\locale\de\LC_MESSAGES
copy /Y %DIR%\Release\mo\es.mo svn-win32-%VER%\share\locale\es\LC_MESSAGES
copy /Y %DIR%\Release\mo\fr.mo svn-win32-%VER%\share\locale\fr\LC_MESSAGES
copy /Y %DIR%\Release\mo\it.mo svn-win32-%VER%\share\locale\it\LC_MESSAGES
copy /Y %DIR%\Release\mo\ja.mo svn-win32-%VER%\share\locale\ja\LC_MESSAGES
copy /Y %DIR%\Release\mo\ko.mo svn-win32-%VER%\share\locale\ko\LC_MESSAGES
copy /Y %DIR%\Release\mo\nb.mo svn-win32-%VER%\share\locale\nb\LC_MESSAGES
copy /Y %DIR%\Release\mo\pl.mo svn-win32-%VER%\share\locale\pl\LC_MESSAGES
copy /Y %DIR%\Release\mo\pt_BR.mo svn-win32-%VER%\share\locale\pt_BR\LC_MESSAGES
copy /Y %DIR%\Release\mo\sv.mo svn-win32-%VER%\share\locale\sv\LC_MESSAGES
copy /Y %DIR%\Release\mo\zh_CN.mo svn-win32-%VER%\share\locale\zh_CN\LC_MESSAGES
copy /Y %DIR%\Release\mo\zh_TW.mo svn-win32-%VER%\share\locale\zh_TW\LC_MESSAGES

mkdir svn-win32-%VER%\licenses\apr
mkdir svn-win32-%VER%\licenses\apr-iconv
mkdir svn-win32-%VER%\licenses\apr-util
mkdir svn-win32-%VER%\licenses\bdb
mkdir svn-win32-%VER%\licenses\cyrussasl
mkdir svn-win32-%VER%\licenses\neon
mkdir svn-win32-%VER%\licenses\OPENSSL
mkdir svn-win32-%VER%\licenses\serf
mkdir svn-win32-%VER%\licenses\SVN
mkdir svn-win32-%VER%\licenses\zlib
copy /Y httpd-%HTTPDVER%\srclib\apr\LICENSE svn-win32-%VER%\licenses\apr\LICENSE.txt
copy /Y httpd-%HTTPDVER%\srclib\apr\NOTICE svn-win32-%VER%\licenses\apr\NOTICE.txt
copy /Y httpd-%HTTPDVER%\srclib\apr-iconv\LICENSE svn-win32-%VER%\licenses\apr-iconv\LICENSE.txt
copy /Y httpd-%HTTPDVER%\srclib\apr-iconv\NOTICE svn-win32-%VER%\licenses\apr-iconv\"APR-ICONV NOTICE.txt"
copy /Y httpd-%HTTPDVER%\srclib\apr-util\LICENSE svn-win32-%VER%\licenses\apr-util\LICENSE.txt
copy /Y httpd-%HTTPDVER%\srclib\apr-util\NOTICE svn-win32-%VER%\licenses\apr-util\"APR-UTIL NOTICE.txt"
copy /Y %BDBDIR%\LICENSE svn-win32-%VER%\licenses\bdb
copy /Y cyrus-sasl-%SASLVER%\COPYING svn-win32-%VER%\licenses\cyrussasl\COPYING.txt
copy /Y %DIR%\neon\src\COPYING.LIB svn-win32-%VER%\licenses\neon\COPYING.txt
copy /Y httpd-%HTTPDVER%\srclib\openssl\LICENSE svn-win32-%VER%\licenses\openssl\LICENSE.txt
copy /Y %DIR%\serf\LICENSE svn-win32-%VER%\licenses\serf\LICENSE.txt
copy /Y %DIR%\LICENSE svn-win32-%VER%\licenses\SVN\LICENSE.txt
copy /Y httpd-%HTTPDVER%\srclib\zlib\README svn-win32-%VER%\licenses\zlib\README.txt
copy /Y README.txt svn-win32-%VER%\README.txt
::copy /Y svn-book.chm svn-win32-%VER%\bin\svn-book.chm

rem ====== Configure Apache ready for doing tests.
@echo off
echo Configure Apache to use the mod_dav_svn and mod_authz_svn modules
echo by making sure these lines appear uncommented in httpd.conf:
echo LoadModule dav_module         modules/mod_dav.so
echo LoadModule dav_fs_module      modules/mod_dav_fs.so
echo LoadModule dav_svn_module     modules/mod_dav_svn.so
echo LoadModule authz_svn_module   modules/mod_authz_svn.so
echo And further down the file add:
echo ^<Location /svn-test-work/repositories>
echo   DAV svn
echo   SVNParentPath %DRIVE%:/SVN/%DIR%/Release/subversion/tests/cmdline/svn-test-work/repositories
echo   SVNListParentPath On
echo   AuthzSVNAccessFile %DRIVE%:/SVN/%DIR%/Release/subversion/tests/cmdline/svn-test-work/authz
echo   AuthType Basic
echo   AuthName "Subversion Repository"
echo   AuthUserFile "%APACHEDIR%/conf/users"
echo   Require valid-user
echo ^</Location>
echo   
echo ^<Location /svn-test-work/local_tmp/repos>
echo   DAV svn
echo   SVNPath %DRIVE%:/SVN/%DIR%/Release/subversion/tests/cmdline/svn-test-work/local_tmp/repos
echo   AuthzSVNAccessFile %DRIVE%:/SVN/%DIR%/Release/subversion/tests/cmdline/svn-test-work/authz
echo   AuthType Basic
echo   AuthName "Subversion Repository"
echo   AuthUserFile "%APACHEDIR%/conf/users"
echo   Require valid-user
echo ^</Location>
echo
echo Then restart Apache.
echo
echo Add a users file in Apache containing
echo jrandom:$apr1$3p1.....$FQW6RceW5QhJ2blWDQgKn0
echo jconstant:$apr1$jp1.....$Usrqji1c9H6AbOxOGAzzb0
echo
echo Password is rayjandom 

echo Please configure Apache and press enter:
pause
@echo on

rem ====== Run the tests.
PATH=%ROOT%\svn-win32-%VER%\bin;%PATH%
cd %ROOT%\%DIR%
python win-tests.py -c -r -v
python win-tests.py -c -r -v -f bdb
python win-tests.py -c -r -v -u svn://localhost
python win-tests.py -c -r -v -u http://localhost --http-library=neon
python win-tests.py -c -r -v -u http://localhost --http-library=serf

rem python win-tests.py -c -r -v --javahl
rem python win-tests.py -c -r -v -f bdb --javahl
rem python win-tests.py -c -r -v -u svn://localhost --javahl
rem python win-tests.py -c -r -v -u http://localhost --http-library=neon --javahl
rem python win-tests.py -c -r -v -u http://localhost --http-library=serf --javahl

rem ===== Build release. =====
rem ==== Edit %DIR%\build\win32\make_dist.conf =====
cd %ROOT%
%AWKDIR%\awk.exe "{gsub(/bdbver = [0-9]*/,\"bdbver = %BDBVER%\"); };1" %DIR%\build\win32\make_dist.conf.template > %DIR%\build\win32\make_dist.conf

rem ====== Regenerate VC project files - make_dist doesn't like junit-dir
cd %ROOT%\%DIR%
python gen-make.py -t dsp --with-httpd=..\httpd-%HTTPDVER% --with-berkeley-db=%BDBDIR% --with-openssl=..\httpd-%HTTPDVER%\srclib\openssl --with-zlib=..\httpd-%HTTPDVER%\srclib\zlib --with-sasl=..\cyrus-sasl-%SASLVER% --enable-nls --with-libintl=..\svn-win32-libintl --with-serf=..\%DIR%\serf --with-swig=%SWIGDIR% --enable-bdb-in-apr-util --with-junit=%JUNITDIR%

cd %ROOT%
python %DIR%\build\win32\make_dist.py --readme=%ROOT%\README.txt svn-win32-%VER% svn-win32-%VER%

:end
cd %DIR%
endlocal
:theveryend
