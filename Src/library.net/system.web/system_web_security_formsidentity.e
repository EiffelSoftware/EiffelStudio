indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Security.FormsIdentity"

frozen external class
	SYSTEM_WEB_SECURITY_FORMSIDENTITY

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_SECURITY_PRINCIPAL_IIDENTITY

create
	make

feature {NONE} -- Initialization

	frozen make (ticket: SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONTICKET) is
		external
			"IL creator signature (System.Web.Security.FormsAuthenticationTicket) use System.Web.Security.FormsIdentity"
		end

feature -- Access

	frozen get_ticket: SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONTICKET is
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

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Web.Security.FormsIdentity"
		alias
			"get_Name"
		end

	frozen get_authentication_type: STRING is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.Security.FormsIdentity"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_WEB_SECURITY_FORMSIDENTITY
