indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.InstallationFlags"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	ENT_SERV_INSTALLATION_FLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen expect_existing_type_lib: ENT_SERV_INSTALLATION_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"1"
		end

	frozen create_target_application: ENT_SERV_INSTALLATION_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"2"
		end

	frozen find_or_create_target_application: ENT_SERV_INSTALLATION_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"4"
		end

	frozen reconfigure_existing_application: ENT_SERV_INSTALLATION_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"8"
		end

	frozen configure_components_only: ENT_SERV_INSTALLATION_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"16"
		end

	frozen register: ENT_SERV_INSTALLATION_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"256"
		end

	frozen install: ENT_SERV_INSTALLATION_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"512"
		end

	frozen default_: ENT_SERV_INSTALLATION_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"0"
		end

	frozen report_warnings_to_console: ENT_SERV_INSTALLATION_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"32"
		end

	frozen configure: ENT_SERV_INSTALLATION_FLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"1024"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class ENT_SERV_INSTALLATION_FLAGS
