call generating_client_only.bat

del *.e

copy generated\Client\Interface_proxy .\

copy generated\Client\Component .\

copy generated\Common\Interfaces .\

copy generated\Common\Structures .\

copy generated\Server\Interface_stub .\

del Clib\*.cpp
del Clib\*.c
del Clib\*.h

copy generated\Client\Clib\*.* Clib

copy generated\Client\Include Clib

copy generated\Common\Include Clib

copy generated\Server\Clib\*.* Clib

copy generated\Server\Include Clib

rename generated\ISE.tlb ISE.Compiler.tlb

copy generated\ISE.Compiler.tlb .\

copy to_replace\*.* Clib\

cd Clib
call make_msc.bat

cd ..
