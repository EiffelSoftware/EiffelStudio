indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpCookie"

frozen external class
	SYSTEM_WEB_HTTPCOOKIE

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (name: STRING) is
		external
			"IL creator signature (System.String) use System.Web.HttpCookie"
		end

	frozen make_1 (name: STRING; value: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Web.HttpCookie"
		end

feature -- Access

	frozen get_path: STRING is
		external
			"IL signature (): System.String use System.Web.HttpCookie"
		alias
			"get_Path"
		end

	frozen get_domain: STRING is
		external
			"IL signature (): System.String use System.Web.HttpCookie"
		alias
			"get_Domain"
		end

	frozen get_value: STRING is
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

	frozen get_values: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION is
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

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Web.HttpCookie"
		alias
			"get_Name"
		end

	frozen get_item (key: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpCookie"
		alias
			"get_Item"
		end

	frozen get_expires: SYSTEM_DATETIME is
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

	frozen set_domain (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpCookie"
		alias
			"set_Domain"
		end

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpCookie"
		alias
			"set_Name"
		end

	frozen set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpCookie"
		alias
			"set_Value"
		end

	frozen set_path (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpCookie"
		alias
			"set_Path"
		end

	frozen set_item (key: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.HttpCookie"
		alias
			"set_Item"
		end

	frozen set_expires (value: SYSTEM_DATETIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Web.HttpCookie"
		alias
			"set_Expires"
		end

end -- class SYSTEM_WEB_HTTPCOOKIE
