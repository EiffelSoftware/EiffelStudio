call generating.bat

del *.e

copy generated\Client\Interface_proxy .\

copy generated\Server\Component .\

copy generated\Server\Interface_stub .\

copy generated\Common\Interfaces .\

copy generated\Common\Structures .\

del Clib\*.cpp
del Clib\*.h

copy generated\Client\Clib\*.cpp Clib

copy generated\Client\Include Clib

copy generated\Server\Clib\*.cpp Clib

copy generated\Server\Include Clib

copy generated\Common\Include Clib

copy generated\Eif_compiler.tlb ace_file\.

copy generated\Eif_compiler.tlb .\

copy to_replace\*.e .\

copy to_replace\*.cpp Clib

cd Clib
call make_msc.bat

cd ..
