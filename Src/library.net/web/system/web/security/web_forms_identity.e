indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Security.FormsIdentity"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_FORMS_IDENTITY

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IIDENTITY

create
	make

feature {NONE} -- Initialization

	frozen make (ticket: WEB_FORMS_AUTHENTICATION_TICKET) is
		external
			"IL creator signature (System.Web.Security.FormsAuthenticationTicket) use System.Web.Security.FormsIdentity"
		end

feature -- Access

	frozen get_ticket: WEB_FORMS_AUTHENTICATION_TICKET is
		external
			"IL signature (): System.Web.Security.FormsAuthenticationTicket use System.Web.Security.FormsIdentity"
		alias
			"get_Ticket"
		end

	frozen get_is_authenticated: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.Security.FormsIdentity"
		alias
			"get_IsAuthenticated"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Security.FormsIdentity"
		alias
			"get_Name"
		end

	frozen get_authentication_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Security.FormsIdentity"
		alias
			"get_AuthenticationType"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Security.FormsIdentity"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Security.FormsIdentity"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.Security.FormsIdentity"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.Security.FormsIdentity"
		alias
			"Finalize"
		end

end -- class WEB_FORMS_IDENTITY
