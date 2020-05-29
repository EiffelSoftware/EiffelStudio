@echo off
setlocal
set TCCLECMD="C:\Program Files\JPSoft\TCCLE14x64\tcc.exe"

if "%1" EQU "auto" goto auto
goto menu

:auto
IF "%~2" == "win64" set ISE_PLATFORM=win64
IF "%~2" == "windows" set ISE_PLATFORM=windows
call %~dp0clean_delivery.bat
goto make_delivery

call %~dp0shutdown_machine.bat 600
goto end

:menu
echo EiffelStudio delivery:

@echo 1: make_delivery
@echo 2: make_delivery_quick -no_install
@echo 3: make_exes
@echo 4: make_installations
@echo 5: make_installations no_install
@echo 6: starting environment
@echo 7: bootstrap environment
@echo 8: display logs
@echo 9: Standard only
@echo -------------------
@echo i: display info
@echo x: extra menu
@echo w: wipe out/clean previous delivery
@echo -------------------
@echo q: quit

CHOICE /C 123456789ixwq /M " > selection:"
if .%ERRORLEVEL%. == .1. GOTO make_delivery
if .%ERRORLEVEL%. == .2. GOTO make_delivery_quick
if .%ERRORLEVEL%. == .3. GOTO make_exes
if .%ERRORLEVEL%. == .4. GOTO make_installations
if .%ERRORLEVEL%. == .5. GOTO make_installations_no_install
if .%ERRORLEVEL%. == .6. GOTO starting_env
if .%ERRORLEVEL%. == .7. GOTO bootstrap_env
if .%ERRORLEVEL%. == .8. GOTO display_logs
if .%ERRORLEVEL%. == .9. GOTO menu_std
if .%ERRORLEVEL%. == .10. GOTO display_info
if .%ERRORLEVEL%. == .11. GOTO menu_extra
if .%ERRORLEVEL%. == .12. GOTO clean_delivery
if .%ERRORLEVEL%. == .13. goto end
goto end

:menu_std
set NO_ENTERPRISE_BUILD="True"
echo EiffelStudio Standard delivery:
@echo 1: make_delivery
@echo 2: make_exes
@echo 3: make_installation
@echo -------------------
@echo q: quit
CHOICE /C 123q /M " > selection:"
if .%ERRORLEVEL%. == .1. GOTO make_delivery
if .%ERRORLEVEL%. == .2. GOTO make_exes
if .%ERRORLEVEL%. == .3. GOTO make_installations
if .%ERRORLEVEL%. == .4. goto end
goto end

:menu_extra
echo Extra menu
@echo 1: make_dotnet
@echo 2: make_wizards
@echo 3: check svn repositories
@echo -------------------
@echo q: quit
CHOICE /C 123q /M " > selection:"
if .%ERRORLEVEL%. == .1. GOTO call_make_dotnet
if .%ERRORLEVEL%. == .2. GOTO call_make_wizards
if .%ERRORLEVEL%. == .3. GOTO call_check_svn_repositories
if .%ERRORLEVEL%. == .4. goto end
goto end

:clean_delivery
call %~dp0clean_delivery.bat
goto end

:make_delivery
%TCCLECMD% /C make_delivery.btm
goto end

:make_delivery_quick
%TCCLECMD% /C make_delivery.btm no_install
goto end

:call_check_svn_repositories
%TCCLECMD% /C check_svn_repositories.btm
goto end

:make_std_delivery
echo Build only Standard delivery
set NO_ENTERPRISE_BUILD="True"
%TCCLECMD% /C make_delivery.btm
goto end

:make_std_installation
echo Build only Standard installation delivery
set NO_ENTERPRISE_BUILD="True"
%TCCLECMD% /C make_installations.btm
goto end

:make_exes
set NO_ENTERPRISE_BUILD=
%TCCLECMD% /C make_exes.btm
goto end

:call_make_dotnet
%TCCLECMD% /C call_make_dotnet.btm
goto end

:call_make_wizards
%TCCLECMD% /C call_make_wizards.btm
goto end

:make_installations
set NO_ENTERPRISE_BUILD=
%TCCLECMD% /C make_installations.btm
goto end

:make_installations_no_install
set NO_ENTERPRISE_BUILD=
%TCCLECMD% /C make_installations.btm no_install
goto end

:starting_env
%TCCLECMD% init.btm
goto end

:bootstrap_env
%TCCLECMD% init.btm
goto end

:display_logs
%TCCLECMD% display_logs.btm
echo %INSTALL_LOG%
goto end

:display_info
echo Display Info
%TCCLECMD% display_information.btm
goto end

:end
