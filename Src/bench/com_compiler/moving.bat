if exist generated rd /q /s generated

mkdir generated

$(ISE_EIFFEL)\wizards\com\com_wizard_cmd.exe -new_com_project -com_file idl\Eif_compiler.idl -destination generated -server -server -output_none -not_spawn_ebench

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

copy generated\Eif_compiler.tlb .\

copy to_replace\*.e .\

copy to_replace\*.cpp Clib

call Clib\make_msc.bat
