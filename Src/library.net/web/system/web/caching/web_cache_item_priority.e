indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Caching.CacheItemPriority"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_CACHE_ITEM_PRIORITY

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen not_removable: WEB_CACHE_ITEM_PRIORITY is
		external
			"IL enum signature :System.Web.Caching.CacheItemPriority use System.Web.Caching.CacheItemPriority"
		alias
			"6"
		end

	frozen above_normal: WEB_CACHE_ITEM_PRIORITY is
		external
			"IL enum signature :System.Web.Caching.CacheItemPriority use System.Web.Caching.CacheItemPriority"
		alias
			"4"
		end

	frozen high: WEB_CACHE_ITEM_PRIORITY is
		external
			"IL enum signature :System.Web.Caching.CacheItemPriority use System.Web.Caching.CacheItemPriority"
		alias
			"5"
		end

	frozen below_normal: WEB_CACHE_ITEM_PRIORITY is
		external
			"IL enum signature :System.Web.Caching.CacheItemPriority use System.Web.Caching.CacheItemPriority"
		alias
			"2"
		end

	frozen normal: WEB_CACHE_ITEM_PRIORITY is
		external
			"IL enum signature :System.Web.Caching.CacheItemPriority use System.Web.Caching.CacheItemPriority"
		alias
			"3"
		end

	frozen default_: WEB_CACHE_ITEM_PRIORITY is
		external
			"IL enum signature :System.Web.Caching.CacheItemPriority use System.Web.Caching.CacheItemPriority"
		alias
			"3"
		end

	frozen low: WEB_CACHE_ITEM_PRIORITY is
		external
			"IL enum signature :System.Web.Caching.CacheItemPriority use System.Web.Caching.CacheItemPriority"
		alias
			"1"
		end

end -- class WEB_CACHE_ITEM_PRIORITY
