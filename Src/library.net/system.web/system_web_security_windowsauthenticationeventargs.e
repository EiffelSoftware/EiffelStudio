indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Security.WindowsAuthenticationEventArgs"

frozen external class
	SYSTEM_WEB_SECURITY_WINDOWSAUTHENTICATIONEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_windowsauthenticationeventargs

feature {NONE} -- Initialization

	frozen make_windowsauthenticationeventargs (identity: SYSTEM_SECURITY_PRINCIPAL_WINDOWSIDENTITY; context: SYSTEM_WEB_HTTPCONTEXT) is
		external
			"IL creator signature (System.Security.Principal.WindowsIdentity, System.Web.HttpContext) use System.Web.Security.WindowsAuthenticationEventArgs"
		end

feature -- Access

	frozen get_user: SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL is
		external
			"IL signature (): System.Security.Principal.IPrincipal use System.Web.Security.WindowsAuthenticationEventArgs"
		alias
			"get_User"
		end

	frozen get_context: SYSTEM_WEB_HTTPCONTEXT is
		external
			"IL signature (): System.Web.HttpContext use System.Web.Security.WindowsAuthenticationEventArgs"
		alias
			"get_Context"
		end

	frozen get_identity: SYSTEM_SECURITY_PRINCIPAL_WINDOWSIDENTITY is
		external
			"IL signature (): System.Security.Principal.WindowsIdentity use System.Web.Security.WindowsAuthenticationEventArgs"
		alias
			"get_Identity"
		end

feature -- Element Change

	frozen set_user (value: SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL) is
		external
			"IL signature (System.Security.Principal.IPrincipal): System.Void use System.Web.Security.WindowsAuthenticationEventArgs"
		alias
			"set_User"
		end

end -- class SYSTEM_WEB_SECURITY_WINDOWSAUTHENTICATIONEVENTARGS
