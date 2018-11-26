OpenSSL configuration file
==========================

For windows users we have differents versions of  `C_libary/openssl/include/opensslconf.h`, by default the the file 
contains the dynamic version for Windows 32 and 64, defined in the following file `C_libary/openssl/include/opensslconf_dll.h`
If you need to use the static version copy the contents of `C_libary/openssl/include/opensslconf_static.h`
to the `opensslconf.h`.




