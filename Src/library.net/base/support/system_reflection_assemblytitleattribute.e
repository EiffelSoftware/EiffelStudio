indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.AssemblyTitleAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYTITLEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assembly_title_attribute

feature {NONE} -- Initialization

	frozen make_assembly_title_attribute (title2: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyTitleAttribute"
		end

feature -- Access

	frozen get_title: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyTitleAttribute"
		alias
			"get_Title"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYTITLEATTRIBUTE
