indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Security.FormsAuthentication"

frozen external class
	SYSTEM_WEB_SECURITY_FORMSAUTHENTICATION

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Security.FormsAuthentication"
		end

feature -- Access

	frozen get_forms_cookie_path: STRING is
		external
			"IL static signature (): System.String use System.Web.Security.FormsAuthentication"
		alias
			"get_FormsCookiePath"
		end

	frozen get_forms_cookie_name: STRING is
		external
			"IL static signature (): System.String use System.Web.Security.FormsAuthentication"
		alias
			"get_FormsCookieName"
		end

feature -- Basic Operations

	frozen get_auth_cookie_string_boolean_string (user_name: STRING; create_persistent_cookie: BOOLEAN; str_cookie_path: STRING): SYSTEM_WEB_HTTPCOOKIE is
		external
			"IL static signature (System.String, System.Boolean, System.String): System.Web.HttpCookie use System.Web.Security.FormsAuthentication"
		alias
			"GetAuthCookie"
		end

	frozen decrypt (str_encrypted: STRING): SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONTICKET is
		external
			"IL static signature (System.String): System.Web.Security.FormsAuthenticationTicket use System.Web.Security.FormsAuthentication"
		alias
			"Decrypt"
		end

	frozen get_redirect_url (user_name: STRING; create_persistent_cookie: BOOLEAN): STRING is
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

	frozen set_auth_cookie_string_boolean_string (user_name: STRING; create_persistent_cookie: BOOLEAN; str_cookie_path: STRING) is
		external
			"IL static signature (System.String, System.Boolean, System.String): System.Void use System.Web.Security.FormsAuthentication"
		alias
			"SetAuthCookie"
		end

	frozen redirect_from_login_page (user_name: STRING; create_persistent_cookie: BOOLEAN) is
		external
			"IL static signature (System.String, System.Boolean): System.Void use System.Web.Security.FormsAuthentication"
		alias
			"RedirectFromLoginPage"
		end

	frozen get_auth_cookie (user_name: STRING; create_persistent_cookie: BOOLEAN): SYSTEM_WEB_HTTPCOOKIE is
		external
			"IL static signature (System.String, System.Boolean): System.Web.HttpCookie use System.Web.Security.FormsAuthentication"
		alias
			"GetAuthCookie"
		end

	frozen set_auth_cookie (user_name: STRING; create_persistent_cookie: BOOLEAN) is
		external
			"IL static signature (System.String, System.Boolean): System.Void use System.Web.Security.FormsAuthentication"
		alias
			"SetAuthCookie"
		end

	frozen authenticate (name: STRING; password: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Web.Security.FormsAuthentication"
		alias
			"Authenticate"
		end

	frozen renew_ticket_if_old (t_old: SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONTICKET): SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONTICKET is
		external
			"IL static signature (System.Web.Security.FormsAuthenticationTicket): System.Web.Security.FormsAuthenticationTicket use System.Web.Security.FormsAuthentication"
		alias
			"RenewTicketIfOld"
		end

	frozen hash_password_for_storing_in_config_file (password: STRING; password_format: STRING): STRING is
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

	frozen encrypt (ticket: SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONTICKET): STRING is
		external
			"IL static signature (System.Web.Security.FormsAuthenticationTicket): System.String use System.Web.Security.FormsAuthentication"
		alias
			"Encrypt"
		end

	frozen redirect_from_login_page_string_boolean_string (user_name: STRING; create_persistent_cookie: BOOLEAN; str_cookie_path: STRING) is
		external
			"IL static signature (System.String, System.Boolean, System.String): System.Void use System.Web.Security.FormsAuthentication"
		alias
			"RedirectFromLoginPage"
		end

end -- class SYSTEM_WEB_SECURITY_FORMSAUTHENTICATION
