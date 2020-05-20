@echo off

set "CWD=%CD%"
cd %~dp0

set UNICODE_HELPER_GENERATOR=%~dp0EIFGENs\unicode_helper_generator\F_code\unicode_helper_generator.exe

if not exist "%UNICODE_HELPER_GENERATOR%" (
	echo Cannot find "%UNICODE_HELPER_GENERATOR%"
	echo Compile the tool in finalized mode before running the script.
	cd %CWD%
	goto :eof
)

if not exist "UnicodeData.txt" (
	echo Cannot find "%CWD%UnicodeData.txt".
	cd %CWD%
	goto :eof
)

set WSLENV=
set WSLENV=%WSLENV%:UNICODE_HELPER_GENERATOR/p

start /b /w bash -c ./gelex_category.sh

cd %CWD%
