indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Principal.IPrincipal"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IPRINCIPAL

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_identity: IIDENTITY is
		external
			"IL deferred signature (): System.Security.Principal.IIdentity use System.Security.Principal.IPrincipal"
		alias
			"get_Identity"
		end

feature -- Basic Operations

	is_in_role (role: SYSTEM_STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.Security.Principal.IPrincipal"
		alias
			"IsInRole"
		end

end -- class IPRINCIPAL
