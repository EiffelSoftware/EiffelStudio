indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.SecurityCallContext"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_SECURITY_CALL_CONTEXT

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_direct_caller: ENT_SERV_SECURITY_IDENTITY is
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

	frozen get_callers: ENT_SERV_SECURITY_CALLERS is
		external
			"IL signature (): System.EnterpriseServices.SecurityCallers use System.EnterpriseServices.SecurityCallContext"
		alias
			"get_Callers"
		end

	frozen get_current_call: ENT_SERV_SECURITY_CALL_CONTEXT is
		external
			"IL static signature (): System.EnterpriseServices.SecurityCallContext use System.EnterpriseServices.SecurityCallContext"
		alias
			"get_CurrentCall"
		end

	frozen get_original_caller: ENT_SERV_SECURITY_IDENTITY is
		external
			"IL signature (): System.EnterpriseServices.SecurityIdentity use System.EnterpriseServices.SecurityCallContext"
		alias
			"get_OriginalCaller"
		end

feature -- Basic Operations

	frozen is_caller_in_role (role: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.EnterpriseServices.SecurityCallContext"
		alias
			"IsCallerInRole"
		end

	frozen is_user_in_role (user: SYSTEM_STRING; role: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.EnterpriseServices.SecurityCallContext"
		alias
			"IsUserInRole"
		end

end -- class ENT_SERV_SECURITY_CALL_CONTEXT
