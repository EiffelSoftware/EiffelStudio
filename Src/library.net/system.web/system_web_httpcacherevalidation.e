indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpCacheRevalidation"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_HTTPCACHEREVALIDATION

inherit
	ENUM
	SYSTEM_IFORMATTABLE
		rename
			equals as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			equals as equals_object
		end

feature -- Access

	frozen all_caches: SYSTEM_WEB_HTTPCACHEREVALIDATION is
		external
			"IL enum signature :System.Web.HttpCacheRevalidation use System.Web.HttpCacheRevalidation"
		alias
			"1"
		end

	frozen proxy_caches: SYSTEM_WEB_HTTPCACHEREVALIDATION is
		external
			"IL enum signature :System.Web.HttpCacheRevalidation use System.Web.HttpCacheRevalidation"
		alias
			"2"
		end

	frozen none: SYSTEM_WEB_HTTPCACHEREVALIDATION is
		external
			"IL enum signature :System.Web.HttpCacheRevalidation use System.Web.HttpCacheRevalidation"
		alias
			"3"
		end

end -- class SYSTEM_WEB_HTTPCACHEREVALIDATION
