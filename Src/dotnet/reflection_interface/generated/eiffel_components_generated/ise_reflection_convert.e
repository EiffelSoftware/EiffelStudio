indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "ISE.Reflection.Convert"

external class
	ISE_REFLECTION_CONVERT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use ISE.Reflection.Convert"
		end

feature -- Basic Operations

	AssemblyInfoFromName (an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME): ARRAY [STRING] is
		external
			"IL signature (System.Reflection.AssemblyName): System.String[] use ISE.Reflection.Convert"
		alias
			"AssemblyInfoFromName"
		end

	NeutralCulture: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Convert"
		alias
			"NeutralCulture"
		end

	DecodeKey (a_key: ARRAY [INTEGER_8]): STRING is
		external
			"IL signature (System.Byte[]): System.String use ISE.Reflection.Convert"
		alias
			"DecodeKey"
		end

end -- class ISE_REFLECTION_CONVERT
