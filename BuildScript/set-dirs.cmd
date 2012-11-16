@IF DEFINED %NOECHO% echo off

echo ====== Set directories environment variables ======

set DIR=src-%VER%
set DRIVE=C
set ROOT=%DRIVE%:\SVN-%VER%-%HTTPDVER%
set DLDIR=%ROOT%\Download
set PERLDIR=C:\Perl
set RUBYDIR=C:\Ruby%RUBYFILEVER%
set RUBYDIRAWK=C:\/Ruby%RUBYFILEVER%
set AWKDIR=C:\awk
set NASMDIR=C:\asm
set GETTEXTDIR=C:\gettext
set GETTEXTINC=%GETTEXTDIR%\include
set GETTEXTLIB=%GETTEXTDIR%\lib
set GETTEXTBIN=%GETTEXTDIR%\bin
set HTTPDDIR=httpd-%HTTPDFULLVER%
set HTTPDINSTDIR=C:\Program Files\Apache%HTTPDVERDIR%
set BDBDIR=%ROOT%\db-%BDBFULLVER%\build_windows\Win32
set SWIGDIR=%ROOT%\SWIGWIN-%SWIGVER%
set JAVADIR=C:\Program Files\Java\jdk%JAVAVER%
set JUNITDIR=%ROOT%\junit%JUNITVER%
set JUNITJAR=%JUNITDIR%\junit-%JUNITVER%.jar
set SVNBINPATH="C:\Program Files\Subversion\bin\"
set ZZIP="C:\Program Files\7-Zip\7z.exe"
set WGET="C:\Program Files\GnuWin32\bin\wget.exe"
set ZIPEXE=C:/zip/zip.exe
set SYSINTERNALS="C:\Program Files\SysInternals\"

rem Set up path to include Python and BDB.
set PATHBASE=%PATH%
PATH=%PATHBASE%;%NASMDIR%;%RUBYDIR%\bin;%GETTEXTBIN%
::%BDBDIR%;%AWKDIR%;%GETTEXTBIN%;%JAVADIR%\bin
::PATH=%PATHBASE%;%PYTHONDIR%

rem set Classpath for javahl tests
::SET CLASSPATH=%JUNITJAR%;%JUNITDIR%
