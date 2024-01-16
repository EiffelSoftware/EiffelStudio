all:: 
  if $(ISE_PLATFORM) EQU win64 (
    echo Compiling openssl for Windows 64bits
    perl Configure VC-WIN64A
    ms\do_win64a
  ) ELSE (
    echo Compiling openssl for Windows 32bits
    perl Configure VC-WIN32
    ms\do_masm
  )

  nmake -f ms\ntdll.mak
  echo Compiling successed. Testing.
  cd out32dll
  ..\ms\test

  cp .\libeay32.dll $(EIFFEL_SRC)\Delivery\studio\spec\$(ISE_PLATFORM)\bin  
  cp .\ssleay32.dll $(EIFFEL_SRC)\Delivery\studio\spec\$(ISE_PLATFORM)\bin  