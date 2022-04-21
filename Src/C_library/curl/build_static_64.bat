@echo on
title Script to compile cURL on Windows 64 bits statically
rem Clean the folders under directy builds
rem Compiles cURL static library 
rem Copy the static library libcurl_a.lib to 
rem cURL/spec/win64/static/lib/libcurl_a.lib


set current_dir = %~dp0

rem clean build directory.
IF exist %current_dir%builds\nul ( 
	cd %current_dir%builds/
	rd /s /q . 2>nul 
	cd ..
)

rem go to the winbuild directory in the Curl
cd %cd%/winbuild

@echo Compiling cURL 64bits statically

espawn "nmake RTLIBCFG=static /f Makefile.vc mode=static GEN_PDB=no DEBUG=no MACHINE=x64"


cd ..
mkdir spec\win64\static\lib
copy %cd%\builds\libcurl-vc-x64-release-static-ipv6-sspi-winssl\lib\libcurl_a.lib  %cd%\spec\win64\static\lib


IF exist %current_dir%builds ( 
	rd /s /q %current_dir%builds
)
