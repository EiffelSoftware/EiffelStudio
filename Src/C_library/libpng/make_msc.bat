nmake -f scripts/makefile.vcwin32
copy libpng.lib ..\..\library\vision2\spec\msc\lib\
del *.obj
del *.lib
