@echo off
setlocal
set ROC_CMS_SRC=%ISE_LIBRARY%\unstable\library\web\cms
set ROC_CMD=call %ROC_CMS_SRC%\tools\roc.bat
set ROC_CMS_DIR=%~dp0

%ROC_CMD% install --config roc.cfg --dir %ROC_CMS_DIR%

echo done
