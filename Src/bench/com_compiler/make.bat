cd idl
call make.bat
cd ..

call generating.bat

del *.e

copy generated\Client\Interface_proxy .\

copy generated\Server\Component .\

copy generated\Server\Interface_stub .\

copy generated\Common\Interfaces .\

copy generated\Common\Structures .\

del Clib\*.cpp
del Clib\*.c
del Clib\*.h

copy generated\Client\Clib\*.cpp Clib

copy generated\Client\Include Clib

copy generated\Server\Clib\*.cpp Clib

copy generated\Server\Include Clib

copy generated\Common\Include Clib

rename generated\ISE.tlb cec.tlb

copy generated\cec.tlb ace_file\.

copy generated\cec.tlb .\

copy to_replace\*.e .\

copy to_replace\*.cpp Clib

copy to_replace\*.c Clib

copy to_replace\*.h Clib

cd Clib
call make_msc.bat
cd..