indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Security.FormsAuthenticationModule"

frozen external class
	SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONMODULE

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
			"IL creator use System.Web.Security.FormsAuthenticationModule"
		end

feature -- Element Change

	frozen remove_authenticate (value: SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONEVENTHANDLER) is
		external
			"IL signature (System.Web.Security.FormsAuthenticationEventHandler): System.Void use System.Web.Security.FormsAuthenticationModule"
		alias
			"remove_Authenticate"
		end

	frozen add_authenticate (value: SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONEVENTHANDLER) is
		external
			"IL signature (System.Web.Security.FormsAuthenticationEventHandler): System.Void use System.Web.Security.FormsAuthenticationModule"
		alias
			"add_Authenticate"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Security.FormsAuthenticationModule"
		alias
			"GetHashCode"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Web.Security.FormsAuthenticationModule"
		alias
			"Dispose"
		end

	frozen on_enter (source: ANY; event_args: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Web.Security.FormsAuthenticationModule"
		alias
			"OnEnter"
		end

	frozen init (app: SYSTEM_WEB_HTTPAPPLICATION) is
		external
			"IL signature (System.Web.HttpApplication): System.Void use System.Web.Security.FormsAuthenticationModule"
		alias
			"Init"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.Security.FormsAuthenticationModule"
		alias
			"ToString"
		end

	frozen on_leave (source: ANY; event_args: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Web.Security.FormsAuthenticationModule"
		alias
			"OnLeave"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.Security.FormsAuthenticationModule"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.Security.FormsAuthenticationModule"
		alias
			"Finalize"
		end

end -- class SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONMODULE
