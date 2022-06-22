@echo on
title Script to compile cURL on Windows 32 bits statically
rem Clean the folders under directy builds
rem Compiles cURL static library 
rem Copy the static library libcurl_a.lib to 
rem cURL/spe/static/lib/libcurl_a.lib


set current_dir = %~dp0

rem clean build directory.
IF exist %current_dir%builds\nul ( 
	cd %current_dir%builds/
	rd /s /q . 2>nul 
	cd ..
)

cd %cd%/winbuild

@echo Compiling cURL 32bits statically

set espawn_cmd=espawn
IF "%ISE_PLATFORM%" NEQ "windows" set espawn_cmd=%espawn_cmd% --x86
%espawn_cmd% "nmake RTLIBCFG=static /f Makefile.vc mode=static GEN_PDB=no DEBUG=no MACHINE=x86"

cd ..
mkdir spec\windows\static\lib
copy %cd%\builds\libcurl-vc-x86-release-static-ipv6-sspi-winssl\lib\libcurl_a.lib %cd%\spec\windows\static\lib

IF exist %current_dir%builds ( 
	rd /s /q %current_dir%builds
)
