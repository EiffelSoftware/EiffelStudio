indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.ApplicationAccessControlAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_APPLICATION_ACCESS_CONTROL_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_application_access_control_attribute,
	make_ent_serv_application_access_control_attribute_1

feature {NONE} -- Initialization

	frozen make_ent_serv_application_access_control_attribute is
		external
			"IL creator use System.EnterpriseServices.ApplicationAccessControlAttribute"
		end

	frozen make_ent_serv_application_access_control_attribute_1 (val: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.EnterpriseServices.ApplicationAccessControlAttribute"
		end

feature -- Access

	frozen get_impersonation_level: ENT_SERV_IMPERSONATION_LEVEL_OPTION is
		external
			"IL signature (): System.EnterpriseServices.ImpersonationLevelOption use System.EnterpriseServices.ApplicationAccessControlAttribute"
		alias
			"get_ImpersonationLevel"
		end

	frozen get_access_checks_level: ENT_SERV_ACCESS_CHECKS_LEVEL_OPTION is
		external
			"IL signature (): System.EnterpriseServices.AccessChecksLevelOption use System.EnterpriseServices.ApplicationAccessControlAttribute"
		alias
			"get_AccessChecksLevel"
		end

	frozen get_authentication: ENT_SERV_AUTHENTICATION_OPTION is
		external
			"IL signature (): System.EnterpriseServices.AuthenticationOption use System.EnterpriseServices.ApplicationAccessControlAttribute"
		alias
			"get_Authentication"
		end

	frozen get_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.ApplicationAccessControlAttribute"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_impersonation_level (value: ENT_SERV_IMPERSONATION_LEVEL_OPTION) is
		external
			"IL signature (System.EnterpriseServices.ImpersonationLevelOption): System.Void use System.EnterpriseServices.ApplicationAccessControlAttribute"
		alias
			"set_ImpersonationLevel"
		end

	frozen set_access_checks_level (value: ENT_SERV_ACCESS_CHECKS_LEVEL_OPTION) is
		external
			"IL signature (System.EnterpriseServices.AccessChecksLevelOption): System.Void use System.EnterpriseServices.ApplicationAccessControlAttribute"
		alias
			"set_AccessChecksLevel"
		end

	frozen set_value (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.EnterpriseServices.ApplicationAccessControlAttribute"
		alias
			"set_Value"
		end

	frozen set_authentication (value: ENT_SERV_AUTHENTICATION_OPTION) is
		external
			"IL signature (System.EnterpriseServices.AuthenticationOption): System.Void use System.EnterpriseServices.ApplicationAccessControlAttribute"
		alias
			"set_Authentication"
		end

end -- class ENT_SERV_APPLICATION_ACCESS_CONTROL_ATTRIBUTE
