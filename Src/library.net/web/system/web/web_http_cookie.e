indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpCookie"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_COOKIE

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Web.HttpCookie"
		end

	frozen make_1 (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Web.HttpCookie"
		end

feature -- Access

	frozen get_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpCookie"
		alias
			"get_Path"
		end

	frozen get_domain: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpCookie"
		alias
			"get_Domain"
		end

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpCookie"
		alias
			"get_Value"
		end

	frozen get_has_keys: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpCookie"
		alias
			"get_HasKeys"
		end

	frozen get_values: SYSTEM_DLL_NAME_VALUE_COLLECTION is
		external
			"IL signature (): System.Collections.Specialized.NameValueCollection use System.Web.HttpCookie"
		alias
			"get_Values"
		end

	frozen get_secure: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpCookie"
		alias
			"get_Secure"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpCookie"
		alias
			"get_Name"
		end

	frozen get_item (key: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpCookie"
		alias
			"get_Item"
		end

	frozen get_expires: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Web.HttpCookie"
		alias
			"get_Expires"
		end

feature -- Element Change

	frozen set_secure (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.HttpCookie"
		alias
			"set_Secure"
		end

	frozen set_domain (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpCookie"
		alias
			"set_Domain"
		end

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpCookie"
		alias
			"set_Name"
		end

	frozen set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpCookie"
		alias
			"set_Value"
		end

	frozen set_path (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpCookie"
		alias
			"set_Path"
		end

	frozen set_item (key: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.HttpCookie"
		alias
			"set_Item"
		end

	frozen set_expires (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Web.HttpCookie"
		alias
			"set_Expires"
		end

end -- class WEB_HTTP_COOKIE
