@IF DEFINED NOECHO echo off

echo ====== Set Visual studio environment ======
set VSCommonDir=C:\Program Files\Microsoft Visual Studio\Common
set MSDevDir=C:\Program Files\Microsoft Visual Studio\Common\msdev98
set MSVCDir=C:\Program Files\Microsoft Visual Studio\VC98
PATH=%MSDevDir%\BIN;%MSVCDir%\BIN;%VSCommonDir%\TOOLS\WINNT;%VSCommonDir%\TOOLS;%PATH%
set INCLUDE=%MSVCDir%\ATL\INCLUDE;%MSVCDir%\INCLUDE;%MSVCDir%\MFC\INCLUDE;%INCLUDE%
set LIB=%MSVCDir%\LIB;%MSVCDir%\MFC\LIB;%LIB%
set VSCommonDir=

rem Add INCLUDE and LIB for the SDK
set SDKINC=C:\Program Files\Microsoft SDK\include
set SDKLIB=C:\Program Files\Microsoft SDK\lib
set INCLUDE=%SDKINC%;%INCLUDE%
:: %GETTEXTINC%;%PERLDIR%\lib\CORE;%PYTHONDIR%\include;%JAVADIR%\include
set LIB=%SDKLIB%;%LIB%
:: %GETTEXTLIB%;%PERLDIR%\lib\CORE;%PYTHONDIR%\libs;%RUBYDIR%\lib;%JAVADIR%\lib
