indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Caching.CacheItemRemovedReason"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_CACHING_CACHEITEMREMOVEDREASON

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

	frozen underused: SYSTEM_WEB_CACHING_CACHEITEMREMOVEDREASON is
		external
			"IL enum signature :System.Web.Caching.CacheItemRemovedReason use System.Web.Caching.CacheItemRemovedReason"
		alias
			"3"
		end

	frozen removed: SYSTEM_WEB_CACHING_CACHEITEMREMOVEDREASON is
		external
			"IL enum signature :System.Web.Caching.CacheItemRemovedReason use System.Web.Caching.CacheItemRemovedReason"
		alias
			"1"
		end

	frozen expired: SYSTEM_WEB_CACHING_CACHEITEMREMOVEDREASON is
		external
			"IL enum signature :System.Web.Caching.CacheItemRemovedReason use System.Web.Caching.CacheItemRemovedReason"
		alias
			"2"
		end

	frozen dependency_changed: SYSTEM_WEB_CACHING_CACHEITEMREMOVEDREASON is
		external
			"IL enum signature :System.Web.Caching.CacheItemRemovedReason use System.Web.Caching.CacheItemRemovedReason"
		alias
			"4"
		end

end -- class SYSTEM_WEB_CACHING_CACHEITEMREMOVEDREASON
