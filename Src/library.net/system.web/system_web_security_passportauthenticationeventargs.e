indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Security.PassportAuthenticationEventArgs"

frozen external class
	SYSTEM_WEB_SECURITY_PASSPORTAUTHENTICATIONEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_passportauthenticationeventargs

feature {NONE} -- Initialization

	frozen make_passportauthenticationeventargs (identity: SYSTEM_WEB_SECURITY_PASSPORTIDENTITY; context: SYSTEM_WEB_HTTPCONTEXT) is
		external
			"IL creator signature (System.Web.Security.PassportIdentity, System.Web.HttpContext) use System.Web.Security.PassportAuthenticationEventArgs"
		end

feature -- Access

	frozen get_user: SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL is
		external
			"IL signature (): System.Security.Principal.IPrincipal use System.Web.Security.PassportAuthenticationEventArgs"
		alias
			"get_User"
		end

	frozen get_context: SYSTEM_WEB_HTTPCONTEXT is
		external
			"IL signature (): System.Web.HttpContext use System.Web.Security.PassportAuthenticationEventArgs"
		alias
			"get_Context"
		end

	frozen get_identity: SYSTEM_WEB_SECURITY_PASSPORTIDENTITY is
		external
			"IL signature (): System.Web.Security.PassportIdentity use System.Web.Security.PassportAuthenticationEventArgs"
		alias
			"get_Identity"
		end

feature -- Element Change

	frozen set_user (value: SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL) is
		external
			"IL signature (System.Security.Principal.IPrincipal): System.Void use System.Web.Security.PassportAuthenticationEventArgs"
		alias
			"set_User"
		end

end -- class SYSTEM_WEB_SECURITY_PASSPORTAUTHENTICATIONEVENTARGS
