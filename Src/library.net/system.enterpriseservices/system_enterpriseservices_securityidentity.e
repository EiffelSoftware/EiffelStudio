indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.SecurityIdentity"

frozen external class
	SYSTEM_ENTERPRISESERVICES_SECURITYIDENTITY

create {NONE}

feature -- Access

	frozen get_authentication_service: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.SecurityIdentity"
		alias
			"get_AuthenticationService"
		end

	frozen get_impersonation_level: SYSTEM_ENTERPRISESERVICES_IMPERSONATIONLEVELOPTION is
		external
			"IL signature (): System.EnterpriseServices.ImpersonationLevelOption use System.EnterpriseServices.SecurityIdentity"
		alias
			"get_ImpersonationLevel"
		end

	frozen get_account_name: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.SecurityIdentity"
		alias
			"get_AccountName"
		end

	frozen get_authentication_level: SYSTEM_ENTERPRISESERVICES_AUTHENTICATIONOPTION is
		external
			"IL signature (): System.EnterpriseServices.AuthenticationOption use System.EnterpriseServices.SecurityIdentity"
		alias
			"get_AuthenticationLevel"
		end

end -- class SYSTEM_ENTERPRISESERVICES_SECURITYIDENTITY
