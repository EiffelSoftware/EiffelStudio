indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Principal.WindowsIdentity"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINDOWS_IDENTITY

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IIDENTITY
	IDESERIALIZATION_CALLBACK
		rename
			on_deserialization as system_runtime_serialization_ideserialization_callback_on_deserialization
		end

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (user_token: POINTER; type: SYSTEM_STRING; acct_type: WINDOWS_ACCOUNT_TYPE; is_authenticated: BOOLEAN) is
		external
			"IL creator signature (System.IntPtr, System.String, System.Security.Principal.WindowsAccountType, System.Boolean) use System.Security.Principal.WindowsIdentity"
		end

	frozen make_2 (user_token: POINTER; type: SYSTEM_STRING; acct_type: WINDOWS_ACCOUNT_TYPE) is
		external
			"IL creator signature (System.IntPtr, System.String, System.Security.Principal.WindowsAccountType) use System.Security.Principal.WindowsIdentity"
		end

	frozen make (user_token: POINTER) is
		external
			"IL creator signature (System.IntPtr) use System.Security.Principal.WindowsIdentity"
		end

	frozen make_1 (user_token: POINTER; type: SYSTEM_STRING) is
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

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Principal.WindowsIdentity"
		alias
			"get_Name"
		end

	get_authentication_type: SYSTEM_STRING is
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

	impersonate: WINDOWS_IMPERSONATION_CONTEXT is
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

	frozen get_anonymous: WINDOWS_IDENTITY is
		external
			"IL static signature (): System.Security.Principal.WindowsIdentity use System.Security.Principal.WindowsIdentity"
		alias
			"GetAnonymous"
		end

	frozen get_current: WINDOWS_IDENTITY is
		external
			"IL static signature (): System.Security.Principal.WindowsIdentity use System.Security.Principal.WindowsIdentity"
		alias
			"GetCurrent"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Principal.WindowsIdentity"
		alias
			"ToString"
		end

	frozen impersonate_int_ptr (user_token: POINTER): WINDOWS_IMPERSONATION_CONTEXT is
		external
			"IL static signature (System.IntPtr): System.Security.Principal.WindowsImpersonationContext use System.Security.Principal.WindowsIdentity"
		alias
			"Impersonate"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

	frozen system_runtime_serialization_ideserialization_callback_on_deserialization (sender: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Security.Principal.WindowsIdentity"
		alias
			"System.Runtime.Serialization.IDeserializationCallback.OnDeserialization"
		end

end -- class WINDOWS_IDENTITY
