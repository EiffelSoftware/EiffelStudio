indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyTitleAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_TITLE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_title_attribute

feature {NONE} -- Initialization

	frozen make_assembly_title_attribute (title: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyTitleAttribute"
		end

feature -- Access

	frozen get_title: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyTitleAttribute"
		alias
			"get_Title"
		end

end -- class ASSEMBLY_TITLE_ATTRIBUTE
