cd zlib
nmake /f makefile.w32
cd ..
cd libpng
nmake /f makefile.vcawin32
cd ..
nmake /f makefile.msc
