@IF DEFINED NOECHO echo off

echo ====== Set component version environment variables ======
set VER=1.8.1
set RUBYVER=1.8.6
set BDBFULLVER=4.8.30
set SWIGVER=1.3.40
set JAVAVER=1.7.0_25
set JUNITVER=4.11
set OPENSSLVER=1.0.1e
set HTTPDFULLVER=2.2.25
::set HTTPDFULLVER=2.4.6
set SASLVER=2.1.23
::set SASLVER=2.1.26
set APRVER=1.4.8
set APRUTILVER=1.5.2
set APRICONVVER=1.2.1
set SERFVER=1.2.1
set ZLIBVER=1.2.8
set SQLITEVER=3.7.17.0
set SQLITEYEAR=2013
set PCREVER=8.32
set GTESTVER=1.6.0

set MODE=Release
::set MODE=Debug

:RUBY
for /f "tokens=1,2,3 delims=/." %%a in ("%RUBYVER%") do set RUBYFILEVER=%%a%%b%%c

:BDB
for /f "tokens=1,2 delims=/." %%a in ("%BDBFULLVER%") do set BDBVER=%%a%%b

:HTTPD
for /f "tokens=1,2 delims=/." %%a in ("%HTTPDFULLVER%") do set HTTPDVER=%%a%%b
for /f "tokens=1,2 delims=/." %%a in ("%HTTPDFULLVER%") do set HTTPDVERDIR=%%a.%%b

:ZLIB
set ZLIBFILEVER=%ZLIBVER:.=%

:SQLITE
for /f "tokens=1,2,3,4 delims=/." %%a in ("%SQLITEVER%") do set SQLT1=%%a& set SQLT2=0%%b& set SQLT3=0%%c& set SQLT4=0%%d
set SQLITEFILEVER=%SQLT1:~-1%%SQLT2:~-2%%SQLT3:~-2%%SQLT4:~-2%
