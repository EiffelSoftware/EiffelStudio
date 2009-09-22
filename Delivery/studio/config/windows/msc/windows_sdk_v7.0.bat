@ECHO OFF
:: --------------------------------------------------------------------------------------------
:: File : SetEnv.cmd
::
:: Abstract: This batch file sets the appropriate environment variables for the Windows SDK
::           build environment with respect to OS and platform type.
::
:: Usage : Setenv [/Debug | /Release][/x86 | /x64 | /ia64][/vista | /xp | /2003 | /2008 | /win7][-h | /?]
::
::                /Debug   - Create a Debug configuration build environment
::                /Release - Create a Release configuration build environment
::                /x86     - Create 32-bit x86 applications
::                /x64     - Create 64-bit x64 applications
::                /ia64    - Create 64-bit ia64 applications
::                /vista   - Windows Vista applications
::                /xp      - Create Windows XP SP2 applications
::                /2003    - Create Windows Server 2003 applications
::                /2008    - Create Windows Server 2008 or Vista SP1 applications
::                /win7    - Create Windows 7 applications
::
:: Note: This file makes use of delayed expansion to get around the limitations
:: of the current expansion which happens when a line of text is read , not when it is executed.
:: For more information about delayed expansion type: SET /? from the command line
:: --------------------------------------------------------------------------------------------


:: --------------------------------------------------------------------------------------------
:: Default value for SDK install directory that is determined during the install of the SDK.
:: --------------------------------------------------------------------------------------------
SET MSSdk=%~1
SET TARGETOS=WINNT

:: --------------------------------------------------------------------------------------------
:: Set the default value for target and current CPU based on processor architecture.
:: --------------------------------------------------------------------------------------------
SET CURRENT_CPU=x86
SET TARGET_CPU=x86

IF /I "%PROCESSOR_ARCHITECTURE%"=="AMD64" SET "TARGET_CPU=x64" & SET "CURRENT_CPU=x64" & GOTO Parse_Args
IF /I "%PROCESSOR_ARCHITEW6432%"=="AMD64" SET "TARGET_CPU=x64" & SET "CURRENT_CPU=x64" & GOTO Parse_Args
IF /I "%PROCESSOR_ARCHITECTURE%"=="x64"   SET "TARGET_CPU=x64" & SET "CURRENT_CPU=x64" & GOTO Parse_Args

IF /I "%PROCESSOR_ARCHITECTURE%"=="IA64"  SET "TARGET_CPU=IA64" & SET "CURRENT_CPU=IA64" & GOTO Parse_Args
IF /I "%PROCESSOR_ARCHITEW6432%"=="IA64"  SET "TARGET_CPU=IA64" & SET "CURRENT_CPU=IA64"

:: --------------------------------------------------------------------------------------------
:: Parse command line argument values.
:: Note: For ambiguous arguments the last one wins (ex: /debug /release)
:: --------------------------------------------------------------------------------------------
:Parse_Args
IF /I "%~1"=="/debug"      SET "TARGET_DEBUGTYPE=DEBUG"   & SHIFT & GOTO Parse_Args
IF /I "%~1"=="/release"    SET "TARGET_DEBUGTYPE=RELEASE" & SHIFT & GOTO Parse_Args
IF /I "%~1"=="/x86"        SET "TARGET_CPU=x86"           & SHIFT & GOTO Parse_Args
IF /I "%~1"=="/x64"        SET "TARGET_CPU=x64"           & SHIFT & GOTO Parse_Args
IF /I "%~1"=="/ia64"       SET "TARGET_CPU=IA64"          & SHIFT & GOTO Parse_Args
IF /I "%~1"=="/vista"      SET "TARGET_PLATFORM=LH"       & SHIFT & GOTO Parse_Args
IF /I "%~1"=="/xp"         SET "TARGET_PLATFORM=XP"       & SHIFT & GOTO Parse_Args
IF /I "%~1"=="/2003"       SET "TARGET_PLATFORM=SRV"      & SHIFT & GOTO Parse_Args
IF /I "%~1"=="/2008"       SET "TARGET_PLATFORM=LHS"      & SHIFT & GOTO Parse_Args
IF /I "%~1"=="/win7"       SET "TARGET_PLATFORM=WIN7"     & SHIFT & GOTO Parse_Args
IF /I "%~1"=="-h"          GOTO Error_Usage
IF /I "%~1"=="/?"          GOTO Error_Usage
IF    "x%~1"=="x"          GOTO Done_Args

ECHO Unknown command-line switch: %~1
GOTO Error_Usage

:Done_Args

:: --------------------------------------------------------------------------------------------
:: Prevent path duplication if setenv is run multiple times within a single command session
:: --------------------------------------------------------------------------------------------
IF "x!ORIGINALPATH!x" == "xx" (
SET "ORIGINALINCLUDE=!INCLUDE!"
SET "ORIGINALLIB=!LIB!"
SET "ORIGINALPATH=!PATH!"
) ELSE (
SET "INCLUDE=!ORIGINALINCLUDE!"
SET "LIB=!ORIGINALLIB!"
SET "PATH=!ORIGINALPATH!"
)

:: --------------------------------------------------------------------------------------------
:: Default the build configuration to DEBUG if one is not specified.
:: Set the command prompt text color based on the build configuration.
:: --------------------------------------------------------------------------------------------
IF "x%TARGET_DEBUGTYPE%"=="x" SET TARGET_DEBUGTYPE=DEBUG
IF "%TARGET_DEBUGTYPE%"=="DEBUG" (
    SET NODEBUG=
    SET DEBUGMSG=DEBUG
        COLOR 0E
) ELSE IF "%TARGET_DEBUGTYPE%"=="RELEASE" (
    SET NODEBUG=1
    SET DEBUGMSG=RELEASE
        COLOR 02
) ELSE GOTO Error_Usage

:: --------------------------------------------------------------------------------------------
:: Default to LHS if no target type specified and configure for appropriate target
:: --------------------------------------------------------------------------------------------
IF "x%TARGET_PLATFORM%"=="x" (
FOR /F "tokens=1,2,3 delims=;." %%i IN ('Cmd /c Ver') DO (
    IF "%%i"=="Microsoft Windows XP [Version 5" (
      SET TARGET_PLATFORM=XP
    ) ELSE IF "%%i"=="Microsoft Windows [Version 5" (
      SET TARGET_PLATFORM=SRV
    ) ELSE IF "%%i"=="Microsoft Windows [Version 6" (
      IF "%%k" == "6000]" (
        SET TARGET_PLATFORM=LH
      ) ELSE IF "%%k" == "6001]" (
        SET TARGET_PLATFORM=LHS
      ) ELSE IF "%%j" == "1" (
	    SET TARGET_PLATFORM=WIN7
	  ) ELSE (
	    SET TARGET_PLATFORM=LHS
	  )
    ) ELSE (
      SET TARGET_PLATFORM=LHS
    )
  )
)

:: --------------------------------------------------------------------------------------------
:: Determine which registry keys to look at based on architecture type.  Set default values for
:: VC and VS root, which would be used if one or both the corresponding registry keys are not
:: found.
:: --------------------------------------------------------------------------------------------
SET RegKeyPath=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\VisualStudio\SxS\VC7
SET VSRegKeyPath=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\VisualStudio\SxS\VS7
SET "VCRoot=%ProgramFiles%\Microsoft Visual Studio 9.0"
SET "VSRoot=%ProgramFiles%\Microsoft Visual Studio 9.0\"

IF "%CURRENT_CPU%"=="x64" GOTO SetRegPathFor64Bit	
IF "%CURRENT_CPU%"=="IA64" GOTO SetRegPathFor64Bit
GOTO Done_SetRegPath


:SetRegPathFor64Bit
SET RegKeyPath=HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VC7
SET VSRegKeyPath=HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VS7
SET "VCRoot=%ProgramFiles(x86)%\Microsoft Visual Studio 9.0"
SET "VSRoot=%ProgramFiles(x86)%\Microsoft Visual Studio 9.0\"

:Done_SetRegPath

:: --------------------------------------------------------------------------------------------
:: Save the default values for VCRoot and VSRoot just in case we get unexpected output from
:: the calls to REG in the next section
:: --------------------------------------------------------------------------------------------
SET "VCRoot_Orig=%VCRoot%"
SET "VSRoot_Orig=%VSRoot%"

:: --------------------------------------------------------------------------------------------
:: Read the value for VCRoot and VSRoot from the registry.
:: Note: The second call to REG will fail if VS is not installed.  These calls to REG are
:: checking to see if VS is installed in a custom location.  This behavior is expected in
:: this scenario.
:: --------------------------------------------------------------------------------------------
FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "%RegKeyPath%" /v 9.0') DO SET VCRoot=%%B
FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "%VSRegKeyPath%" /v 9.0') DO SET VSRoot=%%B

:: --------------------------------------------------------------------------------------------
:: Hide the error output from the call to 'REG' since VCRoot and VSRoot have already been set
:: to a default value.
:: --------------------------------------------------------------------------------------------
CLS

:: --------------------------------------------------------------------------------------------
:: Versions of Reg.exe on XP SP2 and SP3 have different output than other versions.  Detect
:: incorrect output and reset VCRoot and VSRoot as needed
:: --------------------------------------------------------------------------------------------
IF "%VCRoot%"=="VERSION 3.0" SET "VCRoot=%VCRoot_Orig%"
IF "%VSRoot%"=="VERSION 3.0" SET "VSRoot=%VSRoot_Orig%"

:: --------------------------------------------------------------------------------------------
:: Setup our VCTools environment path based on target CPU and processor architecture
:: When the native compilers are not installed for the specified CPU, attempt to locate the
:: cross-tools for non-native compilation.
:: --------------------------------------------------------------------------------------------
SET "VCTools=%VCRoot%Bin"

IF "%TARGET_CPU%" =="x64" (
  IF "%CURRENT_CPU%" == "x64" (
    IF EXIST "%VCTools%\amd64\cl.exe" (
      SET "VCTools=%VCTools%\amd64"
    ) ELSE IF EXIST "%VCTools%\x86_amd64\cl.exe" (
      SET "VCTools=!VSTools!\x86_amd64"
    ) ELSE (
      SET VCTools=
      ECHO The x64 compilers are not currently installed.
      ECHO Please go to Add/Remove Programs to update your installation.
      ECHO .
    )
  ) ELSE IF EXIST "%VCTools%\x86_amd64\cl.exe" (
    SET "VCTools=%VCTools%\x86_amd64;%VCTools%"
  ) ELSE (
    SET VCTools=
    ECHO The x64 compilers are not currently installed.
    ECHO Please go to Add/Remove Programs to update your installation.
    ECHO .
  )
) ELSE IF "%TARGET_CPU%" =="IA64" (
  IF "%CURRENT_CPU%" == "IA64" (
    IF EXIST "%VCTools%\IA64\cl.exe" (
      SET "VCTools=%VCTools%\IA64"
    ) ELSE IF EXIST "%VCTools%\x86_ia64\cl.exe" (
      SET "VCTools=!VCTools!\x86_ia64"
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

:: --------------------------------------------------------------------------------------------
:: Set the values for VC and VS directories.
:: --------------------------------------------------------------------------------------------
Set "VSTools=%VCRoot%vcpackages;%VSRoot%Common7\IDE"
Set "VCINSTALLDIR=%VCRoot%"
Set "VCLibraries=%VCRoot%Lib"
Set "VCIncludes=%VCRoot%Include"

:: --------------------------------------------------------------------------------------------
:: Setup the Windows SDK Setup directory to path
:: --------------------------------------------------------------------------------------------
SET SdkSetupDir=%MSSdk%\Setup
SET Path=%SdkSetupDir%;!Path!

:: --------------------------------------------------------------------------------------------
:: Setup the SdkTools environment path
:: --------------------------------------------------------------------------------------------
SET SdkTools=%MSSdk%\Bin

IF "%CURRENT_CPU%" =="x64" (
 SET "SdkTools=%SdkTools%\x64;%SdkTools%"
) ELSE IF "%CURRENT_CPU%" =="IA64" (
 SET "SdkTools=%SdkTools%\IA64;%SdkTools%"
)

:: --------------------------------------------------------------------------------------------
:: Set the environment path
:: --------------------------------------------------------------------------------------------
IF "%TARGET_CPU%" =="x64" (
 SET "FxTools=%windir%\Microsoft.NET\Framework64\v3.5;%windir%\Microsoft.NET\Framework\v3.5;%windir%\Microsoft.NET\Framework64\v2.0.50727;%windir%\Microsoft.NET\Framework\v2.0.50727"
) ELSE IF "%TARGET_CPU%" =="IA64" (
 SET "FxTools=%windir%\Microsoft.NET\Framework64\v3.5;%windir%\Microsoft.NET\Framework\v3.5;%windir%\Microsoft.NET\Framework64\v2.0.50727;%windir%\Microsoft.NET\Framework\v2.0.50727"
) ELSE (
 SET "FxTools=%windir%\Microsoft.NET\Framework\v3.5;%windir%\Microsoft.NET\Framework\v2.0.50727"
)
SET Path=%VCTools%;%VSTools%;%SdkTools%;%FxTools%;!Path!

:: --------------------------------------------------------------------------------------------
:: Display SDK environment information
:: --------------------------------------------------------------------------------------------
SET OSLibraries=%MSSdk%\Lib
SET OSIncludes=%MSSdk%\Include;%MSSdk%\Include\gl

ECHO Setting SDK environment relative to %MSSdk%.
GOTO Set_%TARGET_PLATFORM%%TARGET_CPU%

:: --------------------------------------------------------------------------------------------
:: Set Windows 7 x86 specific variables
:: --------------------------------------------------------------------------------------------
:Set_WIN7x86
ECHO Targeting Windows 7 x86 %DEBUGMSG%
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
SET APPVER=6.1
TITLE Microsoft Windows 7 %DEBUGMSG% Build Environment
GOTO End_Success

:: --------------------------------------------------------------------------------------------
:: Set Windows 7 x64 specific variables
:: --------------------------------------------------------------------------------------------
:Set_WIN7X64
ECHO Targeting Windows 7 x64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\AMD64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\AMD64;%LIB%"
  )
)

SET Lib=%VCLibraries%\amd64;%OSLibraries%\X64;!Lib!
SET Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=AMD64
SET APPVER=6.1
TITLE Microsoft Windows 7 x64 %DEBUGMSG% Build Environment
GOTO End_Success

:: --------------------------------------------------------------------------------------------
:: Set Windows 7 IA64 specific variables
:: --------------------------------------------------------------------------------------------
:Set_WIN7IA64
ECHO Targeting Windows 7 IA64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\IA64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\IA64;%LIB%"
  )
)

SET Lib=%VCLibraries%\IA64;%OSLibraries%\IA64;!Lib!
SET Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=IA64
SET APPVER=6.1
TITLE Microsoft Windows 7 IA64 %DEBUGMSG% Build Environment
GOTO End_Success

:: --------------------------------------------------------------------------------------------
:: Set Windows Server 2008 x86 specific variables
:: --------------------------------------------------------------------------------------------
:Set_LHSx86
ECHO Targeting Windows Server 2008 x86 %DEBUGMSG%
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
TITLE Microsoft Windows Server 2008 %DEBUGMSG% Build Environment
GOTO End_Success

:: --------------------------------------------------------------------------------------------
:: Set Windows Server 2008 x64 specific variables
:: --------------------------------------------------------------------------------------------
:Set_LHSX64
ECHO Targeting Windows Server 2008 x64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\AMD64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\AMD64;%LIB%"
  )
)

SET Lib=%VCLibraries%\amd64;%OSLibraries%\X64;!Lib!
SET Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=AMD64
SET APPVER=6.0
TITLE Microsoft Windows Server 2008 x64 %DEBUGMSG% Build Environment
GOTO End_Success

:: --------------------------------------------------------------------------------------------
:: Set Windows Server 2008 IA64 specific variables
:: --------------------------------------------------------------------------------------------
:Set_LHSIA64
ECHO Targeting Windows Server 2008 IA64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\IA64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\IA64;%LIB%"
  )
)

SET Lib=%VCLibraries%\IA64;%OSLibraries%\IA64;!Lib!
SET Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=IA64
SET APPVER=6.0
TITLE Microsoft Windows Server 2008 IA64 %DEBUGMSG% Build Environment
GOTO End_Success

:: --------------------------------------------------------------------------------------------
:: Set Windows Vista x86 specific variables
:: --------------------------------------------------------------------------------------------
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

:: --------------------------------------------------------------------------------------------
:: Set Windows Vista x64 specific variables
:: --------------------------------------------------------------------------------------------
:Set_LHX64
ECHO Targeting Windows Vista x64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\AMD64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\AMD64;%LIB%"
  )
)

SET Lib=%VCLibraries%\amd64;%OSLibraries%\X64;!Lib!
SET Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=AMD64
SET APPVER=6.0
TITLE Microsoft Windows Vista x64 %DEBUGMSG% Build Environment
GOTO End_Success

:: --------------------------------------------------------------------------------------------
:: Set Windows Vista IA64 specific variables
:: --------------------------------------------------------------------------------------------
:Set_LHIA64
ECHO Targeting Windows Vista IA64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\IA64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\IA64;%LIB%"
  )
)

SET Lib=%VCLibraries%\IA64;%OSLibraries%\IA64;!Lib!
SET Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=IA64
SET APPVER=6.0
TITLE Microsoft Windows Vista IA64 %DEBUGMSG% Build Environment
GOTO End_Success

:: --------------------------------------------------------------------------------------------
:: Set Windows XP x86 specific variables
:: --------------------------------------------------------------------------------------------
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

:: --------------------------------------------------------------------------------------------
:: Set Windows XP x64 specific variables
:: --------------------------------------------------------------------------------------------
:Set_XPx64
ECHO Targeting Windows XP x64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\AMD64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\AMD64;%LIB%"
  )
)

SET Lib=%VCLibraries%\amd64;%OSLibraries%\x64;!Lib!
SET Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=AMD64
SET APPVER=5.02
TITLE Microsoft Windows XP x64 %DEBUGMSG% Build Environment
GOTO End_Success

:: --------------------------------------------------------------------------------------------
:: Set Windows XP IA64 specific variables
:: --------------------------------------------------------------------------------------------
:Set_XPIA64
ECHO Targeting Windows XP IA64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\IA64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\IA64;%LIB%"
  )
)

SET Lib=%VCLibraries%\IA64;%OSLibraries%\IA64;!Lib!
SET Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=IA64
SET APPVER=5.01
TITLE Microsoft Windows XP IA64 %DEBUGMSG% Build Environment
GOTO End_Success

:: --------------------------------------------------------------------------------------------
:: Set Windows Server x86 2003 specific variables
:: --------------------------------------------------------------------------------------------
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

:: --------------------------------------------------------------------------------------------
:: Set Windows Server x64 2003 specific variables
:: --------------------------------------------------------------------------------------------
:Set_SRVx64
ECHO Targeting Windows Server 2003 x64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\AMD64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\AMD64;%LIB%"
  )
)

SET Lib=%VCLibraries%\amd64;%OSLibraries%\x64;!Lib!
SET Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=AMD64
SET APPVER=5.02
TITLE Microsoft Windows Server 2003 x64 %DEBUGMSG% Build Environment
GOTO End_Success

:: --------------------------------------------------------------------------------------------
:: Set Windows Server IA64 2003 specific variables
:: --------------------------------------------------------------------------------------------
:Set_SRVIA64
ECHO Targeting Windows Server 2003 IA64 %DEBUGMSG%
ECHO.

IF NOT "x!VCINSTALLDIR!x"=="xx" (
  IF EXIST "!VCINSTALLDIR!ATLMFC\LIB\IA64" (
    SET "INCLUDE=!VCINSTALLDIR!ATLMFC\INCLUDE;%INCLUDE%"
    SET "LIB=!VCINSTALLDIR!ATLMFC\LIB\IA64;%LIB%"
  )
)

SET Lib=%VCLibraries%\IA64;%OSLibraries%\IA64;!Lib!
SET Include=%VCIncludes%;%OSIncludes%;!Include!
SET CPU=IA64
SET APPVER=5.02
TITLE Microsoft Windows Server 2003 IA64 %DEBUGMSG% Build Environment
GOTO End_Success

:: --------------------------------------------------------------------------------------------
:: Display command usage and goto cleanup code.
:: --------------------------------------------------------------------------------------------
:Error_Usage
ECHO Usage: "Setenv [/Debug | /Release][/x86 | /x64 | /ia64][/vista | /xp | /2003 | /2008 | /win7][-h | /?]"
ECHO.
ECHO                 /Debug   - Create a Debug configuration build environment
ECHO                 /Release - Create a Release configuration build environment
ECHO                 /x86     - Create 32-bit x86 applications
ECHO                 /x64     - Create 64-bit x64 applications
ECHO                 /ia64    - Create 64-bit ia64 applications
ECHO                 /vista   - Windows Vista applications
ECHO                 /xp      - Create Windows XP SP2 applications
ECHO                 /2003    - Create Windows Server 2003 applications
ECHO                 /2008    - Create Windows Server 2008 or Vista SP1 applications
ECHO                 /win7    - Create Windows 7 applications

SET VCBUILD_DEFAULT_OPTIONS=
GOTO CleanUp

:: --------------------------------------------------------------------------------------------
:: End Successfully.  
:: If Windows 7 headers,libs and tools are not used, display a warning message.
:: If necessary, display warning about compiling on Windows 9x platforms.
:: --------------------------------------------------------------------------------------------
:End_Success
CALL :GetWindowsSdkVersion
IF ERRORLEVEL 1 (
	CALL :DisplayWarningMsg_NoVersion
) ELSE (
	IF NOT "%CurrentSdkVersion%" == "v7.0" CALL :DisplayWarningMsg
)
IF "x%OS%x" == "xWindows_NTx" SET "DEBUGMSG=" & GOTO CleanUp
ECHO *** WARNING ***
ECHO You are currently building on a Windows 9x based platform.  Most samples have 
ECHO NMAKE create a destination directory for created objects and executables.  
ECHO There is a known issue with the OS where NMAKE fails to create this destination
ECHO directory when the current directory is several directories deep.  To fix this 
ECHO problem, you must create the destination directory by hand from the command 
ECHO line before calling NMAKE. 
ECHO.


:DisplayWarningMsg
ECHO **********************************************************************************
ECHO WARNING: The VC++ Compiler Toolset is currently using Windows SDK '%CurrentSdkVersion%'. 
ECHO To use Windows SDK v7.0 use 'WindowsSdkVer.exe -version:v7.0', or alternatively 
ECHO you can pass the '/useenv' switch to vcbuild.exe to use the Windows SDK v7.0 on 
ECHO a per project basis. 
ECHO **********************************************************************************
EXIT /B 0

:DisplayWarningMsg_NoVersion
ECHO **********************************************************************************
ECHO WARNING: The VC++ Compiler Toolset is not using Windows SDK v7.0. To use Windows
ECHO SDK v7.0 use 'WindowsSdkVer.exe -version:v7.0', or alternatively you can pass the
ECHO '/useenv' switch to vcbuild.exe to use the Windows SDK v7.0 on a per project
ECHO basis. 
ECHO **********************************************************************************
EXIT /B 0

:: --------------------------------------------------------------------
:: Detect the paths of Windows 7 headers, libs and tools by default
:: Note: Visual Studio IDE query HKCU key first and then try HKLM
:: --------------------------------------------------------------------
:GetWindowsSdkVersion
CALL :GetWindowsSdkVersionHelper HKCU > nul 2>&1
IF ERRORLEVEL 1 CALL :GetWindowsSdkVersionHelper HKLM > nul 2>&1
IF ERRORLEVEL 1 EXIT /B 1
EXIT /B 0

:GetWindowsSdkVersionHelper
SET CurrentSdkVersion=
FOR /F "tokens=1,2*" %%i in ('reg query "%1\SOFTWARE\Microsoft\Microsoft SDKs\Windows" /v "CurrentVersion"') DO (
    IF "%%i"=="CurrentVersion" (
        SET "CurrentSdkVersion=%%k"
    )
)
IF "%CurrentSdkVersion%"=="" EXIT /B 1
EXIT /B 0

:: -------------------------------------------------------------------
:: Clean up
:: -------------------------------------------------------------------
:CleanUp
SET OSLibraries=
SET OSIncludes=
SET VSRoot=
SET VCRoot_Orig=
SET VSRoot_Orig=
SET VCTools=
SET VSTools=
SET VCLibraries=
SET VCIncludes=
SET TARGET_PLATFORM=
SET TARGET_DEBUGTYPE=
SET CURRENT_CPU=
SET TARGET_CPU=
SET CurrentSdkVersion=
