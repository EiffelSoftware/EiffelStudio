indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Security.FormsAuthentication"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_FORMS_AUTHENTICATION

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Security.FormsAuthentication"
		end

feature -- Access

	frozen get_forms_cookie_path: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Web.Security.FormsAuthentication"
		alias
			"get_FormsCookiePath"
		end

	frozen get_forms_cookie_name: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Web.Security.FormsAuthentication"
		alias
			"get_FormsCookieName"
		end

feature -- Basic Operations

	frozen get_auth_cookie_string_boolean_string (user_name: SYSTEM_STRING; create_persistent_cookie: BOOLEAN; str_cookie_path: SYSTEM_STRING): WEB_HTTP_COOKIE is
		external
			"IL static signature (System.String, System.Boolean, System.String): System.Web.HttpCookie use System.Web.Security.FormsAuthentication"
		alias
			"GetAuthCookie"
		end

	frozen decrypt (encrypted_ticket: SYSTEM_STRING): WEB_FORMS_AUTHENTICATION_TICKET is
		external
			"IL static signature (System.String): System.Web.Security.FormsAuthenticationTicket use System.Web.Security.FormsAuthentication"
		alias
			"Decrypt"
		end

	frozen get_redirect_url (user_name: SYSTEM_STRING; create_persistent_cookie: BOOLEAN): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.Boolean): System.String use System.Web.Security.FormsAuthentication"
		alias
			"GetRedirectUrl"
		end

	frozen initialize is
		external
			"IL static signature (): System.Void use System.Web.Security.FormsAuthentication"
		alias
			"Initialize"
		end

	frozen set_auth_cookie_string_boolean_string (user_name: SYSTEM_STRING; create_persistent_cookie: BOOLEAN; str_cookie_path: SYSTEM_STRING) is
		external
			"IL static signature (System.String, System.Boolean, System.String): System.Void use System.Web.Security.FormsAuthentication"
		alias
			"SetAuthCookie"
		end

	frozen redirect_from_login_page (user_name: SYSTEM_STRING; create_persistent_cookie: BOOLEAN) is
		external
			"IL static signature (System.String, System.Boolean): System.Void use System.Web.Security.FormsAuthentication"
		alias
			"RedirectFromLoginPage"
		end

	frozen get_auth_cookie (user_name: SYSTEM_STRING; create_persistent_cookie: BOOLEAN): WEB_HTTP_COOKIE is
		external
			"IL static signature (System.String, System.Boolean): System.Web.HttpCookie use System.Web.Security.FormsAuthentication"
		alias
			"GetAuthCookie"
		end

	frozen set_auth_cookie (user_name: SYSTEM_STRING; create_persistent_cookie: BOOLEAN) is
		external
			"IL static signature (System.String, System.Boolean): System.Void use System.Web.Security.FormsAuthentication"
		alias
			"SetAuthCookie"
		end

	frozen authenticate (name: SYSTEM_STRING; password: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Web.Security.FormsAuthentication"
		alias
			"Authenticate"
		end

	frozen renew_ticket_if_old (t_old: WEB_FORMS_AUTHENTICATION_TICKET): WEB_FORMS_AUTHENTICATION_TICKET is
		external
			"IL static signature (System.Web.Security.FormsAuthenticationTicket): System.Web.Security.FormsAuthenticationTicket use System.Web.Security.FormsAuthentication"
		alias
			"RenewTicketIfOld"
		end

	frozen hash_password_for_storing_in_config_file (password: SYSTEM_STRING; password_format: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.Web.Security.FormsAuthentication"
		alias
			"HashPasswordForStoringInConfigFile"
		end

	frozen sign_out is
		external
			"IL static signature (): System.Void use System.Web.Security.FormsAuthentication"
		alias
			"SignOut"
		end

	frozen encrypt (ticket: WEB_FORMS_AUTHENTICATION_TICKET): SYSTEM_STRING is
		external
			"IL static signature (System.Web.Security.FormsAuthenticationTicket): System.String use System.Web.Security.FormsAuthentication"
		alias
			"Encrypt"
		end

	frozen redirect_from_login_page_string_boolean_string (user_name: SYSTEM_STRING; create_persistent_cookie: BOOLEAN; str_cookie_path: SYSTEM_STRING) is
		external
			"IL static signature (System.String, System.Boolean, System.String): System.Void use System.Web.Security.FormsAuthentication"
		alias
			"RedirectFromLoginPage"
		end

end -- class WEB_FORMS_AUTHENTICATION
