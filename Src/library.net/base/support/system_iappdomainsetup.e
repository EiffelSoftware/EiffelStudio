indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IAppDomainSetup"

deferred external class
	SYSTEM_IAPPDOMAINSETUP

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_application_name: STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_ApplicationName"
		end

	get_private_bin_path_probe: STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_PrivateBinPathProbe"
		end

	get_shadow_copy_files: STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_ShadowCopyFiles"
		end

	get_configuration_file: STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_ConfigurationFile"
		end

	get_cache_path: STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_CachePath"
		end

	get_private_bin_path: STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_PrivateBinPath"
		end

	get_license_file: STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_LicenseFile"
		end

	get_shadow_copy_directories: STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_ShadowCopyDirectories"
		end

	get_application_base: STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_ApplicationBase"
		end

	get_dynamic_base: STRING is
		external
			"IL deferred signature (): System.String use System.IAppDomainSetup"
		alias
			"get_DynamicBase"
		end

feature -- Element Change

	set_application_base (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_ApplicationBase"
		end

	set_application_name (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_ApplicationName"
		end

	set_private_bin_path (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_PrivateBinPath"
		end

	set_shadow_copy_files (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_ShadowCopyFiles"
		end

	set_cache_path (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_CachePath"
		end

	set_configuration_file (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_ConfigurationFile"
		end

	set_private_bin_path_probe (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_PrivateBinPathProbe"
		end

	set_license_file (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_LicenseFile"
		end

	set_dynamic_base (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_DynamicBase"
		end

	set_shadow_copy_directories (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.IAppDomainSetup"
		alias
			"set_ShadowCopyDirectories"
		end

end -- class SYSTEM_IAPPDOMAINSETUP
