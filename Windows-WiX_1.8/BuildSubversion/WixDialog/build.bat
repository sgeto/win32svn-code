rem
rem
rem Licensed to the Apache Software Foundation (ASF) under one
rem or more contributor license agreements.  See the NOTICE file
rem distributed with this work for additional information
rem regarding copyright ownership.  The ASF licenses this file
rem to you under the Apache License, Version 2.0 (the
rem "License"); you may not use this file except in compliance
rem with the License.  You may obtain a copy of the License at
rem
rem   http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing,
rem software distributed under the License is distributed on an
rem "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
rem KIND, either express or implied.  See the License for the
rem specific language governing permissions and limitations
rem under the License.
rem
set WIX_PATH=%ProgramFiles%\Windows Installer XML v3.5\bin
"%WIX_PATH%\candle.exe" -dinfoRtf=${uiextension.wixlib.dir.src}\Pre.rtf -dpostRtf=${uiextension.wixlib.dir.src}\Post.rtf WixUI_Subversion.wxs Infodlg.wxs ApacheSelectDlg.wxs WelcomeDlgSv.wxs PostDlg.wxs
"%WIX_PATH%\lit.exe" -out WixUI_Subversion.wixlib WixUI_Subversion.wixobj infodlg.wixobj WelcomeDlgSv.wixobj ApacheSelectDlg.wixobj PostDlg.wixobj

