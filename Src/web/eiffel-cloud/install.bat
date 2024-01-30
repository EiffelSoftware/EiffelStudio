@echo off
setlocal
set ROC_CMD=call %ISE_LIBRARY%\unstable\library\web\cms\tools\roc.bat
set ROC_CMS_DIR=%~dp0

call %~dp0modules\es_cloud\build_site.bat 
call %~dp0site\themes\eiffel\build_site.bat 

%ROC_CMD% install --config roc.cfg
