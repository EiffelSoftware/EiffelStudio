indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpRuntime"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_RUNTIME

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.HttpRuntime"
		end

feature -- Access

	frozen get_machine_configuration_directory: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_MachineConfigurationDirectory"
		end

	frozen get_app_domain_app_path: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_AppDomainAppPath"
		end

	frozen get_cache: WEB_CACHE is
		external
			"IL static signature (): System.Web.Caching.Cache use System.Web.HttpRuntime"
		alias
			"get_Cache"
		end

	frozen get_app_domain_app_virtual_path: SYSTEM_STRING is
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

	frozen get_bin_directory: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_BinDirectory"
		end

	frozen get_clr_install_directory: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_ClrInstallDirectory"
		end

	frozen get_asp_install_directory: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_AspInstallDirectory"
		end

	frozen get_app_domain_app_id: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_AppDomainAppId"
		end

	frozen get_codegen_dir: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Web.HttpRuntime"
		alias
			"get_CodegenDir"
		end

	frozen get_app_domain_id: SYSTEM_STRING is
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

	frozen process_request (wr: WEB_HTTP_WORKER_REQUEST) is
		external
			"IL static signature (System.Web.HttpWorkerRequest): System.Void use System.Web.HttpRuntime"
		alias
			"ProcessRequest"
		end

end -- class WEB_HTTP_RUNTIME
