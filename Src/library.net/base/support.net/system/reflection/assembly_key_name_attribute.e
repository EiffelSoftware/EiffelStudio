indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyKeyNameAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_KEY_NAME_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_key_name_attribute

feature {NONE} -- Initialization

	frozen make_assembly_key_name_attribute (key_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyKeyNameAttribute"
		end

feature -- Access

	frozen get_key_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyKeyNameAttribute"
		alias
			"get_KeyName"
		end

end -- class ASSEMBLY_KEY_NAME_ATTRIBUTE
