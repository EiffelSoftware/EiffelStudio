@ECHO OFF
REM *********************************************
REM Eiffel Codedom Provider delivery build script
REM *********************************************

ECHO Building Codedom files

CD checkout\dotnet\codedom_provider
REM in checkout\dotnet\codedom_provider
CALL build_studio.bat /release
IF NOT EXIST build_studio GOTO END
IF NOT EXIST build_studio\EiffelSoftware.Codedom\EIFGEN\F_code\EiffelSoftware.Codedom.dll GOTO END
IF NOT EXIST build_studio\EiffelSoftware.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CacheBrowser.dll GOTO END
IF NOT EXIST build_studio\EiffelSoftware.CodeDomBase\EIFGEN\F_code\EiffelSoftware.CodeDomBase.dll GOTO END
IF NOT EXIST build_studio\EiffelSoftware.CodeDomVision2\EIFGEN\F_code\EiffelSoftware.CodeDomVision2.dll GOTO END

ECHO Copying files
CD ..\..\..\delivery
REM in delivery
MKDIR codedom
CD codedom
REM in delivery\codedom

MKDIR manager
CD manager
REM in delivery\codedom\manager
COPY ..\..\..\checkout\dotnet\codedom_provider\build_studio\ecdpman\EIFGEN\F_code\ecdpman.exe .
MKDIR icons
XCOPY ..\..\..\checkout\dotnet\codedom_provider\manager\icons icons\ /E

CD ..
REM in delivery\codedom
MKDIR configs
COPY ..\..\default.ecd configs\

MKDIR bin
COPY ..\..\checkout\dotnet\codedom_provider\build_studio\EiffelSoftware.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CacheBrowser.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider\build_studio\EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.Codedom.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider\build_studio\EiffelSoftware.CodeDomBase\EIFGEN\F_code\EiffelSoftware.CodeDomBase.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider\build_studio\EiffelSoftware.CodeDomBase\EIFGEN\F_code\libEiffelSoftware.CodeDomBase.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider\build_studio\EiffelSoftware.CodeDomVision2\EIFGEN\F_code\EiffelSoftware.CodeDomVision2.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider\build_studio\EiffelSoftware.CodeDomVision2\EIFGEN\F_code\libEiffelSoftware.CodeDomVision2.dll bin\

SET CODEDOM_BUILT=1

CD ..\..

:END
IF "%CODEDOM_BUILT%"=="" ECHO COULD NOT BUILD CODEDOM FILES!!
ECHO Done.