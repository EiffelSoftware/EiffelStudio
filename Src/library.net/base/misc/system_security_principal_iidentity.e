indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Principal.IIdentity"

deferred external class
	SYSTEM_SECURITY_PRINCIPAL_IIDENTITY

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_is_authenticated: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Security.Principal.IIdentity"
		alias
			"get_IsAuthenticated"
		end

	get_name: STRING is
		external
			"IL deferred signature (): System.String use System.Security.Principal.IIdentity"
		alias
			"get_Name"
		end

	get_authentication_type: STRING is
		external
			"IL deferred signature (): System.String use System.Security.Principal.IIdentity"
		alias
			"get_AuthenticationType"
		end

end -- class SYSTEM_SECURITY_PRINCIPAL_IIDENTITY
