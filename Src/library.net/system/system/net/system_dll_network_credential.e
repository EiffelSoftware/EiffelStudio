indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.NetworkCredential"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_NETWORK_CREDENTIAL

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_DLL_ICREDENTIALS

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (user_name: SYSTEM_STRING; password: SYSTEM_STRING; domain: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Net.NetworkCredential"
		end

	frozen make is
		external
			"IL creator use System.Net.NetworkCredential"
		end

	frozen make_1 (user_name: SYSTEM_STRING; password: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Net.NetworkCredential"
		end

feature -- Access

	frozen get_password: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.NetworkCredential"
		alias
			"get_Password"
		end

	frozen get_domain: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.NetworkCredential"
		alias
			"get_Domain"
		end

	frozen get_user_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.NetworkCredential"
		alias
			"get_UserName"
		end

feature -- Element Change

	frozen set_domain (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.NetworkCredential"
		alias
			"set_Domain"
		end

	frozen set_password (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.NetworkCredential"
		alias
			"set_Password"
		end

	frozen set_user_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.NetworkCredential"
		alias
			"set_UserName"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.NetworkCredential"
		alias
			"GetHashCode"
		end

	frozen get_credential (uri: SYSTEM_DLL_URI; auth_type: SYSTEM_STRING): SYSTEM_DLL_NETWORK_CREDENTIAL is
		external
			"IL signature (System.Uri, System.String): System.Net.NetworkCredential use System.Net.NetworkCredential"
		alias
			"GetCredential"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.NetworkCredential"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.NetworkCredential"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Net.NetworkCredential"
		alias
			"Finalize"
		end

end -- class SYSTEM_DLL_NETWORK_CREDENTIAL
