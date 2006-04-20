MTL=MkTypLib.exe
CPP= $cc
RSC= $rc

ALL : ise_desc.dll 

MTL_PROJ=-nologo -win32 
CPP_PROJ=-nologo -ML -W3 -GX -O2 -I.. -DWIN32 -D_WINDOWS -D-P -c 

LINK32=link.exe
LINK32_FLAGS= kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib	\
	advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib -NOLOGO	\
	-SUBSYSTEM:windows -DLL -INCREMENTAL:no -OUT:ise_desc.dll -IMPLIB:ise_desc.lib 
DEF_FILE=
LINK32_OBJS= ise_desc.$obj

ise_desc.dll : $(DEF_FILE) $(LINK32_OBJS)
	$(LINK32) $(LINK32_FLAGS) $(LINK32_OBJS)

.c.$obj:
	$(CPP) $(CPP_PROJ) $<  

# Begin Source File

SOURCE=.\ise_desc.c
DEP_DESC_=.\ise_desc.h

ise_desc.$obj :  $(SOURCE)  $(DEP_DESC_)
	$(CPP) $(CPP_PROJ) ise_desc.c

