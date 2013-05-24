@echo off

rem 
rem	Script to extract an iron package archive
rem 	usage: prog {archive_path} {folder_directory} 
rem
rem ex: %ISE_EIFFEL%\tools\iron\spec\%ISE_PLATFORM%\bin\iron_extract_archive.bat %cd%\iron_archives\base.tar.bz2 libs\base

setlocal
set T_HERE=%CD%

set T_ARCHIVE_NAME=%1
set T_FOLDER_DIR=%~f2

if not exist "%T_ARCHIVE_NAME%" goto missing_archive
rem if exist "%T_FOLDER_DIR%" goto target_exists
if not exist "%T_FOLDER_DIR%" mkdir "%T_FOLDER_DIR%"
if not exist "%T_FOLDER_DIR%" goto failure

if exist "%T_FOLDER_DIR%\archive.tar.bz2" del archive.tar.bz2
copy /V /Y %T_ARCHIVE_NAME% "%T_FOLDER_DIR%\archive.tar.bz2" 
if not exist "%T_FOLDER_DIR%\archive.tar.bz2" goto failure


chdir "%T_FOLDER_DIR%"
"%~dp0bzip2.exe" -cd archive.tar.bz2 | "%~dp0tar.exe" xp > :NUL
if %ERRORLEVEL% NEQ 0 echo ERR=%ERRORLEVEL%

del archive.tar.bz2

goto end

:missing_archive
echo ERROR: Archive "%T_ARCHIVE_NAME%" can not be found!
goto failure

:target_exists
echo ERROR: Folder "%T_FOLDER_DIR%" already exists!
goto failure

:failure
echo ERROR: Operation failed
chdir "%T_HERE%"
endlocal
exit /B 1

:end
chdir "%T_HERE%"
endlocal
exit /B 0
