indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.AppDomainSetup"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	APP_DOMAIN_SETUP

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IAPP_DOMAIN_SETUP

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.AppDomainSetup"
		end

feature -- Access

	frozen get_application_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_ApplicationName"
		end

	frozen get_private_bin_path_probe: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_PrivateBinPathProbe"
		end

	frozen get_shadow_copy_files: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_ShadowCopyFiles"
		end

	frozen get_configuration_file: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_ConfigurationFile"
		end

	frozen get_cache_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_CachePath"
		end

	frozen get_private_bin_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_PrivateBinPath"
		end

	frozen get_license_file: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_LicenseFile"
		end

	frozen get_loader_optimization: LOADER_OPTIMIZATION is
		external
			"IL signature (): System.LoaderOptimization use System.AppDomainSetup"
		alias
			"get_LoaderOptimization"
		end

	frozen get_shadow_copy_directories: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_ShadowCopyDirectories"
		end

	frozen get_application_base: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_ApplicationBase"
		end

	frozen get_dynamic_base: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_DynamicBase"
		end

	frozen get_disallow_publisher_policy: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.AppDomainSetup"
		alias
			"get_DisallowPublisherPolicy"
		end

feature -- Element Change

	frozen set_application_base (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_ApplicationBase"
		end

	frozen set_application_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_ApplicationName"
		end

	frozen set_private_bin_path (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_PrivateBinPath"
		end

	frozen set_loader_optimization (value: LOADER_OPTIMIZATION) is
		external
			"IL signature (System.LoaderOptimization): System.Void use System.AppDomainSetup"
		alias
			"set_LoaderOptimization"
		end

	frozen set_shadow_copy_files (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_ShadowCopyFiles"
		end

	frozen set_disallow_publisher_policy (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.AppDomainSetup"
		alias
			"set_DisallowPublisherPolicy"
		end

	frozen set_cache_path (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_CachePath"
		end

	frozen set_configuration_file (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_ConfigurationFile"
		end

	frozen set_private_bin_path_probe (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_PrivateBinPathProbe"
		end

	frozen set_license_file (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_LicenseFile"
		end

	frozen set_dynamic_base (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_DynamicBase"
		end

	frozen set_shadow_copy_directories (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_ShadowCopyDirectories"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.AppDomainSetup"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.AppDomainSetup"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.AppDomainSetup"
		alias
			"Finalize"
		end

end -- class APP_DOMAIN_SETUP
