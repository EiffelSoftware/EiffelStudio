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
!MESSAGE NMAKE /f "DLG.MAK" CFG="Win32 Debug"
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
# PROP Target_Last_Scanned "Win32 Debug"
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

ALL : $(OUTDIR)/DLG.exe $(OUTDIR)/DLG.bsc

$(OUTDIR) : 
    if not exist $(OUTDIR) mkdir $(OUTDIR)

# ADD BASE CPP /nologo /W3 /GX /YX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /FR /c
# ADD CPP /nologo /W2 /YX /O2 /I "..\h" /I "..\support\set" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "USER_ZZSYN" /D "PC" /c
# SUBTRACT CPP /Fr
CPP_PROJ=/nologo /W2 /YX /O2 /I "..\h" /I "..\support\set" /D "WIN32" /D\
 "NDEBUG" /D "_CONSOLE" /D "USER_ZZSYN" /D "PC" /Fp$(OUTDIR)/"DLG.pch"\
 /Fo$(INTDIR)/ /c 
CPP_OBJS=.\WinRel/
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
BSC32_SBRS= \
	
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o$(OUTDIR)/"DLG.bsc" 

$(OUTDIR)/DLG.bsc : $(OUTDIR)  $(BSC32_SBRS)
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /NOLOGO /SUBSYSTEM:console
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /NOLOGO /SUBSYSTEM:console
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib \
 /NOLOGO /SUBSYSTEM:console /INCREMENTAL:no\
 /PDB:$(OUTDIR)/"DLG.pdb" /OUT:$(OUTDIR)/"DLG.exe" 
DEF_FILE=
LINK32_OBJS= \
	$(INTDIR)/SET.OBJ \
	$(INTDIR)/AUTOMATA.OBJ \
	$(INTDIR)/SUPPORT.OBJ \
	$(INTDIR)/DLG_P.OBJ \
	$(INTDIR)/ERR.OBJ \
	$(INTDIR)/MAIN.OBJ \
	$(INTDIR)/DLG_A.OBJ \
	$(INTDIR)/RELABEL.OBJ \
	$(INTDIR)/OUTPUT.OBJ

$(OUTDIR)/DLG.exe : $(OUTDIR)  $(DEF_FILE) $(LINK32_OBJS)
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

ALL : $(OUTDIR)/DLG.exe $(OUTDIR)/DLG.bsc

$(OUTDIR) : 
    if not exist $(OUTDIR) mkdir $(OUTDIR)

# ADD BASE CPP /nologo /W3 /GX /Zi /YX /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /FR /c
# ADD CPP /nologo /MD /W2 /Zi /YX /Od /I "..\h" /I "..\support\set" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "USER_ZZSYN" /D "PC" /c
# SUBTRACT CPP /Fr
CPP_PROJ=/nologo /MD /W2 /Zi /YX /Od /I "..\h" /I "..\support\set" /D "WIN32"\
 /D "_DEBUG" /D "_CONSOLE" /D "USER_ZZSYN" /D "PC" /Fp$(OUTDIR)/"DLG.pch"\
 /Fo$(INTDIR)/ /Fd$(OUTDIR)/"DLG.pdb" /c 
CPP_OBJS=.\WinDebug/
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
BSC32_SBRS= \
	
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o$(OUTDIR)/"DLG.bsc" 

$(OUTDIR)/DLG.bsc : $(OUTDIR)  $(BSC32_SBRS)
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib  /NOLOGO /SUBSYSTEM:console /DEBUG
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /NOLOGO /SUBSYSTEM:console /PDB:none /DEBUG
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib \
 /NOLOGO /SUBSYSTEM:console /PDB:none /DEBUG \
 /OUT:$(OUTDIR)/"DLG.exe" 
DEF_FILE=
LINK32_OBJS= \
	$(INTDIR)/SET.OBJ \
	$(INTDIR)/AUTOMATA.OBJ \
	$(INTDIR)/SUPPORT.OBJ \
	$(INTDIR)/DLG_P.OBJ \
	$(INTDIR)/ERR.OBJ \
	$(INTDIR)/MAIN.OBJ \
	$(INTDIR)/DLG_A.OBJ \
	$(INTDIR)/RELABEL.OBJ \
	$(INTDIR)/OUTPUT.OBJ

$(OUTDIR)/DLG.exe : $(OUTDIR)  $(DEF_FILE) $(LINK32_OBJS)
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

SOURCE=..\SUPPORT\SET\SET.C

$(INTDIR)/SET.OBJ :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\AUTOMATA.C
DEP_AUTOM=\
	.\DLG.H\
        ..\SUPPORT\SET\SET.H\
        ..\H\CONFIG.H

$(INTDIR)/AUTOMATA.OBJ :  $(SOURCE)  $(DEP_AUTOM) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\SUPPORT.C
DEP_SUPPO=\
	.\DLG.H\
        ..\SUPPORT\SET\SET.H\
        ..\H\CONFIG.H

$(INTDIR)/SUPPORT.OBJ :  $(SOURCE)  $(DEP_SUPPO) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\DLG_P.C
DEP_DLG_P=\
	.\DLG.H\
        ..\H\ANTLR.H\
	.\TOKENS.H\
        ..\H\DLGDEF.H\
	.\MODE.H\
        ..\SUPPORT\SET\SET.H\
        ..\H\CONFIG.H

$(INTDIR)/DLG_P.OBJ :  $(SOURCE)  $(DEP_DLG_P) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\ERR.C
DEP_ERR_C=\
	.\DLG.H\
        ..\H\ANTLR.H\
	.\TOKENS.H\
        ..\H\DLGDEF.H\
        ..\H\ERR.H\
        ..\SUPPORT\SET\SET.H\
        ..\H\CONFIG.H

$(INTDIR)/ERR.OBJ :  $(SOURCE)  $(DEP_ERR_C) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\MAIN.C
DEP_MAIN_=\
	.\STDPCCTS.H\
	.\DLG.H\
        ..\H\ANTLR.H\
	.\TOKENS.H\
        ..\H\DLGDEF.H\
	.\MODE.H\
        ..\SUPPORT\SET\SET.H\
        ..\H\CONFIG.H

$(INTDIR)/MAIN.OBJ :  $(SOURCE)  $(DEP_MAIN_) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\DLG_A.C
DEP_DLG_A=\
	.\DLG.H\
        ..\H\ANTLR.H\
	.\TOKENS.H\
        ..\H\DLGDEF.H\
	.\MODE.H\
        ..\H\DLGAUTO.H\
        ..\SUPPORT\SET\SET.H\
        ..\H\CONFIG.H

$(INTDIR)/DLG_A.OBJ :  $(SOURCE)  $(DEP_DLG_A) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\RELABEL.C
DEP_RELAB=\
	.\DLG.H\
        ..\SUPPORT\SET\SET.H\
        ..\H\CONFIG.H

$(INTDIR)/RELABEL.OBJ :  $(SOURCE)  $(DEP_RELAB) $(INTDIR)

# End Source File
################################################################################
# Begin Source File

SOURCE=.\OUTPUT.C
DEP_OUTPU=\
	.\DLG.H\
        ..\SUPPORT\SET\SET.H\
        ..\H\CONFIG.H

$(INTDIR)/OUTPUT.OBJ :  $(SOURCE)  $(DEP_OUTPU) $(INTDIR)

# End Source File
# End Group
# End Project
################################################################################
