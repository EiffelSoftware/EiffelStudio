indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Principal.GenericPrincipal"

external class
	SYSTEM_SECURITY_PRINCIPAL_GENERICPRINCIPAL

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL

create
	make

feature {NONE} -- Initialization

	frozen make (identity: SYSTEM_SECURITY_PRINCIPAL_IIDENTITY; roles: ARRAY [STRING]) is
		external
			"IL creator signature (System.Security.Principal.IIdentity, System.String[]) use System.Security.Principal.GenericPrincipal"
		end

feature -- Access

	get_identity: SYSTEM_SECURITY_PRINCIPAL_IIDENTITY is
		external
			"IL signature (): System.Security.Principal.IIdentity use System.Security.Principal.GenericPrincipal"
		alias
			"get_Identity"
		end

feature -- Basic Operations

	is_in_role (role: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Security.Principal.GenericPrincipal"
		alias
			"IsInRole"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Principal.GenericPrincipal"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Principal.GenericPrincipal"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Principal.GenericPrincipal"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Principal.GenericPrincipal"
		alias
			"Finalize"
		end

end -- class SYSTEM_SECURITY_PRINCIPAL_GENERICPRINCIPAL
