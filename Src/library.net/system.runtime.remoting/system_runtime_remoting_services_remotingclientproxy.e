indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Services.RemotingClientProxy"

deferred external class
	SYSTEM_RUNTIME_REMOTING_SERVICES_REMOTINGCLIENTPROXY

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
	SYSTEM_IDISPOSABLE

feature -- Access

	frozen get_enable_cookies: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_EnableCookies"
		end

	frozen get_path: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_Path"
		end

	frozen get_username: STRING is
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

	frozen get_password: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_Password"
		end

	frozen get_domain: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_Domain"
		end

	frozen get_user_agent: STRING is
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

	frozen get_cookies: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_Cookies"
		end

	frozen get_url: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_Url"
		end

	frozen get_proxy_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"get_ProxyName"
		end

feature -- Element Change

	frozen set_proxy_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_ProxyName"
		end

	frozen set_path (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_Path"
		end

	frozen set_domain (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_Domain"
		end

	frozen set_username (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Services.RemotingClientProxy"
		alias
			"set_Username"
		end

	frozen set_url (value: STRING) is
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

	frozen set_user_agent (value: STRING) is
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

	frozen set_password (value: STRING) is
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

	frozen configure_proxy (type: SYSTEM_TYPE; url: STRING) is
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

end -- class SYSTEM_RUNTIME_REMOTING_SERVICES_REMOTINGCLIENTPROXY
