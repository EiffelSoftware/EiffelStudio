indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyInformationalVersionAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYINFORMATIONALVERSIONATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assemblyinformationalversionattribute

feature {NONE} -- Initialization

	frozen make_assemblyinformationalversionattribute (informational_version: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyInformationalVersionAttribute"
		end

feature -- Access

	frozen get_informational_version: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyInformationalVersionAttribute"
		alias
			"get_InformationalVersion"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYINFORMATIONALVERSIONATTRIBUTE
