ECHO OFF

REM Builds and registers cec custom marshaller proxy stub

IF EXIST ISE.CompilerPS.dll regsvr32 -s -u ISE.CompilerPS.dll

IF EXIST ISE.CompilerPS.h DEL ISE.CompilerPS.h
IF EXIST ISE.CompilerPS_data.c DEL ISE.CompilerPS_data.c
IF EXIST ISE.CompilerPS_proxy.c DEL ISE.CompilerPS_proxy.c
IF EXIST ISE.CompilerPS_iid.c DEL ISE.CompilerPS_iid.c
IF EXIST ISE.CompilerPS.tlb DEL ISE.CompilerPS.tlb
IF EXIST *.obj DEL *.obj
IF EXIST *.pch DEL *.pch
IF EXIST *.lib DEL *.lib
IF EXIST *.exp DEL *.exp

CALL midl /h ISE.CompilerPS.h /dlldata ISE.CompilerPS_data.c /iid ISE.CompilerPS_iid.c /proxy ISE.CompilerPS_proxy.c ISE.Compiler.idl
CALL nmake make_proxystub.msc

regsvr32 -s ISE.CompilerPS.dll