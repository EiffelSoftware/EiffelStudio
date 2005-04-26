@ECHO OFF
REM *********************************************
REM Eiffel Codedom Provider delivery build script
REM *********************************************

CD checkout
REM in "checkout"
SET ISE_EIFFEL=%1
SET PATH=%INIT_PATH%;"%1\studio\spec\windows\bin"
ECHO Registering initial compiler's metadata consumer
regasm %ISE_EIFFEL%\studio\spec\windows\bin\EiffelSoftware.MetadataConsumer.dll

REM ECHO Compiling Compiler
CD Eiffel\ace
REM in "checkout\Eiffel\ace"
IF EXIST ecdpc.epr DEL ecdpc.epr
RD /q /s EIFGEN
sed -e "s/\"ec\"/\"ecdpc\"/" batch.mswin.ace > ecdpc.ace
ec -finalize -batch -c_compile -ace ecdpc.ace
IF NOT EXIST EIFGEN\F_Code\ecdpc.exe GOTO END

CD ..\..\
REM in "checkout"
IF EXIST c:\ecdpc RD /Q /S C:\ecdpc
IF EXIST C:\ecdpc ECHO Could not cleanup c:\ecpdc
IF EXIST C:\ecdpc GOTO END
MKDIR C:\ecdpc
COPY Eiffel\ace\EIFGEN\F_Code\ecdpc.exe C:\ecdpc
SET PATH=%PATH%;c:\ecdpc

ECHO Compiling Metadata consumer
CD dotnet\consumer\ace
REM in "checkout\dotnet\consumer\ace"
IF EXIST *.epr DEL *.epr
RD /q /s EIFGEN
ec -finalize -batch -c_compile -ace metadata_consumer.ace
IF NOT EXIST EIFGEN\F_code\EiffelSoftware.MetadataConsumer.dll GOTO END
COPY EIFGEN\F_code\EiffelSoftware.MetadataConsumer.dll c:\ecdpc

CD ..\..\..
REM in "checkout"
COPY %ISE_EIFFEL%\studio\spec\windows\bin\EiffelSoftware.Runtime.dll c:\ecdpc
ECHO Unregistering initial compiler's metadata consumer
regasm /unregister %ISE_EIFFEL%\studio\spec\windows\bin\EiffelSoftware.MetadataConsumer.dll
ECHO Registering metadata consumer compiled with initial compiler
regasm c:\ecdpc\EiffelSoftware.MetadataConsumer.dll

CD dotnet\consumer\ace
REM in "checkout\dotnet\consumer\ace"
DEL *.epr
RD /q /s EIFGEN
ecdpc -finalize -batch -c_compile -ace metadata_consumer.ace
IF NOT EXIST EIFGEN\F_code\EiffelSoftware.MetadataConsumer.dll GOTO END
ECHO Unregistering initial metadata consumer
regasm /unregister c:\ecdpc\EiffelSoftware.MetadataConsumer.dll
COPY /Y EIFGEN\F_code\EiffelSoftware.MetadataConsumer.dll c:\ecdpc
ECHO Compiling Runtime
CD ..\..\..\Eiffel\eiffel\com_il_generation\Core\run-time
REM in "checkout\Eiffel\eiffel\com_il_generation\Core\run-time"
CALL nmake
COPY /Y EiffelSoftware.Runtime.dll c:\ecdpc
CD ..\..\..\..\..
REM in "checkout"
ECHO Registering bootstrapped metadata consumer
regasm c:\ecdpc\EiffelSoftware.MetadataConsumer.dll
RD /Q /S %ISE_EIFFEL%\dotnet\assemblies

ECHO Setting up folders
CD ..\delivery
REM in "delivery"
MKDIR compiler
CD compiler
REM in "delivery\compiler"
MKDIR library\base
MKDIR library.net\base
MKDIR studio
MKDIR precomp
CD precomp
REM in "delivery\compiler\precomp"
COPY ..\..\..\checkout\precomp_delivery\spec\dotnet\base\ace.ace .
CD ..\studio
REM in "delivery\compiler\studio"
MKDIR "help\errors"
MKDIR spec\windows\bin
MKDIR config\windows\msc
MKDIR config\windows\templates

ECHO Copying delivery files
XCOPY /S ..\..\..\checkout\compiler_delivery\help\errors "help\errors"
COPY ..\..\..\checkout\Eiffel\ace\EIFGEN\F_Code\ecdpc.exe spec\windows\bin\
COPY ..\..\..\checkout\dotnet\consumer\ace\EIFGEN\F_Code\EiffelSoftware.MetadataConsumer.dll spec\windows\bin\
COPY ..\..\..\checkout\Eiffel\eiffel\com_il_generation\Core\run-time\EiffelSoftware.Runtime.dll spec\windows\bin\
XCOPY /S ..\..\..\checkout\compiler_delivery\config\windows\msc config\windows\msc
XCOPY /S ..\..\..\checkout\compiler_delivery\config\windows\templates config\windows\templates
CD ..\library
REM in "delivery\compiler\library"
XCOPY /S ..\..\..\checkout\library\base base\
CD ..\library.net
REM in "delivery\compiler\library.net"
XCOPY /S ..\..\..\checkout\library.net\base base\

CD ..\..\..
REM in "\"
SET COMPILER_BUILT=1
SET PATH=%INIT_PATH%

:END
IF "%COMPILER_BUILT%"=="" ECHO COULD NOT BUILD COMPILER FILES!!
ECHO Done.