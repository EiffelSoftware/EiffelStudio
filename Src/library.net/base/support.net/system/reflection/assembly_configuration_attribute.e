indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyConfigurationAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_CONFIGURATION_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_configuration_attribute

feature {NONE} -- Initialization

	frozen make_assembly_configuration_attribute (configuration: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyConfigurationAttribute"
		end

feature -- Access

	frozen get_configuration: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyConfigurationAttribute"
		alias
			"get_Configuration"
		end

end -- class ASSEMBLY_CONFIGURATION_ATTRIBUTE
