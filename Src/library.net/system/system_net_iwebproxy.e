indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.IWebProxy"

deferred external class
	SYSTEM_NET_IWEBPROXY

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_credentials: SYSTEM_NET_ICREDENTIALS is
		external
			"IL deferred signature (): System.Net.ICredentials use System.Net.IWebProxy"
		alias
			"get_Credentials"
		end

feature -- Element Change

	set_credentials (value: SYSTEM_NET_ICREDENTIALS) is
		external
			"IL deferred signature (System.Net.ICredentials): System.Void use System.Net.IWebProxy"
		alias
			"set_Credentials"
		end

feature -- Basic Operations

	get_proxy (destination: SYSTEM_URI): SYSTEM_URI is
		external
			"IL deferred signature (System.Uri): System.Uri use System.Net.IWebProxy"
		alias
			"GetProxy"
		end

	is_bypassed (host: SYSTEM_URI): BOOLEAN is
		external
			"IL deferred signature (System.Uri): System.Boolean use System.Net.IWebProxy"
		alias
			"IsBypassed"
		end

end -- class SYSTEM_NET_IWEBPROXY
