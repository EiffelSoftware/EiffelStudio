indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Principal.GenericIdentity"

external class
	SYSTEM_SECURITY_PRINCIPAL_GENERICIDENTITY

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_SECURITY_PRINCIPAL_IIDENTITY

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (name: STRING) is
		external
			"IL creator signature (System.String) use System.Security.Principal.GenericIdentity"
		end

	frozen make_1 (name: STRING; type: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Security.Principal.GenericIdentity"
		end

feature -- Access

	get_is_authenticated: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Principal.GenericIdentity"
		alias
			"get_IsAuthenticated"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Security.Principal.GenericIdentity"
		alias
			"get_Name"
		end

	get_authentication_type: STRING is
		external
			"IL signature (): System.String use System.Security.Principal.GenericIdentity"
		alias
			"get_AuthenticationType"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Principal.GenericIdentity"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Principal.GenericIdentity"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Principal.GenericIdentity"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Principal.GenericIdentity"
		alias
			"Finalize"
		end

end -- class SYSTEM_SECURITY_PRINCIPAL_GENERICIDENTITY
