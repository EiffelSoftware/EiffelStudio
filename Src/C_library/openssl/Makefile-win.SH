all:: 
  perl Configure VC-WIN64A
  ms\do_win64a
  nmake -f ms\ntdll.mak
  cd out32dll
  ..\ms\test
  
	cp .\libeay32.dll $(EIFFEL_SRC)\Delivery\studio\spec\$(ISE_PLATFORM)\bin  
  cp .\ssleay32.dll $(EIFFEL_SRC)\Delivery\studio\spec\$(ISE_PLATFORM)\bin  
