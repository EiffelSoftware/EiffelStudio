@echo off
echo -- Compiling libraries necessary for EiffelVision2...
echo.
cd wel\Clib
call make_msc.bat
cd ..\..\libpng
call make_msc.bat
cd ..\zlib
call make_msc.bat
cd ..\vision2\Clib
call make_msc.bat
cd ..\..
echo.
echo -- Please read vision2\RELEASE_NOTES and vision2\test\README.
