indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Microsoft.Win32.RegistryHive"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	REGISTRY_HIVE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen performance_data: REGISTRY_HIVE is
		external
			"IL enum signature :Microsoft.Win32.RegistryHive use Microsoft.Win32.RegistryHive"
		alias
			"-2147483644"
		end

	frozen current_user: REGISTRY_HIVE is
		external
			"IL enum signature :Microsoft.Win32.RegistryHive use Microsoft.Win32.RegistryHive"
		alias
			"-2147483647"
		end

	frozen local_machine: REGISTRY_HIVE is
		external
			"IL enum signature :Microsoft.Win32.RegistryHive use Microsoft.Win32.RegistryHive"
		alias
			"-2147483646"
		end

	frozen dyn_data: REGISTRY_HIVE is
		external
			"IL enum signature :Microsoft.Win32.RegistryHive use Microsoft.Win32.RegistryHive"
		alias
			"-2147483642"
		end

	frozen current_config: REGISTRY_HIVE is
		external
			"IL enum signature :Microsoft.Win32.RegistryHive use Microsoft.Win32.RegistryHive"
		alias
			"-2147483643"
		end

	frozen users: REGISTRY_HIVE is
		external
			"IL enum signature :Microsoft.Win32.RegistryHive use Microsoft.Win32.RegistryHive"
		alias
			"-2147483645"
		end

	frozen classes_root: REGISTRY_HIVE is
		external
			"IL enum signature :Microsoft.Win32.RegistryHive use Microsoft.Win32.RegistryHive"
		alias
			"-2147483648"
		end

end -- class REGISTRY_HIVE
