indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyTitleAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYTITLEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assemblytitleattribute

feature {NONE} -- Initialization

	frozen make_assemblytitleattribute (title: STRING) is
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
