@echo off
@rem Creates necessary files to use ISE.Compiler.exe as .net assembly
@rem ESI.Compiler.exe must be compiled!

@rem create workbench version of the compiler

cd ace_file\EIFGEN\W_CODE
echo ### Creating Workbench Version ###
echo .
tlbimp /out:ISE.ComCompilerWrapper.dll /namespace:ISE.ComCompilerWrapper /asmversion:5.2.0.0 /keyfile:"%EIFFEL_SRC%\dotnet\helpers\isekey.snk" ISE.Compiler.exe /nologo
gacutil -if ISE.ComCompilerWrapper.dll /nologo
echo ### Workbench Version Created ###
cd ..\F_CODE
echo ### Creating Finalized Version ###
echo .
tlbimp /out:ISE.Final.ComCompilerWrapper.dll /namespace:ISE.ComCompilerWrapper /asmversion:5.2.0.0 /keyfile:"%EIFFEL_SRC%\dotnet\helpers\isekey.snk" ISE.Compiler.exe /nologo
gacutil -if ISE.Final.ComCompilerWrapper.dll /nologo
echo .
echo ### Finalized Version Created ###
cd ..\..\..

