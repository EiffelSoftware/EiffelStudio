all:: 

  rem Remove the build directory if it exists
  if exist builds rmdir /s /q builds

  if $(ISE_PLATFORM) EQU win64 (
    echo Compiling openssl for Windows 64bits
    build_dynamic_64
  	echo Compiling successed. 
  	cp builds\dynamic_64\bin\*.dll $(EIFFEL_SRC)\Delivery\studio\spec\$(ISE_PLATFORM)\bin  
  ) else (
    echo Compiling openssl for Windows 32bits
    build_dynamic_32
  	echo Compiling successed. 
  	cp builds\dynamic_32\bin\*.dll $(EIFFEL_SRC)\Delivery\studio\spec\$(ISE_PLATFORM)\bin  
  )

