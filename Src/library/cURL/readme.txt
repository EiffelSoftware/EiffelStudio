When your Eiffel executable running, Eiffel cURL library need a DLL

libcurl.dll

Please make sure the DLL file can be found in your environment PATH or in same folder of your executable.

How to compile cURL on Windows?
===============================
Go to %ISE_EIFFEL%/C_library/curl/winbuid

cURL dynamic for 32 or 64 bits
nmake RTLIBCFG=static /f Makefile.vc mode=dll GEN_PDB=no DEBUG=no MACHINE=[x86|x64]

cURL static for 32 or 64
nmake RTLIBCFG=static /f Makefile.vc mode=static GEN_PDB=no DEBUG=no MACHINE=[x86|x64]

The binaries will be located 
%ISE_EIFFEL%/C_library/curl/build

Check cURL documentation if you need to build cURL with specific options.

cURL command line tool
=======================

The --libcurl command-line option will create a C program in the provided file name. 

Example: curl http://example.com --libcurl example.c
Will create a file example.c code of this command line

To learn more about the cURL check https://ec.haxx.se/libcurl--libcurl.html