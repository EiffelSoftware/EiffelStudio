indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Security.PassportAuthenticationEventArgs"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_PASSPORT_AUTHENTICATION_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_web_passport_authentication_event_args

feature {NONE} -- Initialization

	frozen make_web_passport_authentication_event_args (identity: WEB_PASSPORT_IDENTITY; context: WEB_HTTP_CONTEXT) is
		external
			"IL creator signature (System.Web.Security.PassportIdentity, System.Web.HttpContext) use System.Web.Security.PassportAuthenticationEventArgs"
		end

feature -- Access

	frozen get_user: IPRINCIPAL is
		external
			"IL signature (): System.Security.Principal.IPrincipal use System.Web.Security.PassportAuthenticationEventArgs"
		alias
			"get_User"
		end

	frozen get_context: WEB_HTTP_CONTEXT is
		external
			"IL signature (): System.Web.HttpContext use System.Web.Security.PassportAuthenticationEventArgs"
		alias
			"get_Context"
		end

	frozen get_identity: WEB_PASSPORT_IDENTITY is
		external
			"IL signature (): System.Web.Security.PassportIdentity use System.Web.Security.PassportAuthenticationEventArgs"
		alias
			"get_Identity"
		end

feature -- Element Change

	frozen set_user (value: IPRINCIPAL) is
		external
			"IL signature (System.Security.Principal.IPrincipal): System.Void use System.Web.Security.PassportAuthenticationEventArgs"
		alias
			"set_User"
		end

end -- class WEB_PASSPORT_AUTHENTICATION_EVENT_ARGS
