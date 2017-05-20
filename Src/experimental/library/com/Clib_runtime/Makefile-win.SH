TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I..$(DIR)spec$(DIR)windows$(DIR)include -I. -I..$(DIR)spec$(DIR)windows$(DIR)include  -D_WIN32_DCOM
JCFLAGS = $(CFLAGS) $optimize $ccflags 
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags 
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
LINK = $link32
DLL_FLAGS = $dll_flags
DLL_LIBS = $dll_libs
OBJECTS = ecom_runtime_c_e.$obj ecom_runtime_ce_arrays.$obj ecom_runtime_e_c.$obj ecom_runtime.$obj
MT_OBJECTS = MTecom_runtime_c_e.$obj MTecom_runtime_ce_arrays.$obj MTecom_runtime_e_c.$obj MTecom_runtime.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

.cpp.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: $output_libraries
	$(MAKE) clean

standard:: com_runtime.lib
mtstandard:: mtcom_runtime.lib

clean:
	$(RM) *.$obj
	$(RM) *.lib

com_runtime.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

mtcom_runtime.lib: $(MT_OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

#Multithreaded targets.
MTecom_runtime_c_e.$obj: ecom_runtime_c_e.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTecom_runtime_ce_arrays.$obj: ecom_runtime_ce_arrays.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTecom_runtime_e_c.$obj: ecom_runtime_e_c.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTecom_runtime.$obj: ecom_runtime.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

