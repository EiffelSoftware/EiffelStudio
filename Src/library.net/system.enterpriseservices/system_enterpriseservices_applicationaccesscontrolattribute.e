indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.ApplicationAccessControlAttribute"

frozen external class
	SYSTEM_ENTERPRISESERVICES_APPLICATIONACCESSCONTROLATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_applicationaccesscontrolattribute_1,
	make_applicationaccesscontrolattribute

feature {NONE} -- Initialization

	frozen make_applicationaccesscontrolattribute_1 (val: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.EnterpriseServices.ApplicationAccessControlAttribute"
		end

	frozen make_applicationaccesscontrolattribute is
		external
			"IL creator use System.EnterpriseServices.ApplicationAccessControlAttribute"
		end

feature -- Access

	frozen get_impersonation_level: SYSTEM_ENTERPRISESERVICES_IMPERSONATIONLEVELOPTION is
		external
			"IL signature (): System.EnterpriseServices.ImpersonationLevelOption use System.EnterpriseServices.ApplicationAccessControlAttribute"
		alias
			"get_ImpersonationLevel"
		end

	frozen get_access_checks_level: SYSTEM_ENTERPRISESERVICES_ACCESSCHECKSLEVELOPTION is
		external
			"IL signature (): System.EnterpriseServices.AccessChecksLevelOption use System.EnterpriseServices.ApplicationAccessControlAttribute"
		alias
			"get_AccessChecksLevel"
		end

	frozen get_authentication: SYSTEM_ENTERPRISESERVICES_AUTHENTICATIONOPTION is
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

	frozen set_impersonation_level (value: SYSTEM_ENTERPRISESERVICES_IMPERSONATIONLEVELOPTION) is
		external
			"IL signature (System.EnterpriseServices.ImpersonationLevelOption): System.Void use System.EnterpriseServices.ApplicationAccessControlAttribute"
		alias
			"set_ImpersonationLevel"
		end

	frozen set_access_checks_level (value: SYSTEM_ENTERPRISESERVICES_ACCESSCHECKSLEVELOPTION) is
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

	frozen set_authentication (value: SYSTEM_ENTERPRISESERVICES_AUTHENTICATIONOPTION) is
		external
			"IL signature (System.EnterpriseServices.AuthenticationOption): System.Void use System.EnterpriseServices.ApplicationAccessControlAttribute"
		alias
			"set_Authentication"
		end

end -- class SYSTEM_ENTERPRISESERVICES_APPLICATIONACCESSCONTROLATTRIBUTE
