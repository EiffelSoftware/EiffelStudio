indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Microsoft.Win32.Registry"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	REGISTRY

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen current_config: REGISTRY_KEY is
		external
			"IL static_field signature :Microsoft.Win32.RegistryKey use Microsoft.Win32.Registry"
		alias
			"CurrentConfig"
		end

	frozen local_machine: REGISTRY_KEY is
		external
			"IL static_field signature :Microsoft.Win32.RegistryKey use Microsoft.Win32.Registry"
		alias
			"LocalMachine"
		end

	frozen performance_data: REGISTRY_KEY is
		external
			"IL static_field signature :Microsoft.Win32.RegistryKey use Microsoft.Win32.Registry"
		alias
			"PerformanceData"
		end

	frozen classes_root: REGISTRY_KEY is
		external
			"IL static_field signature :Microsoft.Win32.RegistryKey use Microsoft.Win32.Registry"
		alias
			"ClassesRoot"
		end

	frozen dyn_data: REGISTRY_KEY is
		external
			"IL static_field signature :Microsoft.Win32.RegistryKey use Microsoft.Win32.Registry"
		alias
			"DynData"
		end

	frozen current_user: REGISTRY_KEY is
		external
			"IL static_field signature :Microsoft.Win32.RegistryKey use Microsoft.Win32.Registry"
		alias
			"CurrentUser"
		end

	frozen users: REGISTRY_KEY is
		external
			"IL static_field signature :Microsoft.Win32.RegistryKey use Microsoft.Win32.Registry"
		alias
			"Users"
		end

end -- class REGISTRY
