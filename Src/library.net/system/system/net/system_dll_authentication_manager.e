indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.AuthenticationManager"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_AUTHENTICATION_MANAGER

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_registered_modules: IENUMERATOR is
		external
			"IL static signature (): System.Collections.IEnumerator use System.Net.AuthenticationManager"
		alias
			"get_RegisteredModules"
		end

feature -- Basic Operations

	frozen unregister_iauthentication_module (authentication_module: SYSTEM_DLL_IAUTHENTICATION_MODULE) is
		external
			"IL static signature (System.Net.IAuthenticationModule): System.Void use System.Net.AuthenticationManager"
		alias
			"Unregister"
		end

	frozen register (authentication_module: SYSTEM_DLL_IAUTHENTICATION_MODULE) is
		external
			"IL static signature (System.Net.IAuthenticationModule): System.Void use System.Net.AuthenticationManager"
		alias
			"Register"
		end

	frozen authenticate (challenge: SYSTEM_STRING; request: SYSTEM_DLL_WEB_REQUEST; credentials: SYSTEM_DLL_ICREDENTIALS): SYSTEM_DLL_AUTHORIZATION is
		external
			"IL static signature (System.String, System.Net.WebRequest, System.Net.ICredentials): System.Net.Authorization use System.Net.AuthenticationManager"
		alias
			"Authenticate"
		end

	frozen unregister (authentication_scheme: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Net.AuthenticationManager"
		alias
			"Unregister"
		end

	frozen pre_authenticate (request: SYSTEM_DLL_WEB_REQUEST; credentials: SYSTEM_DLL_ICREDENTIALS): SYSTEM_DLL_AUTHORIZATION is
		external
			"IL static signature (System.Net.WebRequest, System.Net.ICredentials): System.Net.Authorization use System.Net.AuthenticationManager"
		alias
			"PreAuthenticate"
		end

end -- class SYSTEM_DLL_AUTHENTICATION_MANAGER
