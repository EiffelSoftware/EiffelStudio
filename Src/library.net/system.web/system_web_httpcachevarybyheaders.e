indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpCacheVaryByHeaders"

frozen external class
	SYSTEM_WEB_HTTPCACHEVARYBYHEADERS

create {NONE}

feature -- Access

	frozen get_user_agent: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpCacheVaryByHeaders"
		alias
			"get_UserAgent"
		end

	frozen get_item (header: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Web.HttpCacheVaryByHeaders"
		alias
			"get_Item"
		end

	frozen get_accept_types: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpCacheVaryByHeaders"
		alias
			"get_AcceptTypes"
		end

	frozen get_user_char_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpCacheVaryByHeaders"
		alias
			"get_UserCharSet"
		end

	frozen get_user_language: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpCacheVaryByHeaders"
		alias
			"get_UserLanguage"
		end

feature -- Element Change

	frozen set_user_agent (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.HttpCacheVaryByHeaders"
		alias
			"set_UserAgent"
		end

	frozen set_user_char_set (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.HttpCacheVaryByHeaders"
		alias
			"set_UserCharSet"
		end

	frozen set_accept_types (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.HttpCacheVaryByHeaders"
		alias
			"set_AcceptTypes"
		end

	frozen set_item (header: STRING; value: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Web.HttpCacheVaryByHeaders"
		alias
			"set_Item"
		end

	frozen set_user_language (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.HttpCacheVaryByHeaders"
		alias
			"set_UserLanguage"
		end

feature -- Basic Operations

	frozen vary_by_unspecified_parameters is
		external
			"IL signature (): System.Void use System.Web.HttpCacheVaryByHeaders"
		alias
			"VaryByUnspecifiedParameters"
		end

end -- class SYSTEM_WEB_HTTPCACHEVARYBYHEADERS
