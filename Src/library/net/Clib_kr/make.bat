set include=c:\bc45\include
set library=c:\bc45\lib
C:\bc45\bin\make -f makefile.b
set include=d:\msvc20\include
set library=d:\msvc20\lib
nmake -f makefile.m
set include=C:\watcom\h;c:\watcom\h\nt
set library=c:\watcom\lib
wmake -f makefile.w
