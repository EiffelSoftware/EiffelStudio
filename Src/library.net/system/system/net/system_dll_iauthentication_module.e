indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.IAuthenticationModule"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IAUTHENTICATION_MODULE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_can_pre_authenticate: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Net.IAuthenticationModule"
		alias
			"get_CanPreAuthenticate"
		end

	get_authentication_type: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Net.IAuthenticationModule"
		alias
			"get_AuthenticationType"
		end

feature -- Basic Operations

	authenticate (challenge: SYSTEM_STRING; request: SYSTEM_DLL_WEB_REQUEST; credentials: SYSTEM_DLL_ICREDENTIALS): SYSTEM_DLL_AUTHORIZATION is
		external
			"IL deferred signature (System.String, System.Net.WebRequest, System.Net.ICredentials): System.Net.Authorization use System.Net.IAuthenticationModule"
		alias
			"Authenticate"
		end

	pre_authenticate (request: SYSTEM_DLL_WEB_REQUEST; credentials: SYSTEM_DLL_ICREDENTIALS): SYSTEM_DLL_AUTHORIZATION is
		external
			"IL deferred signature (System.Net.WebRequest, System.Net.ICredentials): System.Net.Authorization use System.Net.IAuthenticationModule"
		alias
			"PreAuthenticate"
		end

end -- class SYSTEM_DLL_IAUTHENTICATION_MODULE
