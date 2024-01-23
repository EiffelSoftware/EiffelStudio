@echo on
title Script to compile OpenSSL on Windows 64 bits statically

set current_dir=%~dp0

rem Remove the builds directory if it exists
if exist %current_dir%builds rmdir /s /q %current_dir%builds

rem Create the builds directory
mkdir %current_dir%builds
cd builds
mkdir static_64

cd ..

@echo Building a 64-Bit static library (/MT) using the option `no-shared` with VC-WIN64A
@echo Compiling OpenSSL 64bits statically

perl Configure VC-WIN64A no-shared --prefix=%current_dir%builds\static_64
nmake 
nmake install




