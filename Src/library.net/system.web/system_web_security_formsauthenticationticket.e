indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Security.FormsAuthenticationTicket"

frozen external class
	SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONTICKET

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (name: STRING; is_persistent: BOOLEAN; timeout: INTEGER) is
		external
			"IL creator signature (System.String, System.Boolean, System.Int32) use System.Web.Security.FormsAuthenticationTicket"
		end

	frozen make (version: INTEGER; name: STRING; issue_date: SYSTEM_DATETIME; expiration: SYSTEM_DATETIME; is_persistent: BOOLEAN; user_data: STRING) is
		external
			"IL creator signature (System.Int32, System.String, System.DateTime, System.DateTime, System.Boolean, System.String) use System.Web.Security.FormsAuthenticationTicket"
		end

	frozen make_1 (version: INTEGER; name: STRING; issue_date: SYSTEM_DATETIME; expiration: SYSTEM_DATETIME; is_persistent: BOOLEAN; user_data: STRING; cookie_path: STRING) is
		external
			"IL creator signature (System.Int32, System.String, System.DateTime, System.DateTime, System.Boolean, System.String, System.String) use System.Web.Security.FormsAuthenticationTicket"
		end

feature -- Access

	frozen get_is_persistent: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.Security.FormsAuthenticationTicket"
		alias
			"get_IsPersistent"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Web.Security.FormsAuthenticationTicket"
		alias
			"get_Name"
		end

	frozen get_user_data: STRING is
		external
			"IL signature (): System.String use System.Web.Security.FormsAuthenticationTicket"
		alias
			"get_UserData"
		end

	frozen get_expired: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.Security.FormsAuthenticationTicket"
		alias
			"get_Expired"
		end

	frozen get_expiration: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Web.Security.FormsAuthenticationTicket"
		alias
			"get_Expiration"
		end

	frozen get_cookie_path: STRING is
		external
			"IL signature (): System.String use System.Web.Security.FormsAuthenticationTicket"
		alias
			"get_CookiePath"
		end

	frozen get_version: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Security.FormsAuthenticationTicket"
		alias
			"get_Version"
		end

	frozen get_issue_date: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Web.Security.FormsAuthenticationTicket"
		alias
			"get_IssueDate"
		end

end -- class SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONTICKET
