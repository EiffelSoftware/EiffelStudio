indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpCacheRevalidation"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_HTTP_CACHE_REVALIDATION

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen all_caches: WEB_HTTP_CACHE_REVALIDATION is
		external
			"IL enum signature :System.Web.HttpCacheRevalidation use System.Web.HttpCacheRevalidation"
		alias
			"1"
		end

	frozen proxy_caches: WEB_HTTP_CACHE_REVALIDATION is
		external
			"IL enum signature :System.Web.HttpCacheRevalidation use System.Web.HttpCacheRevalidation"
		alias
			"2"
		end

	frozen none: WEB_HTTP_CACHE_REVALIDATION is
		external
			"IL enum signature :System.Web.HttpCacheRevalidation use System.Web.HttpCacheRevalidation"
		alias
			"3"
		end

end -- class WEB_HTTP_CACHE_REVALIDATION
