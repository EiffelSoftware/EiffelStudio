@echo off
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
	%EWEASEL_COMMAND% -keep failed -catalog %1
)
