indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpRuntime"

frozen external class
	SYSTEM_WEB_HTTPRUNTIME

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.HttpRuntime"
		end

feature -- Access

	frozen get_machine_configuration_directory: STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_MachineConfigurationDirectory"
		end

	frozen get_app_domain_app_path: STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_AppDomainAppPath"
		end

	frozen get_cache: SYSTEM_WEB_CACHING_CACHE is
		external
			"IL static signature (): System.Web.Caching.Cache use System.Web.HttpRuntime"
		alias
			"get_Cache"
		end

	frozen get_app_domain_app_virtual_path: STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_AppDomainAppVirtualPath"
		end

	frozen get_is_on_uncshare: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Web.HttpRuntime"
		alias
			"get_IsOnUNCShare"
		end

	frozen get_bin_directory: STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_BinDirectory"
		end

	frozen get_clr_install_directory: STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_ClrInstallDirectory"
		end

	frozen get_asp_install_directory: STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_AspInstallDirectory"
		end

	frozen get_app_domain_app_id: STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_AppDomainAppId"
		end

	frozen get_codegen_dir: STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_CodegenDir"
		end

	frozen get_app_domain_id: STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_AppDomainId"
		end

feature -- Basic Operations

	frozen close is
		external
			"IL static signature (): System.Void use System.Web.HttpRuntime"
		alias
			"Close"
		end

	frozen load_assembly_string_boolean (assembly_name: STRING; throw_on_fail: BOOLEAN): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.String, System.Boolean): System.Reflection.Assembly use System.Web.HttpRuntime"
		alias
			"LoadAssembly"
		end

	frozen get_assembly_type (assembly_name: STRING; class_name: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.String): System.Type use System.Web.HttpRuntime"
		alias
			"GetAssemblyType"
		end

	frozen get_assembly_type_string_string_boolean (assembly_name: STRING; class_name: STRING; throw_on_fail: BOOLEAN): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.String, System.Boolean): System.Type use System.Web.HttpRuntime"
		alias
			"GetAssemblyType"
		end

	frozen load_assembly (assembly_name: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.String): System.Reflection.Assembly use System.Web.HttpRuntime"
		alias
			"LoadAssembly"
		end

	frozen process_request (wr: SYSTEM_WEB_HTTPWORKERREQUEST) is
		external
			"IL static signature (System.Web.HttpWorkerRequest): System.Void use System.Web.HttpRuntime"
		alias
			"ProcessRequest"
		end

end -- class SYSTEM_WEB_HTTPRUNTIME
