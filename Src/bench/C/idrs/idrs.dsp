# Microsoft Developer Studio Project File - Name="idrs" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 5.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=idrs - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "idrs.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "idrs.mak" CFG="idrs - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "idrs - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE "idrs - Win32 traditional" (based on "Win32 (x86) Static Library")
!MESSAGE "idrs - Win32 mt" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe

!IF  "$(CFG)" == "idrs - Win32 Debug"

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
# ADD CPP /nologo /W3 /GX /Z7 /Od /D "_DEBUG" /YX /FD /c
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"Debug\idr.lib"

!ELSEIF  "$(CFG)" == "idrs - Win32 traditional"

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
# ADD CPP /nologo /W3 /GX /O2 /YX /FD /c
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"idr.lib"

!ELSEIF  "$(CFG)" == "idrs - Win32 mt"

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
# ADD CPP /nologo /MT /W3 /GX /O2 /D "EIF_THREADS" /YX /FD /c
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo /o"mtidrs.bsc"
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"idr.lib"

!ENDIF 

# Begin Target

# Name "idrs - Win32 Debug"
# Name "idrs - Win32 traditional"
# Name "idrs - Win32 mt"
# Begin Source File

SOURCE=.\idr_array.c
# End Source File
# Begin Source File

SOURCE=.\idr_char.c
# End Source File
# Begin Source File

SOURCE=.\idr_double.c
# End Source File
# Begin Source File

SOURCE=.\idr_float.c
# End Source File
# Begin Source File

SOURCE=.\idr_getpos.c
# End Source File
# Begin Source File

SOURCE=.\idr_int.c
# End Source File
# Begin Source File

SOURCE=.\idr_long.c
# End Source File
# Begin Source File

SOURCE=.\idr_opaque.c
# End Source File
# Begin Source File

SOURCE=.\idr_poly.c
# End Source File
# Begin Source File

SOURCE=.\idr_read.c
# End Source File
# Begin Source File

SOURCE=.\idr_setpos.c
# End Source File
# Begin Source File

SOURCE=.\idr_short.c
# End Source File
# Begin Source File

SOURCE=.\idr_size.c
# End Source File
# Begin Source File

SOURCE=.\idr_stack.c
# End Source File
# Begin Source File

SOURCE=.\idr_string.c
# End Source File
# Begin Source File

SOURCE=.\idr_uchar.c
# End Source File
# Begin Source File

SOURCE=.\idr_uint.c
# End Source File
# Begin Source File

SOURCE=.\idr_ulong.c
# End Source File
# Begin Source File

SOURCE=.\idr_union.c
# End Source File
# Begin Source File

SOURCE=.\idr_ushort.c
# End Source File
# Begin Source File

SOURCE=.\idr_vector.c
# End Source File
# Begin Source File

SOURCE=.\idr_void.c
# End Source File
# Begin Source File

SOURCE=.\idr_write.c
# End Source File
# Begin Source File

SOURCE=.\idrf_creat.c
# End Source File
# Begin Source File

SOURCE=.\idrf_dstry.c
# End Source File
# Begin Source File

SOURCE=.\idrf_pos.c
# End Source File
# Begin Source File

SOURCE=.\idrm_creat.c
# End Source File
# Begin Source File

SOURCE=.\idrm_dstry.c
# End Source File
# End Target
# End Project
