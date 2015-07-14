setlocal
set ROC_CMS_SRC=%ISE_LIBRARY%\unstable\library\web\cms
set ROC_CMD=%ROC_CMS_SRC%\tools\roc.exe
set ROC_CMS_DIR=%~dp0

%ROC_CMD% install --module %ROC_CMS_SRC%\modules\auth	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module %ROC_CMS_SRC%\modules\basic_auth	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module %ROC_CMS_SRC%\modules\node	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module %ROC_CMS_SRC%\modules\blog	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module %ROC_CMS_SRC%\modules\oauth20	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module %ROC_CMS_SRC%\modules\openid	--dir %ROC_CMS_DIR%

%ROC_CMD% install --module modules\codeboard	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module modules\contact	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module modules\eiffel_community	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module modules\eiffel_download	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module modules\wdocs	--dir %ROC_CMS_DIR%


