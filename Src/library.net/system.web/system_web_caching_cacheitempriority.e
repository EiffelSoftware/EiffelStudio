indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Caching.CacheItemPriority"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_CACHING_CACHEITEMPRIORITY

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen not_removable: SYSTEM_WEB_CACHING_CACHEITEMPRIORITY is
		external
			"IL enum signature :System.Web.Caching.CacheItemPriority use System.Web.Caching.CacheItemPriority"
		alias
			"6"
		end

	frozen above_normal: SYSTEM_WEB_CACHING_CACHEITEMPRIORITY is
		external
			"IL enum signature :System.Web.Caching.CacheItemPriority use System.Web.Caching.CacheItemPriority"
		alias
			"4"
		end

	frozen high: SYSTEM_WEB_CACHING_CACHEITEMPRIORITY is
		external
			"IL enum signature :System.Web.Caching.CacheItemPriority use System.Web.Caching.CacheItemPriority"
		alias
			"5"
		end

	frozen below_normal: SYSTEM_WEB_CACHING_CACHEITEMPRIORITY is
		external
			"IL enum signature :System.Web.Caching.CacheItemPriority use System.Web.Caching.CacheItemPriority"
		alias
			"2"
		end

	frozen normal: SYSTEM_WEB_CACHING_CACHEITEMPRIORITY is
		external
			"IL enum signature :System.Web.Caching.CacheItemPriority use System.Web.Caching.CacheItemPriority"
		alias
			"3"
		end

	frozen default: SYSTEM_WEB_CACHING_CACHEITEMPRIORITY is
		external
			"IL enum signature :System.Web.Caching.CacheItemPriority use System.Web.Caching.CacheItemPriority"
		alias
			"3"
		end

	frozen low: SYSTEM_WEB_CACHING_CACHEITEMPRIORITY is
		external
			"IL enum signature :System.Web.Caching.CacheItemPriority use System.Web.Caching.CacheItemPriority"
		alias
			"1"
		end

end -- class SYSTEM_WEB_CACHING_CACHEITEMPRIORITY
