REM Make sure emitter.exe is in current folder!
cd code_generator_generated
del *.dll
copy ..\..\bin\ISE.Reflection.CodeGenerator.dll .
del *.e
..\emitter /t ISE.Reflection.CodeGenerator.dll
cd ..\eiffel_assembly_cache_generated
del *.dll
copy ..\..\bin\ISE.Reflection.AssemblyCacheHandler.dll .
del *.e
..\emitter /t ISE.Reflection.AssemblyCacheHandler.dll
cd ..\eiffel_components_generated
del *.dll
copy ..\..\bin\ISE.Reflection.EiffelComponents.dll .
del *.e
..\emitter /t ISE.Reflection.EiffelComponents.dll
cd ..\new_emitter_generated
del *.exe
copy ..\..\bin\ISE.Reflection.Emitter.exe .
del *.e
..\emitter /t ISE.Reflection.Emitter.exe
cd ..\notifier_generated
del *.dll
copy ..\..\bin\ISE.Reflection.AssemblyCacheNotifier.dll .
del *.e
..\emitter /t ISE.Reflection.AssemblyCacheNotifier.dll
cd ..\reflection_interface_generated
del *.dll
copy ..\..\bin\ISE.Reflection.ReflectionInterface.dll .
del *.e
..\emitter /t ISE.Reflection.ReflectionInterface.dll
cd ..\support_generated
del *.dll
copy ..\..\bin\ISE.Reflection.Support.dll .
del *.e
..\emitter /t ISE.Reflection.Support.dll

