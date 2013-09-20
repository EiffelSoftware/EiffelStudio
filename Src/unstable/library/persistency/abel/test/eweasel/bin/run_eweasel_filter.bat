@echo off
call %~dp0set_eweasel_env.bat

if "%~1" == "" (
	echo Error: Missing argument: test-name.
	echo Usage:
	echo 	%~nx0 test-name
	exit 1
)

if not exist %EWEASEL_OUTPUT%\nul mkdir %EWEASEL_OUTPUT%

%EWEASEL_COMMAND% -keep all -filter "dir %1" -catalog %EWEASEL%\control\catalog
