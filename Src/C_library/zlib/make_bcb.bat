%ISE_EIFFEL%\BCC55\bin\make /f win32\Makefile.bor
if not exist ..\..\library\vision2\spec\bcb mkdir ..\..\library\vision2\spec\bcb
if not exist ..\..\library\vision2\spec\bcb\lib mkdir ..\..\library\vision2\spec\bcb\lib
copy zlib.lib ..\..\library\vision2\spec\bcb\lib\
del *.obj
del *.lib
