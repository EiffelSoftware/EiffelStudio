indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.AuthenticationManager"

external class
	SYSTEM_NET_AUTHENTICATIONMANAGER

create {NONE}

feature -- Access

	frozen get_registered_modules: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL static signature (): System.Collections.IEnumerator use System.Net.AuthenticationManager"
		alias
			"get_RegisteredModules"
		end

feature -- Basic Operations

	frozen unregister_iauthentication_module (authentication_module: SYSTEM_NET_IAUTHENTICATIONMODULE) is
		external
			"IL static signature (System.Net.IAuthenticationModule): System.Void use System.Net.AuthenticationManager"
		alias
			"Unregister"
		end

	frozen register (authentication_module: SYSTEM_NET_IAUTHENTICATIONMODULE) is
		external
			"IL static signature (System.Net.IAuthenticationModule): System.Void use System.Net.AuthenticationManager"
		alias
			"Register"
		end

	frozen authenticate (challenge: STRING; request: SYSTEM_NET_WEBREQUEST; credentials: SYSTEM_NET_ICREDENTIALS): SYSTEM_NET_AUTHORIZATION is
		external
			"IL static signature (System.String, System.Net.WebRequest, System.Net.ICredentials): System.Net.Authorization use System.Net.AuthenticationManager"
		alias
			"Authenticate"
		end

	frozen unregister (authentication_scheme: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Net.AuthenticationManager"
		alias
			"Unregister"
		end

	frozen pre_authenticate (request: SYSTEM_NET_WEBREQUEST; credentials: SYSTEM_NET_ICREDENTIALS): SYSTEM_NET_AUTHORIZATION is
		external
			"IL static signature (System.Net.WebRequest, System.Net.ICredentials): System.Net.Authorization use System.Net.AuthenticationManager"
		alias
			"PreAuthenticate"
		end

end -- class SYSTEM_NET_AUTHENTICATIONMANAGER
