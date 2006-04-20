# Microsoft Developer Studio Project File - Name="shared" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=shared - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "shared.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "shared.mak" CFG="shared - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "shared - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE "shared - Win32 traditional" (based on "Win32 (x86) Static Library")
!MESSAGE "shared - Win32 mt" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "shared - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /W3 /GX /Z7 /Od /I "..\.." /I "..\..\run-time" /I "..\..\idrs" /D "_DEBUG" /YX /FD /c
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"Debug\ipc.lib"

!ELSEIF  "$(CFG)" == "shared - Win32 traditional"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "traditional"
# PROP BASE Intermediate_Dir "traditional"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir ""
# PROP Intermediate_Dir "traditional"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /GX /Ox /I "..\.." /I "..\..\run-time" /I "..\..\idrs" /D "WORKBENCH" /YX /FD /c
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"ipc.lib"

!ELSEIF  "$(CFG)" == "shared - Win32 mt"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "mt"
# PROP BASE Intermediate_Dir "mt"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir ""
# PROP Intermediate_Dir "mt"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /MT /O2 /I "..\.." /I "..\..\run-time" /I "..\..\idrs" /D "WORKBENCH" /D "EIF_THREADS" /D "ISE_GC" /FD /c
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo /o"mtshared.bsc"
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"mtipc.lib"

!ENDIF 

# Begin Target

# Name "shared - Win32 Debug"
# Name "shared - Win32 traditional"
# Name "shared - Win32 mt"
# Begin Source File

SOURCE=.\com.c
# End Source File
# Begin Source File

SOURCE=.\identify.c
# End Source File
# Begin Source File

SOURCE=.\lock.c
# End Source File
# Begin Source File

SOURCE=.\logfile.c
# End Source File
# Begin Source File

SOURCE=.\network.c
# End Source File
# Begin Source File

SOURCE=.\networku.c
# End Source File
# Begin Source File

SOURCE=.\rqst_idrs.c
# End Source File
# Begin Source File

SOURCE=.\select.c
# End Source File
# Begin Source File

SOURCE=.\shword.c
# End Source File
# Begin Source File

SOURCE=.\stack.c
# End Source File
# Begin Source File

SOURCE=.\stream.c
# End Source File
# Begin Source File

SOURCE=.\system.c
# End Source File
# Begin Source File

SOURCE=.\transfer.c
# End Source File
# Begin Source File

SOURCE=.\uu.c
# End Source File
# End Target
# End Project
