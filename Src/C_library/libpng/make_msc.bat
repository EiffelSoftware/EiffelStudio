nmake -f scripts/makefile.vcwin32
if not exist ..\..\library\vision2\spec\msc mkdir ..\..\library\vision2\spec\msc
if not exist ..\..\library\vision2\spec\msc\lib mkdir ..\..\library\vision2\spec\msc\lib
copy libpng.lib ..\..\library\vision2\spec\msc\lib\
del *.obj
del *.lib
