indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.AssemblyKeyNameAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYKEYNAMEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assembly_key_name_attribute

feature {NONE} -- Initialization

	frozen make_assembly_key_name_attribute (keyName2: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyKeyNameAttribute"
		end

feature -- Access

	frozen get_key_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyKeyNameAttribute"
		alias
			"get_KeyName"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYKEYNAMEATTRIBUTE
