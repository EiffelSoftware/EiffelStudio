C libraries needed for various Eiffel Libraries: Eiffel Vision2, Eiffel cURL
and also the delivery of EiffelStudio.

This is only for Windows

openssl
=======
	copy libeay32.dll $(EIFFEL_SRC)\Delivery\studio\spec\$(ISE_PLATFORM)\bin  
	copy ssleay32.dll $(EIFFEL_SRC)\Delivery\studio\spec\$(ISE_PLATFORM)\bin  

curl
====
- includes:
	$(EIFFEL_SRC)\C_library\openssl\include
	$(EIFFEL_SRC)\C_library\openssl\include\openssl
- actions:
	cp libcurl_imp.lib ..\..\library\cURL\spec\$(ISE_C_COMPILER)\$(ISE_PLATFORM)\lib
	copy libcurl.dll $(EIFFEL_SRC)\Delivery\studio\spec\$(ISE_PLATFORM)\bin

libpng
======
	copy libpng\libpng.lib to ..\library\vision2\spec\$(ISE_C_COMPILER)\$(ISE_PLATFORM)\lib
	copy libpng\libpng.lib to ..\compatible\library\vision2\spec\$(ISE_C_COMPILER)\$(ISE_PLATFORM)\lib

zlib
====
	copy zlib\zlib.lib to ..\library\vision2\spec\$(ISE_C_COMPILER)\$(ISE_PLATFORM)\lib
	copy zlib\zlib.lib to ..\compatible\library\vision2\spec\$(ISE_C_COMPILER)\$(ISE_PLATFORM)\lib
	
	
