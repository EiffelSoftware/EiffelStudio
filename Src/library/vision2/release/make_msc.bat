@echo off
echo -- Compiling libraries necessary for EiffelVision2...
echo.
cd vision2\test
move test_pixmap test_pixmap.unix
copy test_pixmap.win test_pixmap
move Ace.ace Ace.unix.ace
copy Ace.win.ace Ace.ace
cd ..\..\libpng
call make_msc.bat
cd ..\zlib
call make_msc.bat
cd ..\vision2\Clib
call make_msc.bat
cd ..\..
echo.
echo -- Please read vision2\RELEASE_NOTES and vision2\test\README.
