indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.TypeLibConverter"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBCONVERTER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBCONVERTER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.InteropServices.TypeLibConverter"
		end

feature -- Basic Operations

	frozen convert_type_lib_to_assembly (typeLib: ANY; asmFileName: STRING; flags: INTEGER; notifySink: SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBIMPORTERNOTIFYSINK; publicKey: ARRAY [INTEGER_8]; keyPair: SYSTEM_REFLECTION_STRONGNAMEKEYPAIR; unsafeInterfaces: BOOLEAN): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
		external
			"IL signature (System.Object, System.String, System.Int32, System.Runtime.InteropServices.ITypeLibImporterNotifySink, System.Byte[], System.Reflection.StrongNameKeyPair, System.Boolean): System.Reflection.Emit.AssemblyBuilder use System.Runtime.InteropServices.TypeLibConverter"
		alias
			"ConvertTypeLibToAssembly"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.TypeLibConverter"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.TypeLibConverter"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.InteropServices.TypeLibConverter"
		alias
			"Equals"
		end

	frozen convert_assembly_to_type_lib (assembly: SYSTEM_REFLECTION_ASSEMBLY; strTypeLibName: STRING; flags: INTEGER; notifySink: SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBEXPORTERNOTIFYSINK): ANY is
		external
			"IL signature (System.Reflection.Assembly, System.String, System.Int32, System.Runtime.InteropServices.ITypeLibExporterNotifySink): System.Object use System.Runtime.InteropServices.TypeLibConverter"
		alias
			"ConvertAssemblyToTypeLib"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.InteropServices.TypeLibConverter"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBCONVERTER
