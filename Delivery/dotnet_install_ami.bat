@echo off

cd dotnet\assembly_manager
call install.bat
cd ..\..

cd wizards\dotnet
call gacutil -silent -nologo -u ISE.AssemblyManager
call gacutil -silent -nologo -i ISE.AssemblyManager.exe
cd ..\..

cd studio\wizards\new_projects\dotnet
call install.bat
cd ..\..\..\..

