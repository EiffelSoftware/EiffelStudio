@ECHO OFF
REM This script will register all assemblies that need to be registered in the GAC
REM and copy all the Win32 dlls in the c:\windows\system32 directory

IF EXIST "%VS71COMNTOOLS%vsvars32.bat" CALL "%VS71COMNTOOLS%vsvars32.bat"
IF EXIST "%VS71COMNTOOLS%vsvars32.bat" GOTO SETUP
IF EXIST "%VSCOMNTOOLS%vsvars32.bat" CALL "%VSCOMNTOOLS%vsvars32.bat"
IF EXIST "%VSCOMNTOOLS%vsvars32.bat" GOTO SETUP

ECHO Could not find VisualStudio installation, giving up...
GOTO END

:SETUP
@ECHO ON
gacutil -if provider\EIFGEN\W_code\Assemblies\EiffelSoftware.CodeDomBase.dll
gacutil -if provider\EIFGEN\W_code\Assemblies\EiffelSoftware.CodeDomVision2.dll
gacutil -if provider\EIFGEN\W_code\EiffelSoftware.CodedomSerializer.dll
COPY /Y provider\EIFGEN\W_code\Assemblies\libEiffelSoftware.CodeDomBase.dll c:\windows\system32
COPY /Y provider\EIFGEN\W_code\Assemblies\libEiffelSoftware.CodeDomVision2.dll c:\windows\system32

:END
@ECHO Done.