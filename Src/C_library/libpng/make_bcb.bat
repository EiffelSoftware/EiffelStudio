%ISE_EIFFEL%\BCC55\bin\make -f scripts/makefile.bcb
if not exist ..\..\library\vision2\spec\bcb mkdir ..\..\library\vision2\spec\bcb
if not exist ..\..\library\vision2\spec\bcb\lib mkdir ..\..\library\vision2\spec\bcb\lib
copy libpng.lib ..\..\library\vision2\spec\bcb\lib\
del *.obj
del *.lib
