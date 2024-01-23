@echo on
title Script to compile OpenSSL on Windows 32 bits statically

set current_dir=%~dp0

rem Remove the builds directory if it exists
if exist %current_dir%builds rmdir /s /q %current_dir%builds

rem Create the builds directory
mkdir %current_dir%builds
cd builds
mkdir static_32

cd ..

@echo Building a 32-Bit static library (/MT) using the option `no-shared` with VC-WIN32
@echo Compiling OpenSSL 32bits statically

perl Configure VC-WIN32 no-shared --prefix=%current_dir%builds\static_32 --openssldir=%current_dir%builds\static_32
nmake 
nmake install_sw




