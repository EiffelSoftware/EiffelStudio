indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.RuntimeEnvironment"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_RUNTIMEENVIRONMENT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.InteropServices.RuntimeEnvironment"
		end

feature -- Access

	frozen get_system_configuration_file: STRING is
		external
			"IL static signature (): System.String use System.Runtime.InteropServices.RuntimeEnvironment"
		alias
			"get_SystemConfigurationFile"
		end

feature -- Basic Operations

	frozen get_system_version: STRING is
		external
			"IL static signature (): System.String use System.Runtime.InteropServices.RuntimeEnvironment"
		alias
			"GetSystemVersion"
		end

	frozen from_global_access_cache (a: SYSTEM_REFLECTION_ASSEMBLY): BOOLEAN is
		external
			"IL static signature (System.Reflection.Assembly): System.Boolean use System.Runtime.InteropServices.RuntimeEnvironment"
		alias
			"FromGlobalAccessCache"
		end

	frozen get_runtime_directory: STRING is
		external
			"IL static signature (): System.String use System.Runtime.InteropServices.RuntimeEnvironment"
		alias
			"GetRuntimeDirectory"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_RUNTIMEENVIRONMENT
