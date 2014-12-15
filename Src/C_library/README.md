C libraries needed for various Eiffel Libraries: Eiffel Vision2, Eiffel cURL
and also the delivery of EiffelStudio.

This is only for Windows

openssl
=======
	copy libeay32.dll and ssleay32.dll to delivery ..

curl
====
- includes:
	$(EIFFEL_SRC)\C_library\openssl\include
	$(EIFFEL_SRC)\C_library\openssl\include\openssl
- actions:
	cp libcurl_imp.lib $(EIFFEL_SRC)\library\cURL\spec\$(ISE_C_COMPILER)\$(ISE_PLATFORM)\lib
	copy libcurl.dll to delivery ..

libpng
======
	copy libpng.lib to $(EIFFEL_SRC)\library\vision2\spec\$(ISE_C_COMPILER)\$(ISE_PLATFORM)\lib
	copy libpng.lib to $(EIFFEL_SRC)\compatible\library\vision2\spec\$(ISE_C_COMPILER)\$(ISE_PLATFORM)\lib

zlib
====
	copy to vision2
	copy zlib.lib to $(EIFFEL_SRC)\library\vision2\spec\$(ISE_C_COMPILER)\$(ISE_PLATFORM)\lib
	copy zlib.lib to $(EIFFEL_SRC)\compatible\library\vision2\spec\$(ISE_C_COMPILER)\$(ISE_PLATFORM)\lib
	
