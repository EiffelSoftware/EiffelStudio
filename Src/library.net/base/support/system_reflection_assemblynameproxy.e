indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.AssemblyNameProxy"

external class
	SYSTEM_REFLECTION_ASSEMBLYNAMEPROXY

inherit
	SYSTEM_MARSHALBYREFOBJECT

create
	make_assembly_name_proxy

feature {NONE} -- Initialization

	frozen make_assembly_name_proxy is
		external
			"IL creator use System.Reflection.AssemblyNameProxy"
		end

feature -- Basic Operations

	frozen get_assembly_name (assemblyFile: STRING): SYSTEM_REFLECTION_ASSEMBLYNAME is
		external
			"IL signature (System.String): System.Reflection.AssemblyName use System.Reflection.AssemblyNameProxy"
		alias
			"GetAssemblyName"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYNAMEPROXY
