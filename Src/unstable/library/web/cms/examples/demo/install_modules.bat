@echo off
setlocal
set ROC_CMD=call %~dp0..\..\tools\roc.bat
set ROC_CMS_DIR=%~dp0

%ROC_CMD% install --config roc.cfg
