indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.AppDomainSetup"

frozen external class
	SYSTEM_APPDOMAINSETUP

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_IAPPDOMAINSETUP

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.AppDomainSetup"
		end

feature -- Access

	frozen get_application_base: STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_ApplicationBase"
		end

	frozen get_cache_path: STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_CachePath"
		end

	frozen get_private_bin_path_probe: STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_PrivateBinPathProbe"
		end

	frozen get_dynamic_base: STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_DynamicBase"
		end

	frozen get_shadow_copy_directories: STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_ShadowCopyDirectories"
		end

	frozen get_shadow_copy_files: STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_ShadowCopyFiles"
		end

	frozen get_private_bin_path: STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_PrivateBinPath"
		end

	frozen get_configuration_file: STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_ConfigurationFile"
		end

	frozen get_license_file: STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_LicenseFile"
		end

	frozen get_application_name: STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"get_ApplicationName"
		end

	frozen get_loader_optimization: INTEGER is
		external
			"IL signature (): enum System.LoaderOptimization use System.AppDomainSetup"
		alias
			"get_LoaderOptimization"
		ensure
			valid_loader_optimization: Result = 0 or Result = 1 or Result = 2 or Result = 3
		end

feature -- Element Change

	frozen set_private_bin_path_probe (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_PrivateBinPathProbe"
		end

	frozen set_private_bin_path (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_PrivateBinPath"
		end

	frozen set_license_file (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_LicenseFile"
		end

	frozen set_cache_path (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_CachePath"
		end

	frozen set_loader_optimization (value: INTEGER) is
			-- Valid values for `value' are:
			-- NotSpecified = 0
			-- SingleDomain = 1
			-- MultiDomain = 2
			-- MultiDomainHost = 3
		require
			valid_loader_optimization: value = 0 or value = 1 or value = 2 or value = 3
		external
			"IL signature (enum System.LoaderOptimization): System.Void use System.AppDomainSetup"
		alias
			"set_LoaderOptimization"
		end

	frozen set_dynamic_base (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_DynamicBase"
		end

	frozen set_shadow_copy_directories (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_ShadowCopyDirectories"
		end

	frozen set_shadow_copy_files (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_ShadowCopyFiles"
		end

	frozen set_application_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_ApplicationName"
		end

	frozen set_configuration_file (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_ConfigurationFile"
		end

	frozen set_application_base (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomainSetup"
		alias
			"set_ApplicationBase"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.AppDomainSetup"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.AppDomainSetup"
		alias
			"ToString"
		end

	frozen locate (s: STRING): INTEGER is
		external
			"IL static signature (System.String): System.Int32 use System.AppDomainSetup"
		alias
			"Locate"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_APPDOMAINSETUP
