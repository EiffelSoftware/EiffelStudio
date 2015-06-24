@echo off
setlocal
set TMP_EXCLUDE=%~dp0.install_ROC-copydir-exclude
set COPYCMD= xcopy /EXCLUDE:%TMP_EXCLUDE% /I /E /Y 
set TMP_DIR=%~dp0..
set SAFE_RMDIR=rd /q/s

echo EIFGENs > %TMP_EXCLUDE%
echo .git >> %TMP_EXCLUDE%
echo .svn >> %TMP_EXCLUDE%

set TMP_TARGET_DIR=%1
if -%TMP_TARGET_DIR%- == -- goto ask_target_dir
goto start

:ask_target_dir
echo Please provide a installation directory (target library)
if -%ISE_LIBRARY%- == -- set ISE_LIBRARY=%EIFFEL_LIBRARY%
if -%ISE_LIBRARY%- == -- set ISE_LIBRARY=%ISE_EIFFEL%
if -%EIFFEL_LIBRARY%- == -- set EIFFEL_LIBRARY=%ISE_LIBRARY%
echo 1: using $EIFFEL_LIBRARY=%EIFFEL_LIBRARY%
echo 2: using $ISE_LIBRARY=%ISE_LIBRARY%
echo 3: using current directory=%CD%\ewf
CHOICE /C 123q /M " > selection:"
if .%ERRORLEVEL%. == .1. goto use_eiffel_library
if .%ERRORLEVEL%. == .2. goto use_ise_library
if .%ERRORLEVEL%. == .3. goto use_current_dir
echo No target directory were specified, you can pass it using the command line
echo Usage: install_ewf {target_directory}
echo Bye ...
goto end

:use_eiffel_library
if -%EIFFEL_LIBRARY%- == -- goto use_ise_library
set TMP_TARGET_DIR=%EIFFEL_LIBRARY%
goto start

:use_ise_library
if -%ISE_LIBRARY%- == -- goto use_current_dir
set TMP_TARGET_DIR=%ISE_LIBRARY%
goto start

:use_current_dir
set TMP_TARGET_DIR=%CD%\ewf
goto start

:start
set TMP_CONTRIB_DIR=%TMP_TARGET_DIR%\contrib
set TMP_UNSTABLE_DIR=%TMP_TARGET_DIR%\unstable

echo Install ROC as CMS ewf
%SAFE_RMDIR% %TMP_UNSTABLE_DIR%\library\cms\library
%SAFE_RMDIR% %TMP_UNSTABLE_DIR%\library\cms\src
%SAFE_RMDIR% %TMP_UNSTABLE_DIR%\library\cms\doc
%SAFE_RMDIR% %TMP_UNSTABLE_DIR%\library\cms\modules
%SAFE_RMDIR% %TMP_UNSTABLE_DIR%\library\cms\examples

%COPYCMD% %TMP_DIR%\library	%TMP_UNSTABLE_DIR%\library\web\cms\library
%COPYCMD% %TMP_DIR%\src	%TMP_UNSTABLE_DIR%\library\web\cms\src
%COPYCMD% %TMP_DIR%\doc	%TMP_UNSTABLE_DIR%\library\web\cms\doc
%COPYCMD% %TMP_DIR%\modules	%TMP_UNSTABLE_DIR%\library\web\cms\modules
%COPYCMD% %TMP_DIR%\examples	%TMP_UNSTABLE_DIR%\library\web\cms\examples

copy %TMP_DIR%\cms.ecf %TMP_UNSTABLE_DIR%\library\web\cms\cms.ecf
copy %TMP_DIR%\cms-safe.ecf %TMP_UNSTABLE_DIR%\library\web\cms\cms-safe.ecf
copy %TMP_DIR%\README.md %TMP_UNSTABLE_DIR%\library\web\cms\README.md
copy %TMP_DIR%\package.iron %TMP_UNSTABLE_DIR%\library\web\cms\package.iron

:end
del %TMP_EXCLUDE%

