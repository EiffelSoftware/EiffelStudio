CORE_SRC = EiffelClass.cs EiffelMethod.cs Globals.cs core.cs core_assembly_info.cs custom_attribute_factory.cs icore.cs
RUNTIME_SRC = runtime.cs runtime_assembly_info.cs
CSFLAGS = -nologo
#CSFLAGS = -nologo -debug -d:DEBUG
GACFLAGS = -nologo
MKDIR = -mkdir
CP = -copy

all:: core.dll ise_runtime.dll

ise_runtime.dll: $(RUNTIME_SRC) makefile
	gacutil $(GACFLAGS) -u ise_runtime
	csc $(CSFLAGS) /t:library /out:$@ $(RUNTIME_SRC)
	gacutil $(GACFLAGS) -i ise_runtime.dll

core.dll: $(CORE_SRC) makefile ise_runtime.dll
	gacutil $(GACFLAGS) -u core
	csc $(CSFLAGS) /t:library /reference:"System.Web.Services.dll" /reference:"ise_runtime.dll" /out:$@ $(CORE_SRC)
	gacutil $(GACFLAGS) -i core.dll
	tlbexp -nologo core.dll
	regasm -nologo core.dll

generate_eiffel: core.idl
	$(MKDIR) ..\junk
	$(CP) core.idl ..\junk
	$(ISE_EIFFEL)\wizards\com\com_wizard_cmd.exe -new_com_project -com_file core.idl -in_process -destination $(EIFFEL_SRC)\Eiffel\eiffel\com_il_generation\junk
	$(CP) ..\junk\Client\Clib\*.cpp clib
	$(CP) ..\junk\Client\Include\*.h clib
	$(CP) ..\junk\Client\Component\*.e ..
	$(CP) ..\junk\Common\Include\ecom_core_icore.h clib
	$(CP) ..\junk\Common\Interfaces\*.e ..
	cd clib
	call make_msc.bat
