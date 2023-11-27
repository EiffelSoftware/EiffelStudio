@echo off
setlocal
call %~dp0set_eweasel_env.bat

rem Launch EiffelWeasel tests
rd /q /s %EWEASEL_OUTPUT%
mkdir %EWEASEL_OUTPUT%

if "%~1" == "" (
	echo Error: Missing argument: catalog-name.
	echo Usage:
	echo 	%~nx0 catalog-name
	exit 1
) else (
	title EWEASEL catalag %1
	%EWEASEL_COMMAND% -order -keep failed -catalog %1
	title
)

endlocal
