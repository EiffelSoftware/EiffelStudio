@echo on
rem ISE .NET support is being installed on your computer.
rem 
rem Please wait a few seconds for the installation of the components.

@echo off

rem Registering ISE runtime for .NET
call gacutil -silent -nologo -u ise_runtime
call gacutil -silent -nologo -i ise_runtime.dll

rem Registering ISE generator for .NET
call gacutil -silent -nologo -u EiffelCompiler
call gacutil -silent -nologo -i EiffelCompiler.dll
call regasm -silent -nologo EiffelCompiler.dll

rem Assembly Manager install
rem call dotnet_install_ami.bat

rem Registering Eiffel Assembly Cache
rem cd dotnet\assembly_manager
rem call regasm -silent -nologo ISE.Reflection.EiffelComponents.dll
rem call regasm -silent -nologo ISE.Reflection.CodeGenerator.dll
rem cd ..\..

@echo on
rem Installation of .NET components terminated.
rem

@echo off
