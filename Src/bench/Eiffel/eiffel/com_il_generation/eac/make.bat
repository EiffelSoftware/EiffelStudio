del *.e
rd /q /s clib
mkdir clib
copy %GENERATED%\Client\Component\*.e .
copy %GENERATED%\Client\Interface_proxy\*.e .
copy %GENERATED%\Common\Interfaces\*.e .
copy %GENERATED%\Common\Include\*.h clib
copy %GENERATED%\Client\Include\*.h clib
copy %GENERATED%\Client\Clib\*.* clib
cd clib
REM Change Ox to Zi if needed
REM Change 3 first includes to "."
call vi makefile.msc
call make_msc.bat
cd ..
