indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyDescriptionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_DESCRIPTION_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_description_attribute

feature {NONE} -- Initialization

	frozen make_assembly_description_attribute (description: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyDescriptionAttribute"
		end

feature -- Access

	frozen get_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyDescriptionAttribute"
		alias
			"get_Description"
		end

end -- class ASSEMBLY_DESCRIPTION_ATTRIBUTE
