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

if "%MONO%" NEQ "" GOTO mono
if "%NETCORE%" NEQ "" GOTO netcore
goto classic

:mono
rem We need to set MONO_PATH and PATH for executing under Mono
set MONO_PATH=%1\Assemblies
set PATH=%1\Assemblies
call "%MONO%\bin\mono.exe" %ARGS% && echo Execution completed|| echo Execution failed
goto EOF

:netcore
call "%NETCORE%\dotnet.exe" %ARGS% && echo Execution completed|| echo Execution failed
goto EOF

:classic
call %ARGS% && echo Execution completed|| echo Execution failed
goto EOF

:EOF
