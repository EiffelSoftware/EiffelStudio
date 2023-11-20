setlocal
echo off

set T_NAME=basic
set T_EC_NAME=ec
set ARGS=

:args
echo process arg "%1"
if "%1" EQU "" GOTO main
if "%1" EQU "-reset" GOTO reset
if "%1" EQU "-dev" GOTO dev
if "%1" EQU "-ec" GOTO set_ec
set ARGS=%ARGS% %1
shift
goto args

goto main

:reset
echo Clean MD cache
rd /q/s %CD%\_tmp_MD

::echo Clean MD cache "%USERPROFILE%\Documents\Eiffel User Files\23.11\dotnet"
::rd /q/s "%USERPROFILE%\Documents\Eiffel User Files\23.11\dotnet"
shift
goto args

:dev
echo Use development nemdc MD consumer
set ISE_EMDC_DEBUG=true
set ISE_EMDC=%EIFFEL_SRC%\dotnet\consumer_netcore\pub\win64\nemdc.exe
shift
goto args

:set_ec
shift
set T_EC_NAME=%1
echo Use ec from %T_EC_NAME%
shift
goto args

:main
echo ISE_EMDC=%ISE_EMDC%
echo ARGS=%ARGS%
echo T_EC_NAME=%T_EC_NAME%
%T_EC_NAME% -metadata_cache_path %CD%\_tmp_MD -config test_%T_NAME%.ecf -project_path _COMP %ARGS%

goto EOF

:EOF
endlocal
