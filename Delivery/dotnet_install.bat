@echo on
rem ISE .NET support is being installed on your computer.
rem 
rem Please wait a few seconds for the installation of the components.

@echo off

cd studio\spec\windows\bin

rem Registering ISE runtime for .NET

call gacutil -silent -nologo -if ise_runtime.dll
call ngen -silent -nologo ise_runtime.dll

cd ..\..\..\..

@echo on
rem Installation of .NET components terminated.
rem

@echo off
