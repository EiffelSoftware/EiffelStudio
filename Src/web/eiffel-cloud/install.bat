@echo off
setlocal
set ROC_CMD=call %ISE_LIBRARY%\unstable\library\web\cms\tools\roc.bat
set ROC_CMS_DIR=%~dp0

%ROC_CMD% install --config roc.cfg
