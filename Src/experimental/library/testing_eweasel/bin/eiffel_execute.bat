@echo off

if NOT .%MONO%. == .. (
	rem We need to set MONO_PATH and PATH for executing under Mono
	set MONO_PATH=%1\Assemblies
	set PATH=%1\Assemblies
)

cd /d %1
shift

rem Ideally we would like to use %* after the shift but it does
rem not work at least on Windows 2k. So we get all arguments one
rem by one and insert them into ARGS.

set ARGS=
:loop
if "%1" == "" goto exit
set ARGS=%ARGS% %1
shift
goto loop
:exit

if .%MONO%. == .. (
	call %ARGS% && echo Execution completed|| echo Execution failed
) else (
	call "%MONO%\bin\mono.exe" %ARGS% && echo Execution completed|| echo Execution failed
)
