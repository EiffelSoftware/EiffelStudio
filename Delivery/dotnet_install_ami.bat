@echo off

copy test.txt c:\

cd dotnet
cd assembly_manager
call install.bat
cd ..
cd ..

cd wizards
cd dotnet
gacutil -u ISE.AssemblyManager
gacutil -i ISE.AssemblyManager.exe
cd ..
cd ..

cd bench
cd wizards
cd new_projects
cd dotnet
cd spec
cd windows
call install.bat
cd ..
cd ..
cd ..
cd ..
cd ..
cd ..

