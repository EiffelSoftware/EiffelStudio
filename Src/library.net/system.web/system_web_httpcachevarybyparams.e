indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpCacheVaryByParams"

frozen external class
	SYSTEM_WEB_HTTPCACHEVARYBYPARAMS

create {NONE}

feature -- Access

	frozen get_item (header: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Web.HttpCacheVaryByParams"
		alias
			"get_Item"
		end

	frozen get_ignore_params: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpCacheVaryByParams"
		alias
			"get_IgnoreParams"
		end

feature -- Element Change

	frozen set_ignore_params (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.HttpCacheVaryByParams"
		alias
			"set_IgnoreParams"
		end

	frozen set_item (header: STRING; value: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Web.HttpCacheVaryByParams"
		alias
			"set_Item"
		end

end -- class SYSTEM_WEB_HTTPCACHEVARYBYPARAMS
