indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyConfigurationAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYCONFIGURATIONATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assemblyconfigurationattribute

feature {NONE} -- Initialization

	frozen make_assemblyconfigurationattribute (configuration: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyConfigurationAttribute"
		end

feature -- Access

	frozen get_configuration: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyConfigurationAttribute"
		alias
			"get_Configuration"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYCONFIGURATIONATTRIBUTE
