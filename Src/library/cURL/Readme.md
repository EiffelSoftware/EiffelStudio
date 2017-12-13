How to compile cURL: statically.

Got to C_LIBRARY/cURL/winbuild 

Execute the following command.

The example is for 64 bits use x86 got 32.

nmake RTLIBCFG=static /f Makefile.vc mode=static ENABLE_IPV6=no ENABLE_IDN=no GEN_PDB=no DEBUG=no MACHINE=x64