indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Principal.GenericPrincipal"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	GENERIC_PRINCIPAL

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IPRINCIPAL

create
	make

feature {NONE} -- Initialization

	frozen make (identity: IIDENTITY; roles: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL creator signature (System.Security.Principal.IIdentity, System.String[]) use System.Security.Principal.GenericPrincipal"
		end

feature -- Access

	get_identity: IIDENTITY is
		external
			"IL signature (): System.Security.Principal.IIdentity use System.Security.Principal.GenericPrincipal"
		alias
			"get_Identity"
		end

feature -- Basic Operations

	is_in_role (role: SYSTEM_STRING): BOOLEAN is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Principal.GenericPrincipal"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

end -- class GENERIC_PRINCIPAL
