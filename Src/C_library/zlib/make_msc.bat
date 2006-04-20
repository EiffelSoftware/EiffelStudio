nmake /f win32\Makefile.msc
if not exist ..\..\library\vision2\spec\msc mkdir ..\..\library\vision2\spec\msc
if not exist ..\..\library\vision2\spec\msc\lib mkdir ..\..\library\vision2\spec\msc\lib
copy zlib.lib ..\..\library\vision2\spec\msc\lib\
del *.obj
del *.lib
