@ECHO OFF
REM Compile Eiffel for ASP.NET Wix project and produce msi

IF "%1"=="" GOTO USAGE
IF "%2"=="" GOTO USAGE
SET SomeSpaceCharacter= 
SET MMSUCCESS=

IF "%3"=="" GOTO DOCANDLE
candle -nologo %3.wxs
IF NOT EXIST %3.wixobj ECHO Could not compile %3.wxs, exiting.
IF NOT EXIST %3.wixobj GOTO END

:DOCANDLE
candle -nologo %1.wxs
IF NOT EXIST %1.wixobj ECHO Could not compile %1.wxs, exiting.
IF NOT EXIST %1.wixobj GOTO END


IF "%3"=="" light -nologo -b %2  -out Modules\%1.msm %1.wixobj c:\dev\wix\ca\sca.wixlib
IF NOT "%3"=="" light -nologo -b %2  -out Modules\%1.msm %1.wixobj %3.wixobj c:\dev\wix\ca\sca.wixlib
IF NOT EXIST Modules\%1.msm ECHO Could not compile %1.wixobj, exiting.
IF NOT EXIST Modules\%1.msm GOTO END
DEL *.wixobj
SET MMSUCCESS=1

GOTO END

USAGE:
ECHO make_module <PATH_TO_WXS> <PATH_TO_FILES> [PATH_TO_FRAGMENT_WXS]
ECHO %SomeSpaceCharacter%
ECHO <PATH_TO_WXS>: Path to module wix definition (.wxs) WITHOUT .wxs extension
ECHO <PATH_TO_FILES>: Path to module files (used with light /b option)
ECHO <PATH_TO_FRAGMENT_WXS>: Path to fragment wix definition (.wxs) WITHOUT .wxs extension (optional)
ECHO Set environment variable MMSUCESS with 1 if successful, otherwise MMSUCESS is not set.

:END
