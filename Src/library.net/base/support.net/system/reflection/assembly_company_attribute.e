indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyCompanyAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_COMPANY_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_company_attribute

feature {NONE} -- Initialization

	frozen make_assembly_company_attribute (company: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyCompanyAttribute"
		end

feature -- Access

	frozen get_company: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyCompanyAttribute"
		alias
			"get_Company"
		end

end -- class ASSEMBLY_COMPANY_ATTRIBUTE
