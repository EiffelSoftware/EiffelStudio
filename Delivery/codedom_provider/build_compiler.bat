@ECHO OFF
REM *********************************************
REM Eiffel Codedom Provider delivery build script
REM *********************************************

CD checkout
REM in "checkout"

ECHO Compiling Compiler
CD Eiffel\ace
REM in "checkout\Eiffel\ace"
DEL *.epr
RD /q /s EIFGEN
sed -e "s/\"ec\"/\"ecdpc\"/" batch.mswin.ace > ecdpc.ace
REM Patch CL_TYPE_I to allow for alias clauses on class name
COPY /Y ..\..\..\cl_type_i.e ..\..\Eiffel\eiffel\genericity\
ec -finalize -batch -c_compile -ace ecdpc.ace
IF NOT EXIST EIFGEN\F_Code\ecdpc.exe GOTO END

ECHO Compiling Metadata consumer
CD ..\..\dotnet\consumer\ace
REM in "checkout\dotnet\consumer\ace"
DEL *.epr
RD /q /s EIFGEN
ec -finalize -batch -c_compile -ace metadata_consumer.ace
IF NOT EXIST EIFGEN\F_code\EiffelSoftware.MetadataConsumer.dll GOTO END
CD ..\..\..
REM in "checkout"

ECHO Compiling Runtime
CD Eiffel\eiffel\com_il_generation\Core\run-time
REM in "checkout\Eiffel\eiffel\com_il_generation\Core\run-time"
CALL nmake
IF NOT EXIST EiffelSoftware.Runtime.dll GOTO END
CD ..\..\..\..\..
REM in "checkout"

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

:END
IF "%COMPILER_BUILT%"=="" ECHO COULD NOT BUILD COMPILER FILES!!
ECHO Done.