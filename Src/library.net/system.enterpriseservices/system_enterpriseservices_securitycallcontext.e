indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.SecurityCallContext"

frozen external class
	SYSTEM_ENTERPRISESERVICES_SECURITYCALLCONTEXT

create {NONE}

feature -- Access

	frozen get_direct_caller: SYSTEM_ENTERPRISESERVICES_SECURITYIDENTITY is
		external
			"IL signature (): System.EnterpriseServices.SecurityIdentity use System.EnterpriseServices.SecurityCallContext"
		alias
			"get_DirectCaller"
		end

	frozen get_is_security_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.SecurityCallContext"
		alias
			"get_IsSecurityEnabled"
		end

	frozen get_min_authentication_level: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.SecurityCallContext"
		alias
			"get_MinAuthenticationLevel"
		end

	frozen get_num_callers: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.SecurityCallContext"
		alias
			"get_NumCallers"
		end

	frozen get_callers: SYSTEM_ENTERPRISESERVICES_SECURITYCALLERS is
		external
			"IL signature (): System.EnterpriseServices.SecurityCallers use System.EnterpriseServices.SecurityCallContext"
		alias
			"get_Callers"
		end

	frozen get_current_call: SYSTEM_ENTERPRISESERVICES_SECURITYCALLCONTEXT is
		external
			"IL static signature (): System.EnterpriseServices.SecurityCallContext use System.EnterpriseServices.SecurityCallContext"
		alias
			"get_CurrentCall"
		end

	frozen get_original_caller: SYSTEM_ENTERPRISESERVICES_SECURITYIDENTITY is
		external
			"IL signature (): System.EnterpriseServices.SecurityIdentity use System.EnterpriseServices.SecurityCallContext"
		alias
			"get_OriginalCaller"
		end

feature -- Basic Operations

	frozen is_caller_in_role (role: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.EnterpriseServices.SecurityCallContext"
		alias
			"IsCallerInRole"
		end

	frozen is_user_in_role (user: STRING; role: STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.EnterpriseServices.SecurityCallContext"
		alias
			"IsUserInRole"
		end

end -- class SYSTEM_ENTERPRISESERVICES_SECURITYCALLCONTEXT
