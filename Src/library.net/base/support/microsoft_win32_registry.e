indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "Microsoft.Win32.Registry"

frozen external class
	MICROSOFT_WIN32_REGISTRY

create {NONE}

feature -- Access

	frozen users: MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL static_field signature :Microsoft.Win32.RegistryKey use Microsoft.Win32.Registry"
		alias
			"Users"
		end

	frozen performance_data: MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL static_field signature :Microsoft.Win32.RegistryKey use Microsoft.Win32.Registry"
		alias
			"PerformanceData"
		end

	frozen local_machine: MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL static_field signature :Microsoft.Win32.RegistryKey use Microsoft.Win32.Registry"
		alias
			"LocalMachine"
		end

	frozen classes_root: MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL static_field signature :Microsoft.Win32.RegistryKey use Microsoft.Win32.Registry"
		alias
			"ClassesRoot"
		end

	frozen current_config: MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL static_field signature :Microsoft.Win32.RegistryKey use Microsoft.Win32.Registry"
		alias
			"CurrentConfig"
		end

	frozen dyn_data: MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL static_field signature :Microsoft.Win32.RegistryKey use Microsoft.Win32.Registry"
		alias
			"DynData"
		end

	frozen current_user: MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL static_field signature :Microsoft.Win32.RegistryKey use Microsoft.Win32.Registry"
		alias
			"CurrentUser"
		end

end -- class MICROSOFT_WIN32_REGISTRY
