MTL=MkTypLib.exe
CPP= $cc
RSC= $rc

OUTDIR=.\$platform
INTDIR=.\$platform

ALL : $(OUTDIR)-ise_desc.dll 

$(OUTDIR) : 
    if not exist $(OUTDIR)\nul mkdir $(OUTDIR)

MTL_PROJ=-nologo -D "NDEBUG" -win32 
CPP_PROJ=-nologo -ML -W3 -GX -YX -O2 -I "..\..\.."\
 -D "NDEBUG" -D "WIN32" -D "_WINDOWS" -D "-P" \
 -Fo$(INTDIR)- -c 
CPP_OBJS=.\w32msc-

LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib	\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib -NOLOGO	\
 -SUBSYSTEM:windows -DLL -INCREMENTAL:no -PDB:$(OUTDIR)\"ise_desc.pdb" -MACHINE:I386	\
 -OUT:$(OUTDIR)\"ise_desc.dll" -IMPLIB:$(OUTDIR)\"ise_desc.lib" 
DEF_FILE=
LINK32_OBJS= $(INTDIR)\ise_desc.obj

$(OUTDIR)\ise_desc.dll : $(OUTDIR)  $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

.c{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

# Begin Source File

SOURCE=.\ise_desc.c
DEP_DESC_=.\ise_desc.h

$(INTDIR)\ise_desc.obj :  $(SOURCE)  $(DEP_DESC_) $(INTDIR)


