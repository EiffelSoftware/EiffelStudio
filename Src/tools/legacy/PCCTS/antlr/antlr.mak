# Microsoft Visual C++ Generated NMAKE File, Format Version 2.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

!IF "$(CFG)" == ""
CFG=Win32 Debug
!MESSAGE No configuration specified.  Defaulting to Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "Win32 Release" && "$(CFG)" != "Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "ANTLR.MAK" CFG="Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

################################################################################
# Begin Project
# PROP Target_Last_Scanned "Win32 Release"
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "WinRel"
# PROP BASE Intermediate_Dir "WinRel"
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "WinRel"
# PROP Intermediate_Dir "WinRel"
OUTDIR=.\WinRel
INTDIR=.\WinRel

ALL : $(OUTDIR)\ANTLR.exe $(OUTDIR)\ANTLR.bsc

$(OUTDIR) : 
    if not exist $(OUTDIR) mkdir $(OUTDIR)

# ADD BASE CPP /nologo /W3 /GX /YX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /FR /c
# ADD CPP /nologo /W2 /YX /O2 /I "..\h" /I "..\support\set" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "USER_ZZSYN" /D "PC" /c
# SUBTRACT CPP /Fr
CPP_PROJ=/nologo /W2 /YX /O2 /I "..\h" /I "..\support\set" /D "WIN32" /D\
 "NDEBUG" /D "_CONSOLE" /D "USER_ZZSYN" /D "PC" /Fp$(OUTDIR)/"ANTLR.pch"\
 /Fo$(INTDIR)/ /c 
CPP_OBJS=.\WinRel/
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
BSC32_SBRS= \
	
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o$(OUTDIR)/"ANTLR.bsc" 

$(OUTDIR)/ANTLR.bsc : $(OUTDIR)  $(BSC32_SBRS)
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /NOLOGO /SUBSYSTEM:console
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /NOLOGO /SUBSYSTEM:console
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib \
 /NOLOGO /SUBSYSTEM:console /INCREMENTAL:no\
 /PDB:$(OUTDIR)/"ANTLR.pdb" /OUT:$(OUTDIR)/"ANTLR.exe" 
DEF_FILE=
LINK32_OBJS= \
	$(INTDIR)/HASH.OBJ \
	$(INTDIR)/MISC.OBJ \
	$(INTDIR)/BUILD.OBJ \
	$(INTDIR)/ANTLR.OBJ \
	$(INTDIR)/GLOBALS.OBJ \
	$(INTDIR)/PRED.OBJ \
	$(INTDIR)/FSET.OBJ \
	$(INTDIR)/FSET2.OBJ \
	$(INTDIR)/GEN.OBJ \
	$(INTDIR)/MAIN.OBJ \
	$(INTDIR)/SCAN.OBJ \
	$(INTDIR)/LEX.OBJ \
	$(INTDIR)/ERR.OBJ \
	$(INTDIR)/BITS.OBJ \
	$(INTDIR)/SET.OBJ

$(OUTDIR)/ANTLR.exe : $(OUTDIR)  $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "WinDebug"
# PROP BASE Intermediate_Dir "WinDebug"
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "WinDebug"
# PROP Intermediate_Dir "WinDebug"
OUTDIR=.\WinDebug
INTDIR=.\WinDebug

ALL : $(OUTDIR)/ANTLR.exe $(OUTDIR)/ANTLR.bsc

$(OUTDIR) : 
    if not exist $(OUTDIR) mkdir $(OUTDIR)

# ADD BASE CPP /nologo /W3 /GX /Zi /YX /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /FR /c
# ADD CPP /nologo /MD /W2 /Zi /YX /Od /I "..\h" /I "..\support\set" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "USER_ZZSYN" /D "PC" /c
# SUBTRACT CPP /Gf /Fr
CPP_PROJ=/nologo /MD /W2 /Zi /YX /Od /I "..\h" /I "..\support\set" /D "WIN32"\
 /D "_DEBUG" /D "_CONSOLE" /D "USER_ZZSYN" /D "PC" /Fp$(OUTDIR)/"ANTLR.pch"\
 /Fo$(INTDIR)/ /Fd$(OUTDIR)/"ANTLR.pdb" /c 
CPP_OBJS=.\WinDebug/
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
BSC32_SBRS= \
	
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o$(OUTDIR)/"ANTLR.bsc" 

$(OUTDIR)/ANTLR.bsc : $(OUTDIR)  $(BSC32_SBRS)
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /NOLOGO /SUBSYSTEM:console /DEBUG
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /NOLOGO /SUBSYSTEM:console /PDB:none /DEBUG
# SUBTRACT LINK32 /MAP
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib \
 /NOLOGO /SUBSYSTEM:console /PDB:none /DEBUG \
 /OUT:$(OUTDIR)/"ANTLR.exe" 
DEF_FILE=
LINK32_OBJS= \
	$(INTDIR)/HASH.OBJ \
	$(INTDIR)/MISC.OBJ \
	$(INTDIR)/BUILD.OBJ \
	$(INTDIR)/ANTLR.OBJ \
	$(INTDIR)/GLOBALS.OBJ \
	$(INTDIR)/PRED.OBJ \
	$(INTDIR)/FSET.OBJ \
	$(INTDIR)/FSET2.OBJ \
	$(INTDIR)/GEN.OBJ \
	$(INTDIR)/MAIN.OBJ \
	$(INTDIR)/SCAN.OBJ \
	$(INTDIR)/LEX.OBJ \
	$(INTDIR)/ERR.OBJ \
	$(INTDIR)/BITS.OBJ \
	$(INTDIR)/SET.OBJ

$(OUTDIR)/ANTLR.exe : $(OUTDIR)  $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.c{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

################################################################################
# Begin Group "Source Files"

################################################################################
# Begin Source File

SOURCE=.\HASH.C
DEP_HASH_=\
	.\HASH.H

$(INTDIR)/HASH.OBJ :  $(SOURCE)  $(DEP_HASH_) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\MISC.C
DEP_MISC_=\
        ..\SUPPORT\SET\SET.H\
	.\SYN.H\
	.\HASH.H\
	.\GENERIC.H\
        ..\H\DLGDEF.H\
        ..\H\CONFIG.H\
	.\PROTO.H

$(INTDIR)/MISC.OBJ :  $(SOURCE)  $(DEP_MISC_) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\BUILD.C
DEP_BUILD=\
        ..\SUPPORT\SET\SET.H\
	.\SYN.H\
	.\HASH.H\
	.\GENERIC.H\
        ..\H\DLGDEF.H\
        ..\H\CONFIG.H\
	.\PROTO.H

$(INTDIR)/BUILD.OBJ :  $(SOURCE)  $(DEP_BUILD) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\ANTLR.C
DEP_ANTLR=\
        ..\SUPPORT\SET\SET.H\
	.\SYN.H\
	.\HASH.H\
	.\GENERIC.H\
        ..\H\ANTLR.H\
	.\TOKENS.H\
        ..\H\DLGDEF.H\
	.\MODE.H\
        ..\H\CONFIG.H\
	.\PROTO.H

$(INTDIR)/ANTLR.OBJ :  $(SOURCE)  $(DEP_ANTLR) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\GLOBALS.C
DEP_GLOBA=\
        ..\SUPPORT\SET\SET.H\
	.\SYN.H\
	.\HASH.H\
	.\GENERIC.H\
        ..\H\CONFIG.H\
	.\PROTO.H

$(INTDIR)/GLOBALS.OBJ :  $(SOURCE)  $(DEP_GLOBA) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\PRED.C
DEP_PRED_=\
        ..\SUPPORT\SET\SET.H\
	.\SYN.H\
	.\HASH.H\
	.\GENERIC.H\
        ..\H\DLGDEF.H\
        ..\H\CONFIG.H\
	.\PROTO.H

$(INTDIR)/PRED.OBJ :  $(SOURCE)  $(DEP_PRED_) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\FSET.C
DEP_FSET_=\
        ..\SUPPORT\SET\SET.H\
	.\SYN.H\
	.\HASH.H\
	.\GENERIC.H\
        ..\H\DLGDEF.H\
        ..\H\CONFIG.H\
	.\PROTO.H

$(INTDIR)/FSET.OBJ :  $(SOURCE)  $(DEP_FSET_) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\FSET2.C
DEP_FSET2=\
        ..\SUPPORT\SET\SET.H\
	.\SYN.H\
	.\HASH.H\
	.\GENERIC.H\
        ..\H\DLGDEF.H\
        ..\H\CONFIG.H\
	.\PROTO.H

$(INTDIR)/FSET2.OBJ :  $(SOURCE)  $(DEP_FSET2) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\GEN.C
DEP_GEN_C=\
        ..\SUPPORT\SET\SET.H\
	.\SYN.H\
	.\HASH.H\
	.\GENERIC.H\
        ..\H\DLGDEF.H\
        ..\H\CONFIG.H\
	.\PROTO.H

$(INTDIR)/GEN.OBJ :  $(SOURCE)  $(DEP_GEN_C) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\MAIN.C
DEP_MAIN_=\
	.\STDPCCTS.H\
        ..\SUPPORT\SET\SET.H\
	.\SYN.H\
	.\HASH.H\
	.\GENERIC.H\
        ..\H\ANTLR.H\
	.\TOKENS.H\
        ..\H\DLGDEF.H\
	.\MODE.H\
        ..\H\CONFIG.H\
	.\PROTO.H

$(INTDIR)/MAIN.OBJ :  $(SOURCE)  $(DEP_MAIN_) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\SCAN.C
DEP_SCAN_=\
        ..\SUPPORT\SET\SET.H\
	.\SYN.H\
	.\HASH.H\
	.\GENERIC.H\
        ..\H\ANTLR.H\
	.\TOKENS.H\
        ..\H\DLGDEF.H\
	.\MODE.H\
        ..\H\DLGAUTO.H\
        ..\H\CONFIG.H\
	.\PROTO.H

$(INTDIR)/SCAN.OBJ :  $(SOURCE)  $(DEP_SCAN_) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\LEX.C
DEP_LEX_C=\
        ..\SUPPORT\SET\SET.H\
	.\SYN.H\
	.\HASH.H\
	.\GENERIC.H\
        ..\H\CONFIG.H\
	.\PROTO.H

$(INTDIR)/LEX.OBJ :  $(SOURCE)  $(DEP_LEX_C) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\ERR.C
DEP_ERR_C=\
        ..\SUPPORT\SET\SET.H\
	.\SYN.H\
	.\HASH.H\
	.\GENERIC.H\
        ..\H\ANTLR.H\
	.\TOKENS.H\
        ..\H\DLGDEF.H\
        ..\H\ERR.H\
        ..\H\CONFIG.H\
	.\PROTO.H

$(INTDIR)/ERR.OBJ :  $(SOURCE)  $(DEP_ERR_C) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\BITS.C
DEP_BITS_=\
        ..\SUPPORT\SET\SET.H\
	.\SYN.H\
	.\HASH.H\
	.\GENERIC.H\
        ..\H\DLGDEF.H\
        ..\H\CONFIG.H\
	.\PROTO.H

$(INTDIR)/BITS.OBJ :  $(SOURCE)  $(DEP_BITS_) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=..\SUPPORT\SET\SET.C
DEP_SET_C=\
        ..\SUPPORT\SET\SET.H\
        ..\H\CONFIG.H

$(INTDIR)/SET.OBJ :  $(SOURCE)  $(DEP_SET_C) $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
# End Group
# End Project
################################################################################
