indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyNameProxy"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ASSEMBLY_NAME_PROXY

inherit
	MARSHAL_BY_REF_OBJECT

create
	make_assembly_name_proxy

feature {NONE} -- Initialization

	frozen make_assembly_name_proxy is
		external
			"IL creator use System.Reflection.AssemblyNameProxy"
		end

feature -- Basic Operations

	frozen get_assembly_name (assembly_file: SYSTEM_STRING): ASSEMBLY_NAME is
		external
			"IL signature (System.String): System.Reflection.AssemblyName use System.Reflection.AssemblyNameProxy"
		alias
			"GetAssemblyName"
		end

end -- class ASSEMBLY_NAME_PROXY
