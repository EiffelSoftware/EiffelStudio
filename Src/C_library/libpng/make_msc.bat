nmake -f scripts/makefile.vcwin32
if not exist ..\..\library\vision2\spec\msc mkdir ..\..\library\vision2\spec\msc
if not exist ..\..\library\vision2\spec\msc\%ISE_PLATFORM% mkdir ..\..\library\vision2\spec\msc\%ISE_PLATFORM%
if not exist ..\..\library\vision2\spec\msc\%ISE_PLATFORM%\lib mkdir ..\..\library\vision2\spec\msc\%ISE_PLATFORM%\lib
copy libpng.lib ..\..\library\vision2\spec\msc\%ISE_PLATFORM%\lib\
del *.obj
del *.lib
