# Microsoft Developer Studio Project File - Name="legaproj" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 5.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) External Target" 0x0106

CFG=legaproj - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "legaproj.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "legaproj.mak" CFG="legaproj - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "legaproj - Win32 Release" (based on "Win32 (x86) External Target")
!MESSAGE "legaproj - Win32 Debug" (based on "Win32 (x86) External Target")
!MESSAGE 

# Begin Project
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""

!IF  "$(CFG)" == "legaproj - Win32 Release"

# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Cmd_Line "NMAKE /f legaproj.mak"
# PROP BASE Rebuild_Opt "/a"
# PROP BASE Target_File "legaproj.exe"
# PROP BASE Bsc_Name "legaproj.bsc"
# PROP BASE Target_Dir ""
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Cmd_Line "NMAKE /f legaproj.mak"
# PROP Rebuild_Opt "/a"
# PROP Target_File "legaproj.exe"
# PROP Bsc_Name "legaproj.bsc"
# PROP Target_Dir ""

!ELSEIF  "$(CFG)" == "legaproj - Win32 Debug"

# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "legaproj"
# PROP BASE Intermediate_Dir "legaproj"
# PROP BASE Cmd_Line "NMAKE /f legaproj.mak"
# PROP BASE Rebuild_Opt "/a"
# PROP BASE Target_File "legaproj.exe"
# PROP BASE Bsc_Name "legaproj.bsc"
# PROP BASE Target_Dir ""
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "legaproj"
# PROP Intermediate_Dir "legaproj"
# PROP Cmd_Line "NMAKE /f makefile.win"
# PROP Rebuild_Opt "/a "
# PROP Target_File "legacy.exe"
# PROP Bsc_Name "legaproj.bsc"
# PROP Target_Dir ""

!ENDIF 

# Begin Target

# Name "legaproj - Win32 Release"
# Name "legaproj - Win32 Debug"

!IF  "$(CFG)" == "legaproj - Win32 Release"

!ELSEIF  "$(CFG)" == "legaproj - Win32 Debug"

!ENDIF 

# Begin Source File

SOURCE=.\Constructor.h
# End Source File
# Begin Source File

SOURCE=.\cplusplus.cpp
# End Source File
# Begin Source File

SOURCE=.\Field.h
# End Source File
# Begin Source File

SOURCE=.\global.h
# End Source File
# Begin Source File

SOURCE=.\legacy.mak
# End Source File
# Begin Source File

SOURCE=.\main.cpp

!IF  "$(CFG)" == "legaproj - Win32 Release"

!ELSEIF  "$(CFG)" == "legaproj - Win32 Debug"

# PROP Ignore_Default_Tool 1

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\support.cpp
# End Source File
# End Target
# End Project
