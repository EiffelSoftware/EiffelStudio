indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyDescriptionAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYDESCRIPTIONATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assemblydescriptionattribute

feature {NONE} -- Initialization

	frozen make_assemblydescriptionattribute (description: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyDescriptionAttribute"
		end

feature -- Access

	frozen get_description: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyDescriptionAttribute"
		alias
			"get_Description"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYDESCRIPTIONATTRIBUTE
