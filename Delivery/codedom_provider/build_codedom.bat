@ECHO OFF
REM *********************************************
REM Eiffel Codedom Provider delivery build script
REM *********************************************

ECHO Building Codedom files

CD checkout\dotnet\codedom_provider\assemblies
IF NOT EXIST ..\..\..\com_compiler\ace_file\EIFGEN\F_code\EiffelSoftware.Compiler.dll GOTO END
COPY ..\..\..\com_compiler\ace_file\EIFGEN\F_code\EiffelSoftware.Compiler.dll .\
CALL make.bat
IF NOT EXIST output_processing\EiffelSoftware.Compiler.OutputDispatcher.dll GOTO END
COPY output_processing\EiffelSoftware.Compiler.OutputDispatcher.dll .
COPY output_processing\EiffelSoftware.Compiler.OutputHandler.dll .
CD..

CALL build_studio.bat /release
IF NOT EXIST build_studio GOTO END
IF NOT EXIST build_studio\EiffelSoftware.Codedom\EIFGEN\F_code\EiffelSoftware.Codedom.dll GOTO END
IF NOT EXIST build_studio\EiffelSoftware.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CacheBrowser.dll GOTO END
IF NOT EXIST build_studio\EiffelSoftware.EiffelBase\EIFGEN\F_code\EiffelSoftware.EiffelBase.dll GOTO END
IF NOT EXIST build_studio\EiffelSoftware.EiffelVision2\EIFGEN\F_code\EiffelSoftware.EiffelVision2.dll GOTO END

ECHO Copying files
CD ..\..\..\delivery
MKDIR codedom
CD codedom

MKDIR manager
CD manager
COPY ..\..\..\checkout\dotnet\codedom_provider\build_studio\ecdpman\EIFGEN\F_code\ecdpman.exe .
MKDIR icons
XCOPY ..\..\..\checkout\dotnet\codedom_provider\manager\icons icons\ /E

CD ..
MKDIR configs
COPY ..\..\default.ecd configs\

MKDIR bin
COPY ..\..\checkout\dotnet\codedom_provider\build_studio\EiffelSoftware.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CacheBrowser.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider\build_studio\EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.Codedom.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider\build_studio\EiffelSoftware.EiffelBase\EIFGEN\F_code\EiffelSoftware.EiffelBase.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider\build_studio\EiffelSoftware.EiffelBase\EIFGEN\F_code\libEiffelSoftware.EiffelBase.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider\build_studio\EiffelSoftware.EiffelVision2\EIFGEN\F_code\EiffelSoftware.EiffelVision2.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider\build_studio\EiffelSoftware.EiffelVision2\EIFGEN\F_code\libEiffelSoftware.EiffelVision2.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider\assemblies\EiffelSoftware.Compiler.Managed.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider\assemblies\output_processing\EiffelSoftware.Compiler.OutputDispatcher.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider\assemblies\output_processing\EiffelSoftware.Compiler.OutputHandler.dll bin\

SET CODEDOM_BUILT=1

:END
IF "%CODEDOM_BUILT%"=="" ECHO COULD NOT BUILD CODEDOM FILES!!
ECHO Done.