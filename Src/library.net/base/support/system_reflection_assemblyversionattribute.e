indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyVersionAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYVERSIONATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assemblyversionattribute

feature {NONE} -- Initialization

	frozen make_assemblyversionattribute (version: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyVersionAttribute"
		end

feature -- Access

	frozen get_version: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyVersionAttribute"
		alias
			"get_Version"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYVERSIONATTRIBUTE
