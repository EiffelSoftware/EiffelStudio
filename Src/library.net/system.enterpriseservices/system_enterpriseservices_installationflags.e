indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.InstallationFlags"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen expect_existing_type_lib: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"1"
		end

	frozen create_target_application: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"2"
		end

	frozen find_or_create_target_application: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"4"
		end

	frozen reconfigure_existing_application: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"8"
		end

	frozen configure_components_only: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"16"
		end

	frozen register: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"256"
		end

	frozen install: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"512"
		end

	frozen report_warnings_to_console: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"32"
		end

	frozen default: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS is
		external
			"IL enum signature :System.EnterpriseServices.InstallationFlags use System.EnterpriseServices.InstallationFlags"
		alias
			"0"
		end

	frozen configure: SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS is
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

end -- class SYSTEM_ENTERPRISESERVICES_INSTALLATIONFLAGS
