indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IAppDomainSetup"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IAPP_DOMAIN_SETUP

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_application_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_ApplicationName"
		end

	get_private_bin_path_probe: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_PrivateBinPathProbe"
		end

	get_shadow_copy_files: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_ShadowCopyFiles"
		end

	get_configuration_file: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_ConfigurationFile"
		end

	get_cache_path: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_CachePath"
		end

	get_private_bin_path: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_PrivateBinPath"
		end

	get_license_file: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_LicenseFile"
		end

	get_shadow_copy_directories: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_ShadowCopyDirectories"
		end

	get_application_base: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_ApplicationBase"
		end

	get_dynamic_base: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_DynamicBase"
		end

feature -- Element Change

	set_application_base (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_ApplicationBase"
		end

	set_application_name (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_ApplicationName"
		end

	set_private_bin_path (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_PrivateBinPath"
		end

	set_shadow_copy_files (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_ShadowCopyFiles"
		end

	set_cache_path (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_CachePath"
		end

	set_configuration_file (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_ConfigurationFile"
		end

	set_private_bin_path_probe (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_PrivateBinPathProbe"
		end

	set_license_file (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_LicenseFile"
		end

	set_dynamic_base (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_DynamicBase"
		end

	set_shadow_copy_directories (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_ShadowCopyDirectories"
		end

end -- class IAPP_DOMAIN_SETUP
