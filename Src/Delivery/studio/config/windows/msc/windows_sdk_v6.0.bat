@ECHO OFF
:: --------------------------------------------------------------------------------------------
:: File    : SetEnv.cmd
::
:: Abstract: This batch file sets the appropriate environment
::           variables for the Windows SDK build environment with
::           respect to OS and platform type.
::
:: "Usage windows_sdk_v6.0.bat MSSdk [/Debug | /Release][/x86 | /x64 | /ia64][/vista | /xp | /2003 ][-h] "
::
::                /Debug   - Create a Debug configuration build environment
::                /Release - Create a Release configuration build environment
::                /x86     - Create 32-bit x86 applications
::                /x64     - Create 64-bit x64 applications
::                /ia64    - Create 64-bit ia64 applications
::                /vista   - Windows Vista applications
::                /xp      - Create Windows XP SP2 applications
::                /2003    - Create Windows Server 2003 applications
::
:: --------------------------------------------------------------------------------------------


:: -------------------------------------------------------------------
:: Establish default values
:: -------------------------------------------------------------------
SET MSSdk=%~1
SHIFT
Set SdkTools=%MSSdk%\Bin
Set OSLibraries=%MSSdk%\Lib
Set OSIncludes=%MSSdk%\Include;%MSSdk%\Include\gl
Set VCTools=%MSSdk%\VC\Bin
Set VCLibraries=%MSSdk%\VC\Lib
Set VCIncludes=%MSSdk%\VC\Include;%MSSdk%\VC\Include\Sys
Set ReferenceAssemblies=%ProgramFiles%\Reference Assemblies\Microsoft\WinFX\v3.0

:: Reset TARGET_CPU to allow defaults to work
SET TARGET_CPU=

IF /I "%PROCESSOR_ARCHITECTURE%"=="x86"   (
SET TARGET_CPU=x86
) ELSE IF /I "%PROCESSOR_ARCHITECTURE%"=="IA64"  (
SET TARGET_CPU=IA64
) ELSE IF /I "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
SET TARGET_CPU=x64
) ELSE IF /I "%PROCESSOR_ARCHITECTURE%"=="x64"   (
SET TARGET_CPU=x64
) ELSE IF /I "%PROCESSOR_ARCHITEW6432%"=="IA64"  (
SET TARGET_CPU=IA64
) ELSE IF /I "%PROCESSOR_ARCHITEW6432%"=="AMD64" (
SET TARGET_CPU=x64
) ELSE (SET TARGET_CPU=x86
)

:: -------------------------------------------------------------------
:: Parse command line argument values
:: Note: Currently, last one on the command line wins (ex: /DEBUG /RELEASE)
:: -------------------------------------------------------------------
IF NOT "x%~5"=="x" GOTO ERROR_Usage
:Parse_Args
IF /I "%~1"=="/Debug"      (SET TARGET_DEBUGTYPE=DEBUG& SHIFT & GOTO Parse_Args)
IF /I "%~1"=="/Release"    (SET TARGET_DEBUGTYPE=RELEASE& SHIFT & GOTO Parse_Args)
IF /I "%~1"=="/x86"        (SET TARGET_CPU=x86& SHIFT & GOTO Parse_Args)
IF /I "%~1"=="/x64"        (SET TARGET_CPU=x64& SHIFT & GOTO Parse_Args)
IF /I "%~1"=="/ia64"       (SET TARGET_CPU=IA64& SHIFT & GOTO Parse_Args)
IF /I "%~1"=="/vista"      (SET TARGET_PLATFORM=LH& SHIFT & GOTO Parse_Args)
IF /I "%~1"=="/xp"         (SET TARGET_PLATFORM=XP& SHIFT & GOTO Parse_Args)
IF /I "%~1"=="/2003"       (SET TARGET_PLATFORM=SRV& SHIFT & GOTO Parse_Args)
IF /I "%~1"=="-h"          (GOTO ERROR_Usage)
IF /I "%~1"=="/?"          (GOTO ERROR_Usage)
IF    "%~1" EQU ""         (GOTO Done_Args)
ECHO Unknown command-line switch: %~1
GOTO ERROR_Usage
:Done_Args

:: -------------------------------------------------------------------
:: Prevent path duplication if setenv is run multiple times within a 
:: single cmd session
:: -------------------------------------------------------------------
IF "x!ORIGINALPATH!x" == "xx" (
SET "ORIGINALINCLUDE=!INCLUDE!"
SET "ORIGINALLIB=!LIB!"
SET "ORIGINALPATH=!PATH!"
) ELSE (
SET "INCLUDE=!ORIGINALINCLUDE!"
SET "LIB=!ORIGINALLIB!"
SET "PATH=!ORIGINALPATH!"
)

:: -------------------------------------------------------------------
:: Check for the presence of MsVC
:: -------------------------------------------------------------------
ECHO.
CALL "%MSSDK%\Setup\vcdetect.exe" -nologo "%TEMP%\VCInit.bat"
IF EXIST "%TEMP%\VCInit.bat" (
CALL "%TEMP%\VCInit.bat"
del "%TEMP%\VCINIT.BAT"
ECHO.
)


:: -------------------------------------------------------------------
:: Default to DEBUG if no debug type specified and set the type
:: -------------------------------------------------------------------
IF "x%TARGET_DEBUGTYPE%"=="x" SET TARGET_DEBUGTYPE=DEBUG
IF "%TARGET_DEBUGTYPE%"=="DEBUG" (
	SET NODEBUG=
	SET DEBUGMSG=DEBUG
        COLOR 0E
) ELSE IF "%TARGET_DEBUGTYPE%"=="RELEASE" (
	SET NODEBUG=1
	SET DEBUGMSG=RELEASE
        COLOR 02
) ELSE GOTO ERROR_Usage


:: -------------------------------------------------------------------
:: Default to Vista if no target type specified and configure for appropriate target
:: -------------------------------------------------------------------
IF "x%TARGET_PLATFORM%"=="x" (
For /F "delims=;." %%i IN ('Cmd /c Ver') DO (
    IF "%%i"=="Microsoft Windows XP [Version 5" (
      SET TARGET_PLATFORM=XP
    ) ELSE IF "%%i"=="Microsoft Windows [Version 5" (
      SET TARGET_PLATFORM=SRV
    ) ELSE IF "%%i"=="Microsoft Windows [Version 6" (
      SET TARGET_PLATFORM=LH
    ) ELSE (
      SET TARGET_PLATFORM=LH
    )
)
)

:: Setup our VCTools environment path
IF "%TARGET_CPU%" =="x64" (
 IF "%PROCESSOR_ARCHITECTURE%" == "AMD64" ( 
   IF EXIST "%VCTools%\x64\cl.exe" (
   SET "VCTools=%VCTools%\x64"
   ) ELSE (
   SET VCTools=
   ECHO The x64 compilers are not currently installed.
   ECHO Please go to Add/Remove Programs to update your installation.
   ECHO .
   )
 ) ELSE IF "%PROCESSOR_ARCHITEW6432%"=="AMD64" ( 
     IF EXIST "%VCTools%\x64\cl.exe" (
     SET "VCTools=%VCTools%\x64"
     ) ELSE (
     SET VCTools=
     ECHO The x64 compilers are not currently installed.
     ECHO Please go to Add/Remove Programs to update your installation.
     ECHO .
     )
 ) ELSE ( 
     IF EXIST "%VCTools%\x86_x64\cl.exe" (
     SET "VCTools=%VCTools%\x86_x64;%VCTools%"
     ) ELSE (
     SET VCTools=
     ECHO The x64 compilers are not currently installed.
     ECHO Please go to Add/Remove Programs to update your installation.
     ECHO .
     )
   ) 
 ) ELSE IF "%TARGET_CPU%" =="IA64" (
 IF "%PROCESSOR_ARCHITECTURE%" == "IA64" (
   IF EXIST "%VCTools%\IA64\cl.exe" (
   SET "VCTools=%VCTools%\IA64"
   ) ELSE (
   SET VCTools=
   ECHO The IA64 compilers are not currently installed.
   ECHO Please go to Add/Remove Programs to update your installation.
   ECHO .
   )
 ) ELSE IF "%PROCESSOR_ARCHITEW6432%"=="IA64" ( 
     IF EXIST "%VCTools%\IA64\cl.exe" (
     SET "VCTools=%VCTools%\IA64"
     ) ELSE (
     SET VCTools=
     ECHO The IA64 compilers are not currently installed.
     ECHO Please go to Add/Remove Programs to update your installation.
     ECHO .
     )
   ) ELSE ( 
     IF EXIST "%VCTools%\x86_IA64\cl.exe" (
     SET "VCTools=%VCTools%\x86_IA64;%VCTools%"
     ) ELSE (
     SET VCTools=
     ECHO The IA64 compilers are not currently installed.
     ECHO Please go to Add/Remove Programs to update your installation.
     ECHO .
     )
   )
 ) ELSE IF NOT EXIST "%VCTools%\cl.exe" (
     SET VCTools=
     ECHO The x86 compilers are not currently installed.
     ECHO Please go to Add/Remove Programs to update your installation.
     ECHO .
 )

:: Setup our SdkTools environment path
IF "%PROCESSOR_ARCHITECTURE%" =="AMD64" (
 SET "SdkTools=%SdkTools%\x64;%SdkTools%"
) ELSE IF "%PROCESSOR_ARCHITECTURE%" =="IA64" (
 SET "SdkTools=%SdkTools%\IA64;%SdkTools%"
)else IF "%PROCESSOR_ARCHITEW6432%" =="AMD64" (
 SET "SdkTools=%SdkTools%\x64;%SdkTools%"
) ELSE IF "%PROCESSOR_ARCHITEW6432%" =="IA64" (
 SET "SdkTools=%SdkTools%\IA64;%SdkTools%"
)

:: Setting the path
SET FxTools=%windir%\Microsoft.NET\Framework\v2.0.50727
SET Path=%VCTools%;%SdkTools%;%FxTools%;!Path!

:: Setting the Platform
SET TARGETOS=WINNT

ECHO Setting SDK environment relative to %MSSdk%. 
GOTO Set_%TARGET_PLATFORM%%TARGET_CPU%


:: -------------------------------------------------------------------
:: SET Windows Vista x86 specific variables
:: -------------------------------------------------------------------
:Set_LHx86
ECHO Targeting Windows Vista x86 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB;%LIB%"
  )
)

SET Lib=%VCLibraries%;%OSLibraries%;!Lib!
SET Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=i386
SET APPVER=6.0
TITLE Microsoft Windows Vista x86 %DEBUGMSG% Build Environment
GOTO End_Success


:: -------------------------------------------------------------------
:: SET Windows Vista x64 specific variables
:: -------------------------------------------------------------------
:Set_LHX64
ECHO Targeting Windows Vista x64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\AMD64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\AMD64;%LIB%"
  )
)

Set Lib=%VCLibraries%\x64;%OSLibraries%\X64;!Lib!
Set Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=AMD64


SET APPVER=6.0
TITLE Microsoft Windows Vista x64 %DEBUGMSG% Build Environment
GOTO End_Success


:: -------------------------------------------------------------------
:: SET Windows Vista IA64 specific variables
:: -------------------------------------------------------------------
:Set_LHIA64
ECHO Targeting Windows Vista IA64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\IA64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\IA64;%LIB%"
  )
)

Set Lib=%VCLibraries%\IA64;%OSLibraries%\IA64;!Lib!
Set Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=IA64
SET APPVER=6.0
TITLE Microsoft Windows Vista IA64 %DEBUGMSG% Build Environment
GOTO End_Success


:: -------------------------------------------------------------------
:: SET Windows XP x86 specific variables
:: -------------------------------------------------------------------
:Set_XPx86
ECHO Targeting Windows XP x86 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB;%LIB%"
  )
)

SET Lib=%VCLibraries%;%OSLibraries%;!Lib!
SET Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=i386
SET APPVER=5.01
TITLE Microsoft Windows XP x86 %DEBUGMSG% Build Environment
GOTO End_Success


:: -------------------------------------------------------------------
:: SET Windows XP x64 specific variables
:: -------------------------------------------------------------------
:Set_XPx64
ECHO Targeting Windows XP x64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\AMD64" (
  SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\AMD64;%LIB%"
  )
)

Set Lib=%VCLibraries%\x64;%OSLibraries%\x64;!Lib!
Set Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=AMD64
SET APPVER=5.02
TITLE Microsoft Windows XP x64 %DEBUGMSG% Build Environment
GOTO End_Success

:: -------------------------------------------------------------------
:: SET Windows XP IA64 specific variables
:: -------------------------------------------------------------------
:Set_XPIA64
ECHO Targeting Windows XP IA64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\IA64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\IA64;%LIB%"
  )
)

Set Lib=%VCLibraries%\IA64;%OSLibraries%\IA64;!Lib!
Set Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=IA64
SET APPVER=5.01
TITLE Microsoft Windows XP IA64 %DEBUGMSG% Build Environment
GOTO End_Success


:: -------------------------------------------------------------------
:: SET Windows Server x86 2003 specific variables
:: -------------------------------------------------------------------
:Set_SRVx86
ECHO Targeting Windows Server 2003 x86 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB;%LIB%"
  )
)

SET Lib=%VCLibraries%;%OSLibraries%;!Lib!
SET Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=i386
SET APPVER=5.02
TITLE Microsoft Windows Server 2003 x86 %DEBUGMSG% Build Environment
GOTO End_Success

:: -------------------------------------------------------------------
:: SET Windows Server x64 2003 specific variables
:: -------------------------------------------------------------------
:Set_SRVx64
ECHO Targeting Windows Server 2003 x64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\AMD64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\AMD64;%LIB%"
  )
)

Set Lib=%VCLibraries%\x64;%OSLibraries%\x64;!Lib!
Set Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=AMD64
SET APPVER=5.02
TITLE Microsoft Windows Server 2003 x64 %DEBUGMSG% Build Environment
GOTO End_Success

:: -------------------------------------------------------------------
:: SET Windows Server IA64 2003 specific variables
:: -------------------------------------------------------------------
:Set_SRVIA64
ECHO Targeting Windows Server 2003 IA64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\IA64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\IA64;%LIB%"
  )
)

Set Lib=%VCLibraries%\IA64;%OSLibraries%\IA64;!Lib!
Set Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=IA64
SET APPVER=5.02
TITLE Microsoft Windows Server 2003 IA64 %DEBUGMSG% Build Environment
GOTO End_Success


:: -------------------------------------------------------------------
:: Echo usage
:: -------------------------------------------------------------------
:ERROR_Usage
ECHO Usage: "windows_sdk_v6.0.bat MSSdk [/Debug | /Release][/x86 | /x64 | /ia64][/vista | /xp | /2003 ][-h or /?]"
ECHO.
ECHO                 /Debug   - Create a Debug configuration build environment
ECHO                 /Release - Create a Release configuration build environment
ECHO                 /x86     - Create 32-bit x86 applications
ECHO                 /x64     - Create 64-bit x64 applications
ECHO                 /ia64    - Create 64-bit ia64 applications
ECHO                 /vista   - Windows Vista applications
ECHO                 /xp      - Create Windows XP SP2 applications
ECHO                 /2003    - Create Windows Server 2003 applications
GOTO End_Fail

:: -------------------------------------------------------------------
:: End Successfully (Success, no cleanup)
:: -------------------------------------------------------------------
:End_Success
IF "x%OS%x" == "xWindows_NTx" SET DEBUGMSG= & GOTO CleanUp
ECHO *** WARNING ***
ECHO You are currently building on a Windows 9x based platform.  Most samples have 
ECHO NMAKE create a destination directory for created objects and executables.  
ECHO There is a known issue with the OS where NMAKE fails to create this destination
ECHO directory when the current directory is several directories deep.  To fix this 
ECHO problem, you must create the destination directory by hand from the command 
ECHO line before calling NMAKE. 
ECHO.
GOTO CleanUp


:: -------------------------------------------------------------------
:: Fail
:: -------------------------------------------------------------------
:End_Fail
SET VCBUILD_DEFAULT_OPTIONS=
GOTO CleanUp

:: -------------------------------------------------------------------
:: Clean up
:: -------------------------------------------------------------------
:CleanUp
SET OSLibraries=
SET OSIncludes=
SET VCTools=
SET VCLibraries=
SET VCIncludes=
SET TARGET_PLATFORM=
SET TARGET_DEBUGTYPE=
SET TARGET_CPU=
