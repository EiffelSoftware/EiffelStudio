indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyKeyFileAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_KEY_FILE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_key_file_attribute

feature {NONE} -- Initialization

	frozen make_assembly_key_file_attribute (key_file: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyKeyFileAttribute"
		end

feature -- Access

	frozen get_key_file: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyKeyFileAttribute"
		alias
			"get_KeyFile"
		end

end -- class ASSEMBLY_KEY_FILE_ATTRIBUTE
