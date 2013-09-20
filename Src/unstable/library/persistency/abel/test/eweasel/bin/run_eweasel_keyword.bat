@echo off
call %~dp0set_eweasel_env.bat

if "%~1" == "" (
	echo Error: Missing argument: keyword.
	echo Usage:
	echo 	%~nx0 keyword
	exit 1
)

if not exist %EWEASEL_OUTPUT%\nul mkdir %EWEASEL_OUTPUT%

%EWEASEL_COMMAND% -keep all -filter "kw %1" -catalog %EWEASEL%\control\catalog
