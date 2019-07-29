@echo off

rem description: "Install Gobo Eiffel tools"
rem copyright: "Copyright (c) 2007-2019, Eric Bezault and others"
rem license: "MIT License"
rem date: "$Date$"
rem revision: "$Revision$"


rem "usage: install.bat [-v] <c_compiler>"


if .%1. == .-v. goto verbose
goto no_verbose

:no_verbose
	set VERBOSE=
	set CC=%1
	set EIF=ge
	goto do_it

:verbose
	set VERBOSE=-v
	set CC=%2
	set EIF=ge
	goto do_it

:do_it
	if .%GOBO%. == .. goto gobo
	goto windows

:gobo
	echo Environment variable GOBO must be set
	goto exit

:windows
	set EXE=.exe
	goto c_compilation

:c_compilation
	if .%CC%. == .. goto usage
	if .%CC%. == .-help. goto usage
	if .%CC%. == .--help. goto usage
	if .%CC%. == .-h. goto usage
	if .%CC%. == .-?. goto usage
	if .%CC%. == ./h. goto usage
	if .%CC%. == ./?. goto usage
	if .%EIF%. == .. goto usage

	set BIN_DIR=%GOBO%\bin
	set BOOTSTRAP_DIR=%GOBO%\tool\gec\bootstrap
	cd %BIN_DIR%
	call %BOOTSTRAP_DIR%\bootstrap.bat %VERBOSE% %CC%
	goto install

:install
	if .%EIF%. == .ge. goto ge
	echo Unknown Eiffel compiler: %EIF%
	goto exit

:ge
	cd %BIN_DIR%
	%BIN_DIR%\gec%EXE% --finalize --no-benchmark %GOBO%\tool\geant\src\system.ecf
	%BIN_DIR%\gec%EXE% --finalize --no-benchmark %GOBO%\tool\gelex\src\system.ecf
	%BIN_DIR%\gec%EXE% --finalize --no-benchmark %GOBO%\tool\geyacc\src\system.ecf
	%BIN_DIR%\gec%EXE% --finalize --no-benchmark %GOBO%\tool\gepp\src\system.ecf
	%BIN_DIR%\gec%EXE% --finalize --no-benchmark %GOBO%\tool\getest\src\system.ecf
	%BIN_DIR%\gec%EXE% --finalize --no-benchmark %GOBO%\tool\gelint\src\system.ecf
	%BIN_DIR%\gec%EXE% --finalize --no-benchmark %GOBO%\tool\gedoc\src\system.ecf
	%BIN_DIR%\gec%EXE% --finalize --no-benchmark %GOBO%\tool\gecop\src\system.ecf
	%BIN_DIR%\gec%EXE% --finalize --no-benchmark %GOBO%\tool\gexslt\src\system.ecf
	goto clean

:clean
	set PATH=%BIN_DIR%;%PATH%
	cd %BIN_DIR%
	geant%EXE% %VERBOSE% --buildfilename=%GOBO%\tool\gec\src\build.eant clean
	geant%EXE% %VERBOSE% --buildfilename=%GOBO%\tool\gecc\src\build.eant clean
	geant%EXE% %VERBOSE% --buildfilename=%GOBO%\tool\geant\src\build.eant clean
	geant%EXE% %VERBOSE% --buildfilename=%GOBO%\tool\gelex\src\build.eant clean
	geant%EXE% %VERBOSE% --buildfilename=%GOBO%\tool\geyacc\src\build.eant clean
	geant%EXE% %VERBOSE% --buildfilename=%GOBO%\tool\gepp\src\build.eant clean
	geant%EXE% %VERBOSE% --buildfilename=%GOBO%\tool\getest\src\build.eant clean
	geant%EXE% %VERBOSE% --buildfilename=%GOBO%\tool\gelint\src\build.eant clean
	geant%EXE% %VERBOSE% --buildfilename=%GOBO%\tool\gedoc\src\build.eant clean
	geant%EXE% %VERBOSE% --buildfilename=%GOBO%\tool\gecop\src\build.eant clean
	geant%EXE% %VERBOSE% --buildfilename=%GOBO%\tool\gexslt\src\build.eant clean
	goto exit

:usage
	echo usage: install.bat [-v] ^<c_compiler^>
	echo    c_compiler:  msc ^| lcc-win32 ^| lcc-win64 ^| bcc ^| gcc ^| mingw ^| clang ^| cc ^| icc ^| tcc ^| no_c
	goto exit

:exit
