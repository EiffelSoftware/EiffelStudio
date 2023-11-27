@echo off
setlocal
call %~dp0set_eweasel_env.bat

if "%~1" == "" (
	echo Error: Missing argument: test-name.
	echo Usage:
	echo 	%~nx0 test-name
	exit 1
)

if not exist %EWEASEL_OUTPUT% mkdir %EWEASEL_OUTPUT%

title EWEASEL #%1
%EWEASEL_COMMAND% -nologo -nosummary -keep all -filter "dir %1" -catalog %EWEASEL%\control\catalog
title

endlocal
