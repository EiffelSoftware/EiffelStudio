@echo off

cd dotnet\assembly_manager
call install.bat
cd ..\..

cd wizards\dotnet
call gacutil -silent -nologo -u ISE.AssemblyManager
call gacutil -silent -nologo -i ISE.AssemblyManager.exe
cd ..\..

cd bench\wizards\new_projects\dotnet\spec\windows
call install.bat
cd ..\..\..\..\..\..

