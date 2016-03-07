REM @ECHO OFF
REM #######################################################################
REM FILE       mk_htmlhelp.bat
REM PURPOSE    Making MS HTML help file out of the svn-book sources
REM ====================================================================
REM Copyright (c) 2000-2005 CollabNet.  All rights reserved.
REM
REM This software is licensed as described in the file COPYING, which
REM you should have received as part of this distribution.  The terms
REM are also available at http://subversion.tigris.org/license-1.html.
REM If newer versions of this license are posted there, you may use a
REM newer version instead, at your option.
REM
REM This software consists of voluntary contributions made by many
REM individuals.  For exact contribution history, see the revision
REM history and logs, available at http://subversion.tigris.org/.
REM ====================================================================
SET LIBXML2PATH=..\libxml2-2.7.8.win32\bin
SET BOOKNAME=svn-book
SET HHC="%ProgramFiles%\HTML Help Workshop\hhc.exe"
SET DOCBOOKXSL=.\docbook-xsl-1.78.1
SET SOURCEDIR=.\svn-book
SET WORK=.\work
SET BOOKDEST=.\out

::svn co http://svnbook.googlecode.com/svn/branches/1.8/en %SOURCEDIR%
::svn co http://svnbook.googlecode.com/svn/branches/1.8/tools .\tools
svn co https://svn.code.sf.net/p/svnbook/source/trunk/en %SOURCEDIR%
svn co https://svn.code.sf.net/p/svnbook/source/trunk/tools .\tools

mkdir %WORK%\images
copy %SOURCEDIR%\book\images\*.* %WORK%\images
copy svn_bck.png %WORK%
copy svn-doc.css %WORK%

for /f "delims=" %%A in ('svnversion %SOURCEDIR%') do set BookVersion=%%A
SET VersionText=^^^<^!ENTITY svn.version "%BookVersion%"^^^>
SET VersionText2=^^^<^!ENTITY svn.l10n_revision "Revision "^^^>
echo %VersionText% > %SOURCEDIR%\book\version.xml
echo %VersionText2% >> %SOURCEDIR%\book\version.xml

SET XLSPARAMS=--param suppress.navigation 0 --param htmlhelp.hhc.binary 1
SET XLSPARAMS=%XLSPARAMS% --param htmlhelp.show.advanced.search 1
SET XLSPARAMS=%XLSPARAMS% --param htmlhelp.chm '%BOOKNAME%.chm'
SET XLSPARAMS=%XLSPARAMS% --param htmlhelp.hhp '%BOOKNAME%.hhp'
SET XLSPARAMS=%XLSPARAMS% --param htmlhelp.hhc '%BOOKNAME%.hhc'
SET XLSPARAMS=%XLSPARAMS% --param html.stylesheet.type 'text/css'
SET XLSPARAMS=%XLSPARAMS% --param html.stylesheet 'svn-doc.css'
SET XLSPARAMS=%XLSPARAMS% --param htmlhelp.hhp.tail 'svn_bck.png'
SET XLSPARAMS=%XLSPARAMS% --param htmlhelp.use.hhk 0
SET XLSPARAMS=%XLSPARAMS% --param htmlhelp.hhc.show.root 0
SET XLSPARAMS=%XLSPARAMS% --param htmlhelp.autolabel 1

cd %WORK%
%LIBXML2PATH%\xsltproc %XLSPARAMS% ..\%DOCBOOKXSL%\htmlhelp\htmlhelp.xsl ..\%SOURCEDIR%\book\book.xml

%HHC% %BOOKNAME%.hhp
mkdir ..\%BOOKDEST%
copy %BOOKNAME%.chm ..\%BOOKDEST%\%BOOKNAME%.chm

cd ..
del /Q %BOOKNAME%.*
rmdir /S /Q %WORK%
