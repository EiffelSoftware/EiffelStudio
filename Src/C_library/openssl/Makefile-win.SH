all:: 
  if $(ISE_PLATFORM) EQU win64 (
    echo Compiling openssl for Windows 64bits
    perl Configure VC-WIN64A
  ) ELSE (
    echo Compiling openssl for Windows 32bits
    perl Configure VC-WIN32
  )

  rem Remove the build directory if it exists
  if exist build rmdir /s /q build

  rem Create the build directory
  mkdir build

  nmake OUTDIR=%cd%\build
  echo Compiling successed. 

  cp .\libeay32.dll $(EIFFEL_SRC)\Delivery\studio\spec\$(ISE_PLATFORM)\bin  
  cp .\ssleay32.dll $(EIFFEL_SRC)\Delivery\studio\spec\$(ISE_PLATFORM)\bin  
