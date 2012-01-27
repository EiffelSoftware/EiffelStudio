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
IF EXIST %SystemRoot%\system32\libEiffelSoftware.MetadataConsumer.dll.bak COPY /Y %SystemRoot%\system32\libEiffelSoftware.MetadataConsumer.dll.bak %SystemRoot%\system32\libEiffelSoftware.MetadataConsumer.dll


REM ECHO Compiling Compiler
CD Eiffel\ace
REM in "checkout\Eiffel\ace"
IF EXIST ecdpc.epr DEL ecdpc.epr
RD /q /s EIFGENs
ECHO Compiling ecdpc
TITLE Compiling ecdpc
ec -finalize -batch -c_compile -config ec.ecf -target ecdpc
IF NOT EXIST EIFGENs\ecdpc\F_Code\ecdpc.exe GOTO END

CD ..\..\
REM in "checkout"
IF EXIST c:\ecdpc RD /Q /S C:\ecdpc
IF EXIST C:\ecdpc ECHO Could not cleanup c:\ecpdc, exiting.
IF EXIST C:\ecdpc GOTO END
MKDIR C:\ecdpc
COPY Eiffel\ace\EIFGENs\ecdpc\F_Code\ecdpc.exe C:\ecdpc
SET PATH=%PATH%;c:\ecdpc

ECHO Compiling Metadata consumer
CD dotnet\consumer
REM in "checkout\dotnet\consumer"
IF EXIST *.epr DEL *.epr
RD /q /s EIFGENs
ECHO Compiling Consumer
TITLE Compiling Consumer
ec -finalize -batch -c_compile -config consumer.ecf -target consumer_20
IF NOT EXIST EIFGENs\consumer_20\F_code\EiffelSoftware.MetadataConsumer.dll GOTO END
COPY EIFGENs\consumer_20\F_code\EiffelSoftware.MetadataConsumer.dll c:\ecdpc
COPY EIFGENs\consumer_20\F_code\libEiffelSoftware.MetadataConsumer.dll c:\ecdpc

CD ..\..
REM in "checkout"
COPY %ISE_EIFFEL%\studio\spec\windows\lib\EiffelSoftware.Runtime.dll c:\ecdpc
ECHO Unregistering initial compiler's metadata consumer
regasm /unregister %ISE_EIFFEL%\studio\spec\windows\bin\EiffelSoftware.MetadataConsumer.dll
ECHO Registering metadata consumer compiled with initial compiler
TITLE Registering metadata consumer compiled with initial compiler
regasm c:\ecdpc\EiffelSoftware.MetadataConsumer.dll
COPY /Y %SystemRoot%\system32\libEiffelSoftware.MetadataConsumer.dll %SystemRoot%\system32\libEiffelSoftware.MetadataConsumer.dll.bak
COPY /Y c:\ecdpc\libEiffelSoftware.MetadataConsumer.dll %SystemRoot%\system32\libEiffelSoftware.MetadataConsumer.dll

CD dotnet\consumer
REM in "checkout\dotnet\consumer"
DEL *.epr
RD /q /s EIFGENs
ECHO Compiling Consumer
TITLE Compiling Consumer
ecdpc -finalize -batch -c_compile -config consumer.ecf -target consumer_20
IF NOT EXIST EIFGENs\consumer_20\F_code\EiffelSoftware.MetadataConsumer.dll GOTO END
ECHO Unregistering non-bootstrapped metadata consumer
TITLE Unregistering non-bootstrapped metadata consumer
regasm /unregister c:\ecdpc\EiffelSoftware.MetadataConsumer.dll
COPY /Y EIFGENs\consumer_20\F_code\EiffelSoftware.MetadataConsumer.dll c:\ecdpc
COPY /Y EIFGENs\consumer_20\F_code\libEiffelSoftware.MetadataConsumer.dll c:\ecdpc
ECHO Compiling Runtime
TITLE Compiling Runtime
CD ..\..\Eiffel\eiffel\com_il_generation\Core\run-time
REM in "checkout\Eiffel\eiffel\com_il_generation\Core\run-time"
CALL nmake
COPY /Y EiffelSoftware.Runtime.dll c:\ecdpc
CD ..\..\..\..\..
REM in "checkout"
ECHO Registering bootstrapped metadata consumer
TITLE Registering bootstrapped metadata consumer
regasm c:\ecdpc\EiffelSoftware.MetadataConsumer.dll
COPY /Y c:\ecdpc\libEiffelSoftware.MetadataConsumer.dll %SystemRoot%\system32\libEiffelSoftware.MetadataConsumer.dll
RD /Q /S %ISE_EIFFEL%\dotnet\assemblies

ECHO Setting up folders
TITLE Setting up folders
CD ..\delivery
REM in "delivery"
MKDIR compiler
CD compiler
REM in "delivery\compiler"
MKDIR eifinit
MKDIR eifinit\studio
MKDIR library\base
MKDIR studio
MKDIR precomp
CD precomp
REM in "delivery\compiler\precomp"
COPY ..\..\..\files\base.ecf .
CD ..\studio
REM in "delivery\compiler\studio"
MKDIR "help\errors"
MKDIR spec\windows\bin
MKDIR config\windows\msc
MKDIR config\windows\templates

ECHO Copying delivery files
TITLE Copying delivery files
XCOPY /S ..\..\..\checkout\compiler_delivery\help\errors "help\errors"
COPY ..\..\..\checkout\Eiffel\ace\EIFGENs\ecdpc\F_Code\ecdpc.exe spec\windows\bin\
COPY ..\..\..\checkout\dotnet\consumer\EIFGENs\consumer_20\F_Code\EiffelSoftware.MetadataConsumer.dll spec\windows\bin\
COPY ..\..\..\checkout\dotnet\consumer\EIFGENs\consumer_20\F_Code\libEiffelSoftware.MetadataConsumer.dll spec\windows\bin\
COPY ..\..\..\checkout\Eiffel\eiffel\com_il_generation\Core\run-time\EiffelSoftware.Runtime.dll spec\windows\bin\
XCOPY /S ..\..\..\checkout\compiler_delivery\config\windows\msc config\windows\msc
XCOPY /S ..\..\..\checkout\compiler_delivery\config\windows\templates config\windows\templates
CD ..\eifinit
REM in "delivery\compiler\eifinit"
XCOPY /S ..\..\..\checkout\eifinit_delivery\studio studio\
CD ..\library
REM in "delivery\compiler\library"
XCOPY /S ..\..\..\checkout\library\base base\

CD ..\..\..
REM in "\"
SET COMPILER_BUILT=1
SET PATH=%INIT_PATH%

:END
IF "%COMPILER_BUILT%"=="" ECHO COULD NOT BUILD COMPILER FILES!!
ECHO Done.
TITLE Done.
