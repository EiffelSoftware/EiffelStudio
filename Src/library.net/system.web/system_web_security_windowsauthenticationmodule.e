indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Security.WindowsAuthenticationModule"

frozen external class
	SYSTEM_WEB_SECURITY_WINDOWSAUTHENTICATIONMODULE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_WEB_IHTTPMODULE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Security.WindowsAuthenticationModule"
		end

feature -- Element Change

	frozen remove_authenticate (value: SYSTEM_WEB_SECURITY_WINDOWSAUTHENTICATIONEVENTHANDLER) is
		external
			"IL signature (System.Web.Security.WindowsAuthenticationEventHandler): System.Void use System.Web.Security.WindowsAuthenticationModule"
		alias
			"remove_Authenticate"
		end

	frozen add_authenticate (value: SYSTEM_WEB_SECURITY_WINDOWSAUTHENTICATIONEVENTHANDLER) is
		external
			"IL signature (System.Web.Security.WindowsAuthenticationEventHandler): System.Void use System.Web.Security.WindowsAuthenticationModule"
		alias
			"add_Authenticate"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Security.WindowsAuthenticationModule"
		alias
			"GetHashCode"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Web.Security.WindowsAuthenticationModule"
		alias
			"Dispose"
		end

	frozen init (app: SYSTEM_WEB_HTTPAPPLICATION) is
		external
			"IL signature (System.Web.HttpApplication): System.Void use System.Web.Security.WindowsAuthenticationModule"
		alias
			"Init"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.Security.WindowsAuthenticationModule"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.Security.WindowsAuthenticationModule"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.Security.WindowsAuthenticationModule"
		alias
			"Finalize"
		end

end -- class SYSTEM_WEB_SECURITY_WINDOWSAUTHENTICATIONMODULE
