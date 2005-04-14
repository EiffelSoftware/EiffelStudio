@ECHO OFF
REM *********************************************
REM Eiffel Codedom Provider delivery build script
REM *********************************************

ECHO Building Codedom files

SET EIFFEL_SRC=%CD%\checkout\head
SET ISE_EIFFEL=%1
SET PATH=%INIT_PATH%;"%1\studio\spec\windows\bin"

CD checkout\head\dotnet\codedom_provider
REM in checkout\head\dotnet\codedom_provider
CALL build_studio.bat /release
IF NOT EXIST build_studio GOTO END
IF NOT EXIST build_studio\EiffelSoftware.Codedom\EIFGEN\F_code\EiffelSoftware.Codedom.dll GOTO END
IF NOT EXIST build_studio\EiffelSoftware.CodeDom.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CodeDom.CacheBrowser.dll GOTO END
IF NOT EXIST build_studio\EiffelSoftware.CodeDom.Base\EIFGEN\F_code\EiffelSoftware.CodeDom.Base.dll GOTO END
IF NOT EXIST build_studio\EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code\EiffelSoftware.CodeDom.Vision2.dll GOTO END
IF NOT EXIST build_studio\EiffelSoftware.CodeDom.Splitter\EIFGEN\F_code\EiffelSoftware.CodeDom.Splitter.dll GOTO END
IF NOT EXIST build_studio\ecdpman\EIFGEN\F_code\ecdpman.exe GOTO END
IF NOT EXIST build_studio\esplitter\EIFGEN\F_code\esplitter.exe GOTO END
IF NOT EXIST build_studio\esplit\EIFGEN\F_code\esplit.exe GOTO END

ECHO Compiling Runtime
CD ..\..\run-time
REM in "checkout\head\run-time"
CALL nmake
IF NOT EXIST EiffelSoftware.Runtime.dll GOTO END

ECHO Copying files
CD ..\..\..\delivery
REM in delivery
MKDIR codedom
CD codedom
REM in delivery\codedom

MKDIR configs
COPY ..\..\default.ecd configs\

MKDIR bin
COPY ..\..\checkout\head\dotnet\codedom_provider\build_studio\EiffelSoftware.CodeDom.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CodeDom.CacheBrowser.dll bin\
COPY ..\..\checkout\head\dotnet\codedom_provider\build_studio\EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.Codedom.dll bin\
COPY ..\..\checkout\head\dotnet\codedom_provider\build_studio\EiffelSoftware.CodeDom.Base\EIFGEN\F_code\EiffelSoftware.CodeDom.Base.dll bin\
COPY ..\..\checkout\head\dotnet\codedom_provider\build_studio\EiffelSoftware.CodeDom.Base\EIFGEN\F_code\libEiffelSoftware.CodeDom.Base.dll bin\
COPY ..\..\checkout\head\dotnet\codedom_provider\build_studio\EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code\EiffelSoftware.CodeDom.Vision2.dll bin\
COPY ..\..\checkout\head\dotnet\codedom_provider\build_studio\EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code\libEiffelSoftware.CodeDom.Vision2.dll bin\
COPY ..\..\checkout\head\dotnet\codedom_provider\build_studio\EiffelSoftware.CodeDom.Splitter\EIFGEN\F_code\EiffelSoftware.CodeDom.Splitter.dll bin\
COPY ..\..\checkout\head\dotnet\codedom_provider\build_studio\ecdpman\EIFGEN\F_code\ecdpman.exe bin\
COPY ..\..\checkout\head\dotnet\codedom_provider\build_studio\esplitter\EIFGEN\F_code\esplitter.exe bin\
COPY ..\..\checkout\head\dotnet\codedom_provider\build_studio\esplit\EIFGEN\F_code\esplit.exe bin\
COPY ..\..\checkout\head\dotnet\codedom_provider\build_studio\nmap\EIFGEN\F_code\nmap.exe bin\
COPY ..\..\checkout\head\run-time\EiffelSoftware.Runtime.dll bin\

CD bin
REM in delivery\codedom\bin
MKDIR icons
CD icons
REM in delivery\codedom\bin\icons
XCOPY ..\..\..\..\checkout\head\dotnet\codedom_provider\tools\manager\icons /E
SET CODEDOM_BUILT=1

CD ..\..\..\..

:END
IF "%CODEDOM_BUILT%"=="" ECHO COULD NOT BUILD CODEDOM FILES!!
ECHO Done.