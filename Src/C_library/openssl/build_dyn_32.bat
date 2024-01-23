@echo on
title Script to compile OpenSSL on Windows 32 bits dynamically

set current_dir=%~dp0

rem Remove the builds directory if it exists
if exist %current_dir%builds rmdir /s /q %current_dir%builds

rem Create the builds directory
mkdir %current_dir%builds
cd builds
mkdir dynamic_32

cd ..

@echo Building a 32-Bit dynamic library (/MD) using the option `shared` with VC-WIN32
@echo Compiling OpenSSL 32bits dynamic

perl Configure VC-WIN32 shared --prefix=%current_dir%builds\dynamic_32 --openssldir=%current_dir%builds\dynamic_32
nmake 
nmake install_sw




