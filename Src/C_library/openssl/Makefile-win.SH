TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir

all::
	echo Compiling static openssl for $(ISE_PLATFORM)
	if $(ISE_PLATFORM) EQU win64 build_dyn_64.bat
	if $(ISE_PLATFORM) EQU win64 $(MV) builds$(DIR)dynamic_64$(DIR)bin$(DIR)*.dll $(EIFFEL_SRC)$(DIR)Delivery$(DIR)studio$(DIR)spec$(DIR)$(ISE_PLATFORM)$(DIR)bin  
	if $(ISE_PLATFORM) EQU windows build_dyn_32.bat
	if $(ISE_PLATFORM) EQU windows $(MV) builds$(DIR)dynamic_32$(DIR)bin$(DIR)*.dll $(EIFFEL_SRC)$(DIR)Delivery$(DIR)studio$(DIR)spec$(DIR)$(ISE_PLATFORM)$(DIR)bin  

