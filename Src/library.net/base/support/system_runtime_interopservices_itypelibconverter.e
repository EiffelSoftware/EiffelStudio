indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.ITypeLibConverter"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBCONVERTER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	convert_assembly_to_type_lib (assembly: SYSTEM_REFLECTION_ASSEMBLY; type_lib_name: STRING; flags: SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBEXPORTERFLAGS; notify_sink: SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBEXPORTERNOTIFYSINK): ANY is
		external
			"IL deferred signature (System.Reflection.Assembly, System.String, System.Runtime.InteropServices.TypeLibExporterFlags, System.Runtime.InteropServices.ITypeLibExporterNotifySink): System.Object use System.Runtime.InteropServices.ITypeLibConverter"
		alias
			"ConvertAssemblyToTypeLib"
		end

	convert_type_lib_to_assembly_object_string_type_lib_importer_flags (type_lib: ANY; asm_file_name: STRING; flags: SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBIMPORTERFLAGS; notify_sink: SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBIMPORTERNOTIFYSINK; public_key: ARRAY [INTEGER_8]; key_pair: SYSTEM_REFLECTION_STRONGNAMEKEYPAIR; asm_namespace: STRING; asm_version: SYSTEM_VERSION): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
		external
			"IL deferred signature (System.Object, System.String, System.Runtime.InteropServices.TypeLibImporterFlags, System.Runtime.InteropServices.ITypeLibImporterNotifySink, System.Byte[], System.Reflection.StrongNameKeyPair, System.String, System.Version): System.Reflection.Emit.AssemblyBuilder use System.Runtime.InteropServices.ITypeLibConverter"
		alias
			"ConvertTypeLibToAssembly"
		end

	convert_type_lib_to_assembly (type_lib: ANY; asm_file_name: STRING; flags: INTEGER; notify_sink: SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBIMPORTERNOTIFYSINK; public_key: ARRAY [INTEGER_8]; key_pair: SYSTEM_REFLECTION_STRONGNAMEKEYPAIR; unsafe_interfaces: BOOLEAN): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
		external
			"IL deferred signature (System.Object, System.String, System.Int32, System.Runtime.InteropServices.ITypeLibImporterNotifySink, System.Byte[], System.Reflection.StrongNameKeyPair, System.Boolean): System.Reflection.Emit.AssemblyBuilder use System.Runtime.InteropServices.ITypeLibConverter"
		alias
			"ConvertTypeLibToAssembly"
		end

	get_primary_interop_assembly (g: SYSTEM_GUID; major: INTEGER; minor: INTEGER; lcid: INTEGER; asm_name: STRING; asm_code_base: STRING): BOOLEAN is
		external
			"IL deferred signature (System.Guid, System.Int32, System.Int32, System.Int32, System.String&, System.String&): System.Boolean use System.Runtime.InteropServices.ITypeLibConverter"
		alias
			"GetPrimaryInteropAssembly"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBCONVERTER
