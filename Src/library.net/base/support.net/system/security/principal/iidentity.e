indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Principal.IIdentity"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IIDENTITY

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_is_authenticated: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Security.Principal.IIdentity"
		alias
			"get_IsAuthenticated"
		end

	get_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Security.Principal.IIdentity"
		alias
			"get_Name"
		end

	get_authentication_type: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Security.Principal.IIdentity"
		alias
			"get_AuthenticationType"
		end

end -- class IIDENTITY
