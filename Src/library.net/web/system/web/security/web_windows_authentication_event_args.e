indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Security.WindowsAuthenticationEventArgs"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_WINDOWS_AUTHENTICATION_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_web_windows_authentication_event_args

feature {NONE} -- Initialization

	frozen make_web_windows_authentication_event_args (identity: WINDOWS_IDENTITY; context: WEB_HTTP_CONTEXT) is
		external
			"IL creator signature (System.Security.Principal.WindowsIdentity, System.Web.HttpContext) use System.Web.Security.WindowsAuthenticationEventArgs"
		end

feature -- Access

	frozen get_user: IPRINCIPAL is
		external
			"IL signature (): System.Security.Principal.IPrincipal use System.Web.Security.WindowsAuthenticationEventArgs"
		alias
			"get_User"
		end

	frozen get_context: WEB_HTTP_CONTEXT is
		external
			"IL signature (): System.Web.HttpContext use System.Web.Security.WindowsAuthenticationEventArgs"
		alias
			"get_Context"
		end

	frozen get_identity: WINDOWS_IDENTITY is
		external
			"IL signature (): System.Security.Principal.WindowsIdentity use System.Web.Security.WindowsAuthenticationEventArgs"
		alias
			"get_Identity"
		end

feature -- Element Change

	frozen set_user (value: IPRINCIPAL) is
		external
			"IL signature (System.Security.Principal.IPrincipal): System.Void use System.Web.Security.WindowsAuthenticationEventArgs"
		alias
			"set_User"
		end

end -- class WEB_WINDOWS_AUTHENTICATION_EVENT_ARGS
