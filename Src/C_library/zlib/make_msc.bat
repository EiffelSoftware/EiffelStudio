nmake /f win32\Makefile.msc
copy zlib.lib ..\..\library\vision2\spec\msc\lib\
del *.obj
del *.lib
