indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.IAuthenticationModule"

deferred external class
	SYSTEM_NET_IAUTHENTICATIONMODULE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_can_pre_authenticate: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Net.IAuthenticationModule"
		alias
			"get_CanPreAuthenticate"
		end

	get_authentication_type: STRING is
		external
			"IL deferred signature (): System.String use System.Net.IAuthenticationModule"
		alias
			"get_AuthenticationType"
		end

feature -- Basic Operations

	authenticate (challenge: STRING; request: SYSTEM_NET_WEBREQUEST; credentials: SYSTEM_NET_ICREDENTIALS): SYSTEM_NET_AUTHORIZATION is
		external
			"IL deferred signature (System.String, System.Net.WebRequest, System.Net.ICredentials): System.Net.Authorization use System.Net.IAuthenticationModule"
		alias
			"Authenticate"
		end

	pre_authenticate (request: SYSTEM_NET_WEBREQUEST; credentials: SYSTEM_NET_ICREDENTIALS): SYSTEM_NET_AUTHORIZATION is
		external
			"IL deferred signature (System.Net.WebRequest, System.Net.ICredentials): System.Net.Authorization use System.Net.IAuthenticationModule"
		alias
			"PreAuthenticate"
		end

end -- class SYSTEM_NET_IAUTHENTICATIONMODULE
