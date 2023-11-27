@echo off
if not defined ISE_PLATFORM (
	echo Error: Environment variable ISE_PLATFORM is not set.
	exit 1
)

if "%EWEASEL_PLATFORM%" NEQ "" goto MAIN
if "%ISE_PLATFORM%" == "dotnet" 	goto DOTNET
if "%ISE_PLATFORM%" == "windows" 	goto WIN32
if "%ISE_PLATFORM%" == "win64" 		goto WIN64

echo Error: Environment variable ISE_PLATFORM is assigned an invalid value:
echo "%ISE_PLATFORM%". Supported values: "dotnet", "windows", "win64".
exit 1

:DOTNET
REM Comment next line, to avoid testing with .NETCore
set NETCORE=C:\Program Files\dotnet
set EWEASEL_PLATFORM=DOTNET
goto MAIN

:WIN32
:WIN64
set EWEASEL_PLATFORM=windows
goto MAIN

:MAIN

if not defined EWEASEL set EWEASEL=%~dp0..
if not defined EWEASEL_OUTPUT set EWEASEL_OUTPUT=%EWEASEL%\tmp

set EWEASEL_COMMAND=%EWEASEL%\spec\%ISE_PLATFORM%\bin\eweasel-mt.exe
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -max_threads %NUMBER_OF_PROCESSORS%
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -define EWEASEL "%EWEASEL%"
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -define INCLUDE "%EWEASEL%\control"
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -define ISE_EIFFEL "%ISE_EIFFEL%"
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -define ISE_PLATFORM %ISE_PLATFORM%
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -define ISE_LIBRARY "%ISE_LIBRARY%"
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -define %EWEASEL_PLATFORM% 1
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -define PLATFORM_TYPE %EWEASEL_PLATFORM%
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -init "%EWEASEL%\control\init"
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -output "%EWEASEL_OUTPUT%"

set ISE_LANG=en_US

rem Create a precompilation folder if no one is specified
if "%ISE_PRECOMP%" == "" (
	echo Preparing precompiled libraries
	call :create_folder "%EWEASEL_OUTPUT%\..\eweasel_precomp"
	call :create_folder "%EWEASEL_OUTPUT%\..\eweasel_precomp\%ISE_PLATFORM%"
	set ISE_PRECOMP=%EWEASEL_OUTPUT%\..\eweasel_precomp\%ISE_PLATFORM%
)

goto :eof

:create_folder
if not exist %1 (
	echo Creating %1
	mkdir %1
)
goto :eof

:eof
echo EWEASEL_OUTPUT=%EWEASEL_OUTPUT%
echo ISE_PRECOMP=%ISE_PRECOMP%
