nmake /f msdos\makefile.w32
copy zlib.lib %ISE_EIFFEL%\library\vision2\spec\msc\lib\
del *.obj
del *.lib
