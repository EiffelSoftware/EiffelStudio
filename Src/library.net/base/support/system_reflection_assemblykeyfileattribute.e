indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.AssemblyKeyFileAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYKEYFILEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assembly_key_file_attribute

feature {NONE} -- Initialization

	frozen make_assembly_key_file_attribute (keyFile2: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyKeyFileAttribute"
		end

feature -- Access

	frozen get_key_file: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyKeyFileAttribute"
		alias
			"get_KeyFile"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYKEYFILEATTRIBUTE
