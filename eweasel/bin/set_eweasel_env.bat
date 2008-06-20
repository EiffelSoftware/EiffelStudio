@echo off
if not defined ISE_PLATFORM (
	echo Error: Environment variable ISE_PLATFORM is not set.
	exit 1
)

if "%EWEASEL_PLATFORM%" == "" (
if "%ISE_PLATFORM%" == "dotnet" (
	set EWEASEL_PLATFORM=DOTNET
) else if "%ISE_PLATFORM%" == "windows" (
	set EWEASEL_PLATFORM=WINDOWS
) else if "%ISE_PLATFORM%" == "win64" (
	set EWEASEL_PLATFORM=WINDOWS
) else (
	echo Error: Environment variable ISE_PLATFORM is assigned an invalid value:
	echo "%ISE_PLATFORM%". Supported values: "dotnet", "windows", "win64".
	exit 1
)
)

if not defined EWEASEL set EWEASEL=%~dp0..
if not defined EWEASEL_OUTPUT set EWEASEL_OUTPUT=%EWEASEL%\tmp

set EWEASEL_COMMAND=eweasel.exe
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -max_threads %NUMBER_OF_PROCESSORS% -order
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -define EWEASEL "%EWEASEL%"
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -define INCLUDE "%EWEASEL%\control"
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -define ISE_EIFFEL %ISE_EIFFEL%
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -define ISE_PLATFORM %ISE_PLATFORM%
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -define %EWEASEL_PLATFORM% 1
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -define PLATFORM_TYPE %EWEASEL_PLATFORM%
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -init "%EWEASEL%\control\init"
set EWEASEL_COMMAND=%EWEASEL_COMMAND% -output "%EWEASEL_OUTPUT%"
