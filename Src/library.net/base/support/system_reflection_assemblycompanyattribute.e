indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyCompanyAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYCOMPANYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assemblycompanyattribute

feature {NONE} -- Initialization

	frozen make_assemblycompanyattribute (company: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyCompanyAttribute"
		end

feature -- Access

	frozen get_company: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyCompanyAttribute"
		alias
			"get_Company"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYCOMPANYATTRIBUTE
