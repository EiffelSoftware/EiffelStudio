@echo on
rem ISE .NET support is being installed on your computer.
rem 
rem Please wait a few seconds for the installation of the components.

@echo off

rem Registering ISE runtime for .NET
call gacutil -silent -nologo -u ise_runtime
call gacutil -silent -nologo -i ise_runtime.dll

rem Registering ISE generator for .NET
call gacutil -silent -nologo -u core
call gacutil -silent -nologo -i core.dll
call regasm -silent -nologo core.dll

call dotnet_install_ami.bat

rem Registering Eiffel Assembly Cache
cd dotnet\assembly_manager
call regasm -silent -nologo ISE.Reflection.EiffelComponents.dll
call regasm -silent -nologo ISE.Reflection.CodeGenerator.dll
cd ..\..

@echo on
rem Installation of .NET components terminated.
rem

@echo off
