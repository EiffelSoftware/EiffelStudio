@echo off
rem 
rem	Script to build an iron package archive
rem 	usage: prog {source_directory} {archive_directory} {archive_name}
rem
rem ex: %ISE_EIFFEL%\tools\iron\spec\%ISE_PLATFORM%\bin\iron_build_archive.bat %ISE_EIFFEL%\library\base %cd%\iron_archives base.tar.bz2


setlocal
set T_HERE=%CD%

set T_SOURCE_DIR=%~f1
set T_ARCHIVE_DIR=%~f2
set T_ARCHIVE_NAME=%3

echo Build archive from "%T_SOURCE_DIR%" into "%T_ARCHIVE_DIR%\%T_ARCHIVE_NAME%"

if exist "%T_ARCHIVE_DIR%\%T_ARCHIVE_NAME%" goto archive_exists


if not exist "%T_SOURCE_DIR%" goto no_source

if not exist "%T_ARCHIVE_DIR%" mkdir "%T_ARCHIVE_DIR%"
if not exist "%T_ARCHIVE_DIR%" goto no_archive_dir
chdir "%T_ARCHIVE_DIR%"

chdir "%T_SOURCE_DIR%"
echo  - Archiving "%T_SOURCE_DIR%" with tar
if exist "%T_ARCHIVE_DIR%\archive.tar" goto failure
%~dp0tar.exe cfp - * > "%T_ARCHIVE_DIR%\archive.tar"
if not exist "%T_ARCHIVE_DIR%\archive.tar" goto failure

chdir "%T_ARCHIVE_DIR%"
echo  - Compressing archive using bzip2
if exist archive.tar.bz2 goto failure
%~dp0bzip2.exe -z archive.tar > :NUL
if not exist archive.tar.bz2 goto failure
rename archive.tar.bz2 "%T_ARCHIVE_NAME%"
if not exist "%T_ARCHIVE_NAME%" goto failure
echo Done.

goto end

:archive_exists
echo ERROR: Archive "%T_ARCHIVE_NAME%" already exists!
goto failure

:no_archive_dir
echo ERROR: Archive directory "%T_ARCHIVE_DIR%" does not exists!
goto failure

:no_source
echo ERROR: Source "%T_SOURCE_DIR%" does not exists!
goto failure

:failure
echo ERROR: Operation failed
if exist "%T_ARCHIVE_DIR%\archive.tar" del "%T_ARCHIVE_DIR%\archive.tar"
if exist "%T_ARCHIVE_DIR%\archive.tar.bz2" del "%T_ARCHIVE_DIR%\archive.tar.bz2"
chdir "%T_HERE%"
endlocal
exit /B 1

:end
if exist "%T_ARCHIVE_DIR%\archive.tar" del "%T_ARCHIVE_DIR%\archive.tar"
if exist "%T_ARCHIVE_DIR%\archive.tar.bz2" del "%T_ARCHIVE_DIR%\archive.tar.bz2"
chdir "%T_HERE%"
endlocal
exit /B 0
