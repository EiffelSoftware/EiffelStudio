indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Security.FormsAuthenticationEventArgs"

frozen external class
	SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_formsauthenticationeventargs

feature {NONE} -- Initialization

	frozen make_formsauthenticationeventargs (context: SYSTEM_WEB_HTTPCONTEXT) is
		external
			"IL creator signature (System.Web.HttpContext) use System.Web.Security.FormsAuthenticationEventArgs"
		end

feature -- Access

	frozen get_user: SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL is
		external
			"IL signature (): System.Security.Principal.IPrincipal use System.Web.Security.FormsAuthenticationEventArgs"
		alias
			"get_User"
		end

	frozen get_context: SYSTEM_WEB_HTTPCONTEXT is
		external
			"IL signature (): System.Web.HttpContext use System.Web.Security.FormsAuthenticationEventArgs"
		alias
			"get_Context"
		end

feature -- Element Change

	frozen set_user (value: SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL) is
		external
			"IL signature (System.Security.Principal.IPrincipal): System.Void use System.Web.Security.FormsAuthenticationEventArgs"
		alias
			"set_User"
		end

end -- class SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONEVENTARGS
