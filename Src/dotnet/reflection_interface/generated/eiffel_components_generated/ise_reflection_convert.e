indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.Convert"
	assembly: "ISE.Reflection.EiffelComponents", "0.0.0.0", "neutral", "e0f9d13739fa815f"

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

	empty_string: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Convert"
		alias
			"EmptyString"
		end

	decode_key (a_key: ARRAY [INTEGER_8]): STRING is
		external
			"IL signature (System.Byte[]): System.String use ISE.Reflection.Convert"
		alias
			"DecodeKey"
		end

	assembly_info_from_name (an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME): ARRAY [ANY] is
		external
			"IL signature (System.Reflection.AssemblyName): System.Object[] use ISE.Reflection.Convert"
		alias
			"AssemblyInfoFromName"
		end

	neutral_culture: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Convert"
		alias
			"NeutralCulture"
		end

end -- class ISE_REFLECTION_CONVERT
