indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	convert_type_lib_to_assembly (typelib: ANY; asmFileName: STRING; flags: INTEGER; notifySink: SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBIMPORTERNOTIFYSINK; publicKey: ARRAY [INTEGER_8]; keyPair: SYSTEM_REFLECTION_STRONGNAMEKEYPAIR; unsafeInterfaces: BOOLEAN): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
		external
			"IL deferred signature (System.Object, System.String, System.Int32, System.Runtime.InteropServices.ITypeLibImporterNotifySink, System.Byte[], System.Reflection.StrongNameKeyPair, System.Boolean): System.Reflection.Emit.AssemblyBuilder use System.Runtime.InteropServices.ITypeLibConverter"
		alias
			"ConvertTypeLibToAssembly"
		end

	convert_assembly_to_type_lib (assembly: SYSTEM_REFLECTION_ASSEMBLY; typeLibName: STRING; flags: INTEGER; notifySink: SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBEXPORTERNOTIFYSINK): ANY is
		external
			"IL deferred signature (System.Reflection.Assembly, System.String, System.Int32, System.Runtime.InteropServices.ITypeLibExporterNotifySink): System.Object use System.Runtime.InteropServices.ITypeLibConverter"
		alias
			"ConvertAssemblyToTypeLib"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBCONVERTER
