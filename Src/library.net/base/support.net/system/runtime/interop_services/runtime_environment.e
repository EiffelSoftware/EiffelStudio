indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.RuntimeEnvironment"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RUNTIME_ENVIRONMENT

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.InteropServices.RuntimeEnvironment"
		end

feature -- Access

	frozen get_system_configuration_file: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Runtime.InteropServices.RuntimeEnvironment"
		alias
			"get_SystemConfigurationFile"
		end

feature -- Basic Operations

	frozen get_system_version: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Runtime.InteropServices.RuntimeEnvironment"
		alias
			"GetSystemVersion"
		end

	frozen from_global_access_cache (a: ASSEMBLY): BOOLEAN is
		external
			"IL static signature (System.Reflection.Assembly): System.Boolean use System.Runtime.InteropServices.RuntimeEnvironment"
		alias
			"FromGlobalAccessCache"
		end

	frozen get_runtime_directory: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Runtime.InteropServices.RuntimeEnvironment"
		alias
			"GetRuntimeDirectory"
		end

end -- class RUNTIME_ENVIRONMENT
