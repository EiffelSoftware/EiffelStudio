indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Principal.GenericIdentity"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	GENERIC_IDENTITY

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IIDENTITY

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Security.Principal.GenericIdentity"
		end

	frozen make_1 (name: SYSTEM_STRING; type: SYSTEM_STRING) is
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

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Principal.GenericIdentity"
		alias
			"get_Name"
		end

	get_authentication_type: SYSTEM_STRING is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Principal.GenericIdentity"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

end -- class GENERIC_IDENTITY
