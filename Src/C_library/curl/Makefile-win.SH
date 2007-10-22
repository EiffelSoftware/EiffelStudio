all:: 
	cd .\lib
	set MACHINE=x64
	set CFG=
	nmake -f Makefile.vc6
	
	set INCLUDE=$(INCLUDE);$(EIFFEL_SRC)\C_library\openssl\include\openssl;$(EIFFEL_SRC)\C_library\openssl\include
	set LIB=$(LIB);$(EIFFEL_SRC)\C_library\openssl\out32dll
	echo $(INCLUDE)
	set CFG=release-dll-ssl-dll
	nmake -f Makefile.vc6
	
	cp libcurl_imp.lib $(EIFFEL_SRC)\library\cURL\spec\$(ISE_C_COMPILER)\$(ISE_PLATFORM)\lib
	mkdir $(EIFFEL_SRC)\Delivery\studio\spec\$(ISE_PLATFORM)
	mkdir $(EIFFEL_SRC)\Delivery\studio\spec\$(ISE_PLATFORM)\bin
	cp libcurl.dll $(EIFFEL_SRC)\Delivery\studio\spec\$(ISE_PLATFORM)\bin

