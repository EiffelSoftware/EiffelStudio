indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyInformationalVersionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_INFORMATIONAL_VERSION_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_informational_version_attribute

feature {NONE} -- Initialization

	frozen make_assembly_informational_version_attribute (informational_version: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyInformationalVersionAttribute"
		end

feature -- Access

	frozen get_informational_version: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyInformationalVersionAttribute"
		alias
			"get_InformationalVersion"
		end

end -- class ASSEMBLY_INFORMATIONAL_VERSION_ATTRIBUTE
