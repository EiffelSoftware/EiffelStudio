indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.TypeLibConverter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	TYPE_LIB_CONVERTER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ITYPE_LIB_CONVERTER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.InteropServices.TypeLibConverter"
		end

feature -- Basic Operations

	frozen convert_assembly_to_type_lib (assembly: ASSEMBLY; str_type_lib_name: SYSTEM_STRING; flags: TYPE_LIB_EXPORTER_FLAGS; notify_sink: ITYPE_LIB_EXPORTER_NOTIFY_SINK): SYSTEM_OBJECT is
		external
			"IL signature (System.Reflection.Assembly, System.String, System.Runtime.InteropServices.TypeLibExporterFlags, System.Runtime.InteropServices.ITypeLibExporterNotifySink): System.Object use System.Runtime.InteropServices.TypeLibConverter"
		alias
			"ConvertAssemblyToTypeLib"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.TypeLibConverter"
		alias
			"ToString"
		end

	frozen convert_type_lib_to_assembly_object_string_type_lib_importer_flags (type_lib: SYSTEM_OBJECT; asm_file_name: SYSTEM_STRING; flags: TYPE_LIB_IMPORTER_FLAGS; notify_sink: ITYPE_LIB_IMPORTER_NOTIFY_SINK; public_key: NATIVE_ARRAY [INTEGER_8]; key_pair: STRONG_NAME_KEY_PAIR; asm_namespace: SYSTEM_STRING; asm_version: VERSION): ASSEMBLY_BUILDER is
		external
			"IL signature (System.Object, System.String, System.Runtime.InteropServices.TypeLibImporterFlags, System.Runtime.InteropServices.ITypeLibImporterNotifySink, System.Byte[], System.Reflection.StrongNameKeyPair, System.String, System.Version): System.Reflection.Emit.AssemblyBuilder use System.Runtime.InteropServices.TypeLibConverter"
		alias
			"ConvertTypeLibToAssembly"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.TypeLibConverter"
		alias
			"GetHashCode"
		end

	frozen convert_type_lib_to_assembly (type_lib: SYSTEM_OBJECT; asm_file_name: SYSTEM_STRING; flags: INTEGER; notify_sink: ITYPE_LIB_IMPORTER_NOTIFY_SINK; public_key: NATIVE_ARRAY [INTEGER_8]; key_pair: STRONG_NAME_KEY_PAIR; unsafe_interfaces: BOOLEAN): ASSEMBLY_BUILDER is
		external
			"IL signature (System.Object, System.String, System.Int32, System.Runtime.InteropServices.ITypeLibImporterNotifySink, System.Byte[], System.Reflection.StrongNameKeyPair, System.Boolean): System.Reflection.Emit.AssemblyBuilder use System.Runtime.InteropServices.TypeLibConverter"
		alias
			"ConvertTypeLibToAssembly"
		end

	frozen get_primary_interop_assembly (g: GUID; major: INTEGER; minor: INTEGER; lcid: INTEGER; asm_name: SYSTEM_STRING; asm_code_base: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.Guid, System.Int32, System.Int32, System.Int32, System.String&, System.String&): System.Boolean use System.Runtime.InteropServices.TypeLibConverter"
		alias
			"GetPrimaryInteropAssembly"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.InteropServices.TypeLibConverter"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.InteropServices.TypeLibConverter"
		alias
			"Finalize"
		end

end -- class TYPE_LIB_CONVERTER
