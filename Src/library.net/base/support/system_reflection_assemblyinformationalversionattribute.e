indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.AssemblyInformationalVersionAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYINFORMATIONALVERSIONATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assembly_informational_version_attribute

feature {NONE} -- Initialization

	frozen make_assembly_informational_version_attribute (informationalVersion2: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyInformationalVersionAttribute"
		end

feature -- Access

	frozen get_informationalversion: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyInformationalVersionAttribute"
		alias
			"get_InformationalVersion"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYINFORMATIONALVERSIONATTRIBUTE
