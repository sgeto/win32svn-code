@IF DEFINED NOECHO echo off

echo ====== Set component version environment variables ======
set VER=1.7.9
set RUBYVER=1.8.6
set BDBFULLVER=4.8.30
set SWIGVER=1.3.40
set JAVAVER=1.6.0_41
set JUNITVER=4.11
set OPENSSLVER=1.0.1e
set HTTPDFULLVER=2.2.24
::set HTTPDFULLVER=2.4.4
set SASLVER=2.1.23
set APRVER=1.4.6
set APRUTILVER=1.3.12
::set APRUTILVER=1.4.2
set APRICONVVER=1.2.1
set NEONVER=0.29.6
set SERFVER=1.2.0
set ZLIBVER=1.2.7
set SQLITEVER=3.7.16.1
set SQLITEYEAR=2013
set PCREVER=8.32


:RUBY
for /f "tokens=1,2,3 delims=/." %%a in ("%RUBYVER%") do set RUBYFILEVER=%%a%%b%%c

:BDB
for /f "tokens=1,2 delims=/." %%a in ("%BDBFULLVER%") do set BDBVER=%%a%%b

:HTTPD
for /f "tokens=1,2 delims=/." %%a in ("%HTTPDFULLVER%") do set HTTPDVER=%%a%%b
for /f "tokens=1,2 delims=/." %%a in ("%HTTPDFULLVER%") do set HTTPDVERDIR=%%a.%%b

:NEON
for /f "tokens=1,2 delims=/." %%a in ("%NEONVER%") do set NEONMAJORVER=%%a& set NEONMINORVER=%%b

:ZLIB
set ZLIBFILEVER=%ZLIBVER:.=%

:SQLITE
for /f "tokens=1,2,3,4 delims=/." %%a in ("%SQLITEVER%") do set SQLT1=%%a& set SQLT2=0%%b& set SQLT3=0%%c& set SQLT4=0%%d
set SQLITEFILEVER=%SQLT1:~-1%%SQLT2:~-2%%SQLT3:~-2%%SQLT4:~-2%
