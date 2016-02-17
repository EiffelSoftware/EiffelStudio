@echo off
setlocal

if "%ROC_TOOL_PATH%" == "" goto LOCAL_ROC_TOOL
goto start

:LOCAL_ROC_TOOL
if exist "%~dp0roc.exe" set ROC_TOOL_PATH=%~dp0

if "%ROC_TOOL_PATH%" == "" goto SEARCH_ROC_TOOL
goto START

:SEARCH_ROC_TOOL
for %%f in (roc.exe) do (
    if exist "%%~dp$PATH:f" set ROC_TOOL_PATH="%%~dp$PATH:f"
 )
if "%ROC_TOOL_PATH%" == "" goto BUILD_ROC_TOOL
echo Using roc.exe from %ROC_TOOL_PATH%
goto START

:BUILD_ROC_TOOL
set ROC_SRCDIR=%~dp0roc
set ROC_COMPDIR=%~dp0.roc-comp
mkdir %ROC_COMPDIR%
call ecb -config %ROC_SRCDIR%\roc.ecf -finalize -c_compile -project_path %ROC_COMPDIR%
copy %ROC_COMPDIR%\EIFGENs\roc\F_code\roc.exe %~dp0roc.exe
rd /q/s %ROC_COMPDIR%

set ROC_TOOL_PATH=%~dp0
goto START

:START
rem echo Calling %ROC_TOOL_PATH%roc.exe %*
call %ROC_TOOL_PATH%roc.exe %*
goto END

:END
endlocal
exit /B 0
