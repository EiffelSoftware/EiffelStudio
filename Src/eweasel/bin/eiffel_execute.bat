@echo off
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

call %ARGS% && echo Execution completed|| echo Execution failed
