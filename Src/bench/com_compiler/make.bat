@REM First, compile IDL
@ECHO ***************************************
@ECHO Compling IDL
@ECHO ***************************************
CD idl
CALL make.bat
CD ..

@REM Then call EiffelCOM Wizard
IF "%1"=="/dll" GOTO DLLGEN

@ECHO ***************************************
@ECHO Generating EXE COM server files
@ECHO ***************************************
CALL generate_exe.bat
GOTO SETUP

:DLLGEN
@ECHO ***************************************
@ECHO Generating DLL COM server files
@ECHO ***************************************
CALL generate_dll.bat

@REM Setup generated files for compilation
:SETUP
@ECHO ***************************************
@ECHO Copying generated files
@ECHO ***************************************
DEL *.e
DEL Clib\*.cpp
DEL Clib\*.c
DEL Clib\*.h

COPY generated\Client\Interface_proxy .\
COPY generated\Server\Component .\
COPY generated\Server\Interface_stub .\
COPY generated\Common\Interfaces .\
COPY generated\Common\Structures .\
COPY generated\Client\Clib\*.cpp Clib
COPY generated\Client\Include Clib
COPY generated\Server\Clib\*.cpp Clib
COPY generated\Server\Include Clib
COPY generated\Common\Include Clib

@REM Rename and copy type library
IF "%1"=="/dll" GOTO DLLTLB

@ECHO ***************************************
@ECHO Generating EXE Type Library
@ECHO ***************************************
RENAME generated\EiffelSoftware.tlb cec.tlb
COPY generated\cec.tlb ace_file\.
COPY generated\cec.tlb .\
GOTO TOREPL

:DLLTLB
@ECHO ***************************************
@ECHO Generating DLL Type Library
@ECHO ***************************************
RENAME generated\EiffelSoftware.tlb EiffelSoftware.Compiler.tlb
COPY generated\EiffelSoftware.Compiler.tlb ace_file\.
COPY generated\EiffelSoftware.Compiler.tlb .\
COPY generated\server\eiffelsoftware.def ace_file\EiffelSoftware.Compiler.def

@REM Replace modified generated files
:TOREPL
@ECHO ***************************************
@ECHO Replacing common files
@ECHO ***************************************
COPY to_replace\common\*.e .\
COPY to_replace\common\*.cpp Clib
COPY to_replace\common\*.c Clib
COPY to_replace\common\*.h Clib

IF "%1"=="/dll" GOTO DLLTOREP

@ECHO ***************************************
@ECHO Replacing EXE files
@ECHO ***************************************
COPY to_replace\exe\*.e .\
COPY to_replace\exe\*.cpp Clib
COPY to_replace\exe\*.c Clib
COPY to_replace\exe\*.h Clib
GOTO CCOMP

:DLLTOREP
@ECHO ***************************************
@ECHO Replacing DLL files
@ECHO ***************************************
COPY to_replace\dll\*.e .\
COPY to_replace\dll\*.cpp Clib
COPY to_replace\dll\*.c Clib
COPY to_replace\dll\*.h Clib
COPY ace_file\cec.rc ace_file\EiffelSoftware.Compiler.rc
COPY ace_file\cec.ico ace_file\EiffelSoftware.Compiler.ico

@REM Finally, compile C Code
:CCOMP
@ECHO ***************************************
@ECHO Compiling C Code
@ECHO ***************************************
CD Clib
CALL make_msc.bat
CD..

@ECHO ***************************************
@ECHO Done.
@ECHO ***************************************
