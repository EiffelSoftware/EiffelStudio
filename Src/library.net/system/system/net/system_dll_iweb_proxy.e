indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.IWebProxy"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IWEB_PROXY

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_credentials: SYSTEM_DLL_ICREDENTIALS is
		external
			"IL deferred signature (): System.Net.ICredentials use System.Net.IWebProxy"
		alias
			"get_Credentials"
		end

feature -- Element Change

	set_credentials (value: SYSTEM_DLL_ICREDENTIALS) is
		external
			"IL deferred signature (System.Net.ICredentials): System.Void use System.Net.IWebProxy"
		alias
			"set_Credentials"
		end

feature -- Basic Operations

	get_proxy (destination: SYSTEM_DLL_URI): SYSTEM_DLL_URI is
		external
			"IL deferred signature (System.Uri): System.Uri use System.Net.IWebProxy"
		alias
			"GetProxy"
		end

	is_bypassed (host: SYSTEM_DLL_URI): BOOLEAN is
		external
			"IL deferred signature (System.Uri): System.Boolean use System.Net.IWebProxy"
		alias
			"IsBypassed"
		end

end -- class SYSTEM_DLL_IWEB_PROXY
