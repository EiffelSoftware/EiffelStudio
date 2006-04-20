ECHO OFF

REM Builds and registers cec custom marshaller proxy stub

IF EXIST EiffelSoftware.CompilerPS.dll regsvr32 -s -u EiffelSoftware.CompilerPS.dll

IF EXIST EiffelSoftware.CompilerPS.h DEL EiffelSoftware.CompilerPS.h
IF EXIST EiffelSoftware.CompilerPS_data.c DEL EiffelSoftware.CompilerPS_data.c
IF EXIST EiffelSoftware.CompilerPS_proxy.c DEL EiffelSoftware.CompilerPS_proxy.c
IF EXIST EiffelSoftware.CompilerPS_iid.c DEL EiffelSoftware.CompilerPS_iid.c
IF EXIST EiffelSoftware.CompilerPS.tlb DEL EiffelSoftware.CompilerPS.tlb
IF EXIST *.obj DEL *.obj
IF EXIST *.pch DEL *.pch
IF EXIST *.lib DEL *.lib
IF EXIST *.exp DEL *.exp

CALL midl /h EiffelSoftware.CompilerPS.h /dlldata EiffelSoftware.CompilerPS_data.c /iid EiffelSoftware.CompilerPS_iid.c /proxy EiffelSoftware.CompilerPS_proxy.c EiffelSoftwareCompiler.idl
CALL nmake make_proxystub.msc

regsvr32 -s EiffelSoftware.CompilerPS.dll