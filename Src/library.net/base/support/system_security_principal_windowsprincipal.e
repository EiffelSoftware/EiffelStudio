indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Principal.WindowsPrincipal"

external class
	SYSTEM_SECURITY_PRINCIPAL_WINDOWSPRINCIPAL

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL
		rename
			is_in_role as is_in_role_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (nt_identity: SYSTEM_SECURITY_PRINCIPAL_WINDOWSIDENTITY) is
		external
			"IL creator signature (System.Security.Principal.WindowsIdentity) use System.Security.Principal.WindowsPrincipal"
		end

feature -- Access

	get_identity: SYSTEM_SECURITY_PRINCIPAL_IIDENTITY is
		external
			"IL signature (): System.Security.Principal.IIdentity use System.Security.Principal.WindowsPrincipal"
		alias
			"get_Identity"
		end

feature -- Basic Operations

	is_in_role_string (role: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Security.Principal.WindowsPrincipal"
		alias
			"IsInRole"
		end

	is_in_role_windows_built_in_role (role: SYSTEM_SECURITY_PRINCIPAL_WINDOWSBUILTINROLE): BOOLEAN is
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

	to_string: STRING is
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

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_SECURITY_PRINCIPAL_WINDOWSPRINCIPAL
