indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Principal.WindowsPrincipal"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINDOWS_PRINCIPAL

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IPRINCIPAL
		rename
			is_in_role as is_in_role_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (nt_identity: WINDOWS_IDENTITY) is
		external
			"IL creator signature (System.Security.Principal.WindowsIdentity) use System.Security.Principal.WindowsPrincipal"
		end

feature -- Access

	get_identity: IIDENTITY is
		external
			"IL signature (): System.Security.Principal.IIdentity use System.Security.Principal.WindowsPrincipal"
		alias
			"get_Identity"
		end

feature -- Basic Operations

	is_in_role_string (role: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Security.Principal.WindowsPrincipal"
		alias
			"IsInRole"
		end

	is_in_role_windows_built_in_role (role: WINDOWS_BUILT_IN_ROLE): BOOLEAN is
		external
			"IL signature (System.Security.Principal.WindowsBuiltInRole): System.Boolean use System.Security.Principal.WindowsPrincipal"
		alias
			"IsInRole"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Principal.WindowsPrincipal"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Principal.WindowsPrincipal"
		alias
			"ToString"
		end

	is_in_role (rid: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Security.Principal.WindowsPrincipal"
		alias
			"IsInRole"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Principal.WindowsPrincipal"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Principal.WindowsPrincipal"
		alias
			"Finalize"
		end

end -- class WINDOWS_PRINCIPAL
