indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Security.DefaultAuthenticationEventArgs"

frozen external class
	SYSTEM_WEB_SECURITY_DEFAULTAUTHENTICATIONEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_defaultauthenticationeventargs

feature {NONE} -- Initialization

	frozen make_defaultauthenticationeventargs (context: SYSTEM_WEB_HTTPCONTEXT) is
		external
			"IL creator signature (System.Web.HttpContext) use System.Web.Security.DefaultAuthenticationEventArgs"
		end

feature -- Access

	frozen get_context: SYSTEM_WEB_HTTPCONTEXT is
		external
			"IL signature (): System.Web.HttpContext use System.Web.Security.DefaultAuthenticationEventArgs"
		alias
			"get_Context"
		end

end -- class SYSTEM_WEB_SECURITY_DEFAULTAUTHENTICATIONEVENTARGS
