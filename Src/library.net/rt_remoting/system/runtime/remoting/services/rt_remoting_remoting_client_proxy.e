indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Services.RemotingClientProxy"
	assembly: "System.Runtime.Remoting", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	RT_REMOTING_REMOTING_CLIENT_PROXY

inherit
	SYSTEM_DLL_COMPONENT
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

feature -- Access

	frozen get_enable_cookies: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_EnableCookies"
		end

	frozen get_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_Path"
		end

	frozen get_username: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_Username"
		end

	frozen get_pre_authenticate: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_PreAuthenticate"
		end

	frozen get_allow_auto_redirect: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_AllowAutoRedirect"
		end

	frozen get_proxy_port: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_ProxyPort"
		end

	frozen get_password: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_Password"
		end

	frozen get_domain: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_Domain"
		end

	frozen get_user_agent: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_UserAgent"
		end

	frozen get_timeout: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_Timeout"
		end

	frozen get_cookies: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_Cookies"
		end

	frozen get_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_Url"
		end

	frozen get_proxy_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_ProxyName"
		end

feature -- Element Change

	frozen set_proxy_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_ProxyName"
		end

	frozen set_path (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_Path"
		end

	frozen set_domain (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_Domain"
		end

	frozen set_username (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_Username"
		end

	frozen set_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_Url"
		end

	frozen set_proxy_port (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_ProxyPort"
		end

	frozen set_user_agent (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_UserAgent"
		end

	frozen set_allow_auto_redirect (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_AllowAutoRedirect"
		end

	frozen set_password (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_Password"
		end

	frozen set_enable_cookies (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_EnableCookies"
		end

	frozen set_pre_authenticate (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_PreAuthenticate"
		end

	frozen set_timeout (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_Timeout"
		end

feature {NONE} -- Implementation

	frozen configure_proxy (type: TYPE; url: SYSTEM_STRING) is
		external
			"IL signature (System.Type, System.String): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"ConfigureProxy"
		end

	frozen connect_proxy is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"ConnectProxy"
		end

end -- class RT_REMOTING_REMOTING_CLIENT_PROXY
