TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I..$(DIR)spec$(DIR)windows$(DIR)include -I. -I..$(DIR)spec$(DIR)windows$(DIR)include  -D_WIN32_DCOM 
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize
JILCFLAGS = $(CFLAGS) $mtccflags $optimize -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MKDIR_TARGET = $mkdir_target
LINK = $link32
DLL_FLAGS = $dll_flags
DLL_LIBS = $dll_libs
OBJECTS = E_variant.$obj E_IRootStorage.$obj E_IStorage.$obj E_IStream.$obj E_wide_string.$obj \
	E_Routines.$obj ecom_exception.$obj E_arraydesc.$obj E_custdata.$obj E_bstr.$obj E_Currency.$obj \
	E_Decimal.$obj E_generic_interface.$obj E_automation_interface.$obj ecom_font_impl_proxy.$obj \
	ecom_ienumvariant_impl_proxy.$obj ecom_ifont_impl_proxy.$obj ecom_picture_impl_proxy.$obj 
MT_OBJECTS = MTE_variant.$obj MTE_IRootStorage.$obj MTE_IStorage.$obj MTE_IStream.$obj MTE_wide_string.$obj \
	MTE_Routines.$obj MTecom_exception.$obj MTE_arraydesc.$obj MTE_custdata.$obj MTE_bstr.$obj MTE_Currency.$obj \
	MTE_Decimal.$obj MTE_generic_interface.$obj MTE_automation_interface.$obj MTecom_font_impl_proxy.$obj \
	MTecom_ienumvariant_impl_proxy.$obj MTecom_ifont_impl_proxy.$obj MTecom_picture_impl_proxy.$obj 

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

.cpp.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: lib_dir $output_libraries clean

standard:: com.lib
mtstandard:: mtcom.lib

..$(DIR)spec:
	$(MKDIR_TARGET)

..$(DIR)spec$(DIR)$(ISE_C_COMPILER): ..$(DIR)spec
	$(MKDIR_TARGET)

..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM): ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)
	$(MKDIR_TARGET)

..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib: ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)
	$(MKDIR_TARGET)

lib_dir: ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib

clean:
	$(RM) *.$obj
	$(RM) *.lib
	$(RM) *.BAK

com.lib: $(OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

mtcom.lib: $(MT_OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

#Multithreaded targets.
MTE_variant.$obj: E_variant.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTE_IRootStorage.$obj: E_IRootStorage.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTE_IStorage.$obj: E_IStorage.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTE_IStream.$obj: E_IStream.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTE_wide_string.$obj: E_wide_string.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTE_Routines.$obj: E_Routines.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTecom_exception.$obj: ecom_exception.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTE_arraydesc.$obj: E_arraydesc.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTE_custdata.$obj: E_custdata.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTE_bstr.$obj: E_bstr.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTE_Currency.$obj: E_Currency.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTE_Decimal.$obj: E_Decimal.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTE_generic_interface.$obj: E_generic_interface.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTE_automation_interface.$obj: E_automation_interface.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTecom_font_impl_proxy.$obj: ecom_font_impl_proxy.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTecom_ienumvariant_impl_proxy.$obj: ecom_ienumvariant_impl_proxy.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTecom_ifont_impl_proxy.$obj: ecom_ifont_impl_proxy.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?
	
MTecom_picture_impl_proxy.$obj: ecom_picture_impl_proxy.cpp
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

