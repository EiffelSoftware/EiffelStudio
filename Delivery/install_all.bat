echo off
if not exist %4 mkdir %4
cd %3
if .%5. == .InstallDotNet. call dotnet_install.bat
call precompile_install.bat %1 %2
