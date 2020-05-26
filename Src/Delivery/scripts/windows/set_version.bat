@echo off
rem Set Version
rem %1 : svn wc path
rem %2 : 0000
rem %3 : filename.e
setlocal
set SVNWCT=%1
set REVVAL=%2
set EFILE=%3
set EFILE_TMP=%EFILE%.tmp
set LC_MESSAGES=C

svn info %SVNWCT% > %EFILE_TMP%
For /f "tokens=1-4 delims=/ " %%a in ('findstr /L /B /C:"Last Changed Rev" %EFILE_TMP%') do (set LASTREV=%%d)
del /Q %EFILE_TMP%
if .%LASTREV%. == .. set LASTREV=%REVVAL% -- Script was unable to set this value

if .%EFILE%. == .. GOTO DISPLAY_SVN_REVISION

REM echo Set version: LASTREV=%LASTREV%
svn revert -q %EFILE% 
sed -e "s/:= %REVVAL%/:= %LASTREV%/" %EFILE% > %EFILE_TMP%
move /Y %EFILE_TMP% %EFILE% >nul

REM update the version_info ...
for /f %%x in ('wmic path win32_utctime get /format:list ^| findstr "="') do set %%x
 IF %month% LSS 10 SET month=0%month%
 IF %day% LSS 10 SET day=0%day%
 IF %hour% LSS 10 SET hour=0%hour%
 IF %minute% LSS 10 SET minute=0%minute%
 IF %second% LSS 10 SET second=0%second%
set CURRDATE=%Year%-%Month%-%Day%
set CURRTIME=%hour%:%minute%:%second%

sed -e "s/Version_info:\ STRING\ =\ \"[0-9a-zA-Z_\,\ \/\:()\.\=\-]*\"/Version_info:\ STRING\ =\ \"Revision:\ %LASTREV% , Compilation:\ %CURRDATE%\ %CURRTIME%\"/g" %EFILE% > %EFILE_TMP%
::sed -e "s/Version_info:\ STRING\ =\ \"[0-9a-zA-Z_\,\ \/\:()\.\=\-]*\"/Version_info:\ STRING\ =\ \"Revision:\ %LASTREV% , Compilation:\ %CURRDATE%\ %CURRTIME% , Builder:\ %USERNAME%\"/g" %EFILE% > %EFILE_TMP%
move /Y %EFILE_TMP% %EFILE% >nul
goto END

:DISPLAY_SVN_REVISION
echo %LASTREV%
goto END

:END

endlocal
@echo on
