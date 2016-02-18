@echo off
setlocal
set ROC_CMD=call %~dp0..\..\tools\roc.bat
set ROC_CMS_DIR=%~dp0

%ROC_CMD% install --module ..\..\modules\admin	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\auth	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\basic_auth	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\blog	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\contact	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\feed_aggregator	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\google_search	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\node	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\oauth20	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\openid	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\recent_changes	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\seo	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\session_auth	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\taxonomy	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\files	--dir %ROC_CMS_DIR%
%ROC_CMD% install --module ..\..\modules\custom_block	--dir %ROC_CMS_DIR%
