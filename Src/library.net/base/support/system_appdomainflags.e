indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.AppDomainFlags"

frozen external class
	SYSTEM_APPDOMAINFLAGS

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.AppDomainFlags"
		end

feature -- Access

	frozen global_assemblies: STRING is
		external
			"IL static_field signature :System.String use System.AppDomainFlags"
		alias
			"GlobalAssemblies"
		end

	frozen private_bin_path_probe: STRING is
		external
			"IL static_field signature :System.String use System.AppDomainFlags"
		alias
			"PrivateBinPathProbe"
		end

	frozen dynamic_base: STRING is
		external
			"IL static_field signature :System.String use System.AppDomainFlags"
		alias
			"DynamicBase"
		end

	frozen application_name: STRING is
		external
			"IL static_field signature :System.String use System.AppDomainFlags"
		alias
			"ApplicationName"
		end

	frozen shadow_copy_directories: STRING is
		external
			"IL static_field signature :System.String use System.AppDomainFlags"
		alias
			"ShadowCopyDirectories"
		end

	frozen shadow_copy_files: STRING is
		external
			"IL static_field signature :System.String use System.AppDomainFlags"
		alias
			"ShadowCopyFiles"
		end

	frozen private_bin_path: STRING is
		external
			"IL static_field signature :System.String use System.AppDomainFlags"
		alias
			"PrivateBinPath"
		end

	frozen cache_path: STRING is
		external
			"IL static_field signature :System.String use System.AppDomainFlags"
		alias
			"CachePath"
		end

	frozen license_file: STRING is
		external
			"IL static_field signature :System.String use System.AppDomainFlags"
		alias
			"LicenseFile"
		end

	frozen application_base: STRING is
		external
			"IL static_field signature :System.String use System.AppDomainFlags"
		alias
			"ApplicationBase"
		end

	frozen configuration_file: STRING is
		external
			"IL static_field signature :System.String use System.AppDomainFlags"
		alias
			"ConfigurationFile"
		end

end -- class SYSTEM_APPDOMAINFLAGS
