@echo on

rem Registering ISE runtime for .NET
gacutil -u ise_runtime
gacutil -i ise_runtime.dll

rem Registering ISE generator for .NET
gacutil -u core
gacutil -i core.dll
regasm -nologo core.dll

call dotnet_install_ami.bat
