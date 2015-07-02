setlocal
set ROC_CMD=%~dp0..\..\tools\roc.exe
set ROC_CMS_DIR=%~dp0

%ROC_CMD% install --module ..\..\modules\auth	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\basic_auth	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\node	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\blog	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\oauth20	--dir %ROC_CMS_DIR%
