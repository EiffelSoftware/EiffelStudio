indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Principal.IPrincipal"

deferred external class
	SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_identity: SYSTEM_SECURITY_PRINCIPAL_IIDENTITY is
		external
			"IL deferred signature (): System.Security.Principal.IIdentity use System.Security.Principal.IPrincipal"
		alias
			"get_Identity"
		end

feature -- Basic Operations

	is_in_role (role: STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.Security.Principal.IPrincipal"
		alias
			"IsInRole"
		end

end -- class SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL
