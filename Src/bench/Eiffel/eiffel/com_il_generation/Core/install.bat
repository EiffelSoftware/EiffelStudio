rem Copy client code
copy ..\junk\Client\Clib\*.cpp ..\clib
copy ..\junk\Client\Component\*.e ..
copy ..\junk\Client\Include\*.h ..\clib

rem Copy common code
copy ..\junk\Common\Interfaces\*.e ..
copy ..\junk\Common\Include\ecom__core.h ..\clib

rem Compile C code
cd ..\clib
call make_msc.bat
cd ..\Core
