echo off
if not exist %4 mkdir %4
cd %3
call precompile_install.bat %1 %2
