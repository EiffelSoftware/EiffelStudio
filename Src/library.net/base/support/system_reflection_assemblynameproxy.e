indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyNameProxy"

external class
	SYSTEM_REFLECTION_ASSEMBLYNAMEPROXY

inherit
	SYSTEM_MARSHALBYREFOBJECT

create
	make_assemblynameproxy

feature {NONE} -- Initialization

	frozen make_assemblynameproxy is
		external
			"IL creator use System.Reflection.AssemblyNameProxy"
		end

feature -- Basic Operations

	frozen get_assembly_name (assembly_file: STRING): SYSTEM_REFLECTION_ASSEMBLYNAME is
		external
			"IL signature (System.String): System.Reflection.AssemblyName use System.Reflection.AssemblyNameProxy"
		alias
			"GetAssemblyName"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYNAMEPROXY
