indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.SecurityIdentity"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_SECURITY_IDENTITY

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_authentication_service: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.SecurityIdentity"
		alias
			"get_AuthenticationService"
		end

	frozen get_impersonation_level: ENT_SERV_IMPERSONATION_LEVEL_OPTION is
		external
			"IL signature (): System.EnterpriseServices.ImpersonationLevelOption use System.EnterpriseServices.SecurityIdentity"
		alias
			"get_ImpersonationLevel"
		end

	frozen get_account_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.SecurityIdentity"
		alias
			"get_AccountName"
		end

	frozen get_authentication_level: ENT_SERV_AUTHENTICATION_OPTION is
		external
			"IL signature (): System.EnterpriseServices.AuthenticationOption use System.EnterpriseServices.SecurityIdentity"
		alias
			"get_AuthenticationLevel"
		end

end -- class ENT_SERV_SECURITY_IDENTITY
