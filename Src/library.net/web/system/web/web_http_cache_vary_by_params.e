indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpCacheVaryByParams"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_CACHE_VARY_BY_PARAMS

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_item (header: SYSTEM_STRING): BOOLEAN is
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

	frozen set_item (header: SYSTEM_STRING; value: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Web.HttpCacheVaryByParams"
		alias
			"set_Item"
		end

end -- class WEB_HTTP_CACHE_VARY_BY_PARAMS
