CORE_SRC = compiler.cs class.cs feature.cs compiler_proxy.cs core_assembly_info.cs custom_attribute_factory.cs compiler_proxy_i.cs feature_info.cs
RUNTIME_SRC = runtime.cs runtime_assembly_info.cs gen_conf.cs
CSFLAGS = -nologo -w:4 -optimize+
#CSFLAGS = -nologo -w:4 -debug -d:DEBUG
GACFLAGS = -nologo
#COM_WIZARD_FLAGS = -output_all
COM_WIZARD_FLAGS = -output_none
MKDIR = -mkdir
RMDIR = -rd /q /s
CP = -copy

all:: EiffelCompiler.dll ise_runtime.dll

ise_runtime.dll: $(RUNTIME_SRC) makefile
	gacutil $(GACFLAGS) -u ise_runtime
	csc $(CSFLAGS) /t:library /out:$@ $(RUNTIME_SRC)
	gacutil $(GACFLAGS) -i ise_runtime.dll

EiffelCompiler.dll: $(CORE_SRC) makefile ise_runtime.dll
	gacutil $(GACFLAGS) -u EiffelCompiler
	csc $(CSFLAGS) /t:library /reference:"System.Web.Services.dll" /reference:"ise_runtime.dll" /out:$@ $(CORE_SRC)
	gacutil $(GACFLAGS) -i $@
	tlbexp -nologo $@
	regasm -nologo $@

generate_eiffel: compiler.idl
	$(RMDIR) ..\junk
	$(MKDIR) ..\junk
	$(CP) compiler.idl ..\junk
	$(ISE_EIFFEL)\wizards\com\com_wizard_cmd.exe -new_com_project -com_file compiler.idl -in_process -destination $(EIFFEL_SRC)\Eiffel\eiffel\com_il_generation\junk $(COM_WIZARD_FLAGS)
	$(CP) ..\junk\Client\Clib\*.cpp clib
	$(CP) ..\junk\Client\Include\*.h clib
	$(CP) ..\junk\Client\Component\*.e ..
	$(CP) ..\junk\Common\Include\ecom_eiffelcompiler_compiler_proxy_i.h clib
	$(CP) ..\junk\Common\Interfaces\*.e ..
	cd clib
	call make_msc.bat
