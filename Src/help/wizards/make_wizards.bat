@echo off

if not defined INSTALL_LOG set INSTALL_LOG=CON

if not defined TEMP (echo Variable TEMP is not set && exit 0)
if not defined DELIVERY (echo Variable DELIVERY is not set && exit 0)

echo *****************************************************************
echo *                 Compiling WEL Wizard                          *
echo *****************************************************************
call make_a_wizard.bat new_projects wel wel_wizard >> %INSTALL_LOG% 2>>&1

echo *****************************************************************
echo *               Compiling Vision2 Wizard                        *
echo *****************************************************************
call make_a_wizard.bat new_projects vision2 vision2_wizard >> %INSTALL_LOG% 2>>&1

echo *****************************************************************
echo *                Compiling Wizard Wizard                        *
echo *****************************************************************
REM call make_a_wizard.bat new_projects wizard wizard_wizard >> %INSTALL_LOG% 2>>&1

echo *****************************************************************
echo *              Compiling Precompilation Wizard                  *
echo *****************************************************************
call make_a_wizard.bat others precompile precompile_wizard >> %INSTALL_LOG% 2>>&1

echo *****************************************************************
echo *                    Compiling .NET Wizard                      *
echo *****************************************************************
call make_a_wizard.bat new_projects dotnet dotnet_wizard >> %INSTALL_LOG% 2>>&1

echo *****************************************************************
echo *                 Compiling EWF Wizard                          *
echo *****************************************************************
call make_a_wizard.bat new_projects ewf ewf_wizard >> %INSTALL_LOG% 2>>&1

echo *****************************************************************
echo *                 Compiling Library Wizard                      *
echo *****************************************************************
call make_a_wizard.bat new_projects library library_wizard >> %INSTALL_LOG% 2>>&1

echo *****************************************************************
echo *                 Compiling WrapC Wizard                          *
echo *****************************************************************
call make_a_wizard.bat new_projects wrapc wrapc_wizard >> %INSTALL_LOG% 2>>&1
