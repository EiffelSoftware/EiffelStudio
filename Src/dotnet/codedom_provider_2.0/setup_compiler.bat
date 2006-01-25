@ECHO OFF

@REM Compile and Tlbimp EiffelCom compiler

IF %ISE_EIFFEL% == "" ECHO ISE_EIFFEL is not defined !!
IF %ISE_EIFFEL% == "" GOTO END
SET PATH=%PATH%;%ISE_EIFFEL%\studio\spec\windows\bin

IF EXIST %EIFFEL_SRC%\com_compiler GOTO COMPILE
ECHO Could not fine %EIFFEL_SRC%\com_compiler !!
GOTO END

:COMPILE
IF EXIST compile_temp RD /Q /S compile_temp
MKDIR compile_temp
COPY %EIFFEL_SRC%\com_compiler\ace_file\cec.* compile_temp\
CD compile_temp\
ec -ace %EIFFEL_SRC%\com_compiler\ace_file\ace_final.ace -finalize -c_compile
CD ..
IF EXIST compile_temp\EIFGEN\F_code\cec.exe GOTO COPYCEC
ECHO Compilation failed !! (no cec.exe was generated in compile_temp\EIFGEN\F_Code)
GOTO END

:COPYCEC
IF EXIST assemblies RD /Q /S assemblies
MKDIR assemblies
COPY compile_temp\EIFGEN\F_Code\cec.exe assemblies
RD /Q /S compile_temp
IF EXIST "%VS71COMNTOOLS%vsvars32.bat" CALL "%VS71COMNTOOLS%vsvars32.bat"
IF EXIST "%VS71COMNTOOLS%vsvars32.bat" GOTO TLBIMP
IF EXIST "%VSCOMNTOOLS%vsvars32.bat" CALL "%VSCOMNTOOLS%vsvars32.bat"
IF EXIST "%VSCOMNTOOLS%vsvars32.bat" GOTO TLBIMP
ECHO Error: could not find Visual Studio installation...
GOTO END

:TLBIMP
CD assemblies
TlbImp cec.exe /out:EiffelSoftware.Compiler.dll /keyfile:%EIFFEL_SRC%\dotnet\helpers\isekey.snk /asmversion:5.5.0.0 /nologo
cec.exe /regserver
CD ..
IF EXIST compiler\EiffelSoftware.Compiler.dll GOTO END
ECHO TlbImp call failed !!

:END
ECHO Done setting up EiffelCom compiler.
