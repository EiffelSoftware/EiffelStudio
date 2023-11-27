@echo off
setlocal
call %~dp0set_eweasel_env.bat

if "%~1" == "" (
	echo Error: Missing argument: keyword.
	echo Usage:
	echo 	%~nx0 keyword
	exit 1
)

if not exist %EWEASEL_OUTPUT% mkdir %EWEASEL_OUTPUT%

title EWEASEL keyword %1
%EWEASEL_COMMAND% -order -keep failed -filter "kw %1" -catalog %EWEASEL%\control\catalog
title

endlocal
