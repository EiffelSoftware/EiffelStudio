indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Principal.WindowsIdentity"

external class
	SYSTEM_SECURITY_PRINCIPAL_WINDOWSIDENTITY

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_SECURITY_PRINCIPAL_IIDENTITY
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK
		rename
			on_deserialization as system_runtime_serialization_ideserialization_callback_on_deserialization
		end

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (user_token: POINTER; type: STRING; acct_type: INTEGER; is_authenticated: BOOLEAN) is
			-- Valid values for `acct_type' are:
			-- Normal = 0
			-- Guest = 1
			-- System = 2
			-- Anonymous = 3
		require
			valid_windows_account_type: acct_type = 0 or acct_type = 1 or acct_type = 2 or acct_type = 3
		external
			"IL creator signature (System.IntPtr, System.String, enum System.Security.Principal.WindowsAccountType, System.Boolean) use System.Security.Principal.WindowsIdentity"
		end

	frozen make_2 (user_token: POINTER; type: STRING; acct_type: INTEGER) is
			-- Valid values for `acct_type' are:
			-- Normal = 0
			-- Guest = 1
			-- System = 2
			-- Anonymous = 3
		require
			valid_windows_account_type: acct_type = 0 or acct_type = 1 or acct_type = 2 or acct_type = 3
		external
			"IL creator signature (System.IntPtr, System.String, enum System.Security.Principal.WindowsAccountType) use System.Security.Principal.WindowsIdentity"
		end

	frozen make (user_token: POINTER) is
		external
			"IL creator signature (System.IntPtr) use System.Security.Principal.WindowsIdentity"
		end

	frozen make_1 (user_token: POINTER; type: STRING) is
		external
			"IL creator signature (System.IntPtr, System.String) use System.Security.Principal.WindowsIdentity"
		end

feature -- Access

	get_token: POINTER is
		external
			"IL signature (): System.IntPtr use System.Security.Principal.WindowsIdentity"
		alias
			"get_Token"
		end

	get_is_authenticated: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Principal.WindowsIdentity"
		alias
			"get_IsAuthenticated"
		end

	get_is_anonymous: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Principal.WindowsIdentity"
		alias
			"get_IsAnonymous"
		end

	get_is_guest: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Principal.WindowsIdentity"
		alias
			"get_IsGuest"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Security.Principal.WindowsIdentity"
		alias
			"get_Name"
		end

	get_authentication_type: STRING is
		external
			"IL signature (): System.String use System.Security.Principal.WindowsIdentity"
		alias
			"get_AuthenticationType"
		end

	get_is_system: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Principal.WindowsIdentity"
		alias
			"get_IsSystem"
		end

feature -- Basic Operations

	impersonate: SYSTEM_SECURITY_PRINCIPAL_WINDOWSIMPERSONATIONCONTEXT is
		external
			"IL signature (): System.Security.Principal.WindowsImpersonationContext use System.Security.Principal.WindowsIdentity"
		alias
			"Impersonate"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Principal.WindowsIdentity"
		alias
			"GetHashCode"
		end

	frozen get_anonymous: SYSTEM_SECURITY_PRINCIPAL_WINDOWSIDENTITY is
		external
			"IL static signature (): System.Security.Principal.WindowsIdentity use System.Security.Principal.WindowsIdentity"
		alias
			"GetAnonymous"
		end

	frozen get_current: SYSTEM_SECURITY_PRINCIPAL_WINDOWSIDENTITY is
		external
			"IL static signature (): System.Security.Principal.WindowsIdentity use System.Security.Principal.WindowsIdentity"
		alias
			"GetCurrent"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Principal.WindowsIdentity"
		alias
			"ToString"
		end

	frozen impersonate_int_ptr (user_token: POINTER): SYSTEM_SECURITY_PRINCIPAL_WINDOWSIMPERSONATIONCONTEXT is
		external
			"IL static signature (System.IntPtr): System.Security.Principal.WindowsImpersonationContext use System.Security.Principal.WindowsIdentity"
		alias
			"Impersonate"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Principal.WindowsIdentity"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Principal.WindowsIdentity"
		alias
			"Finalize"
		end

	frozen system_runtime_serialization_ideserialization_callback_on_deserialization (sender: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Security.Principal.WindowsIdentity"
		alias
			"System.Runtime.Serialization.IDeserializationCallback.OnDeserialization"
		end

end -- class SYSTEM_SECURITY_PRINCIPAL_WINDOWSIDENTITY
