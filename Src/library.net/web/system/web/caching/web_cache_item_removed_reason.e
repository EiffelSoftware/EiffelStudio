indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Caching.CacheItemRemovedReason"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_CACHE_ITEM_REMOVED_REASON

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen underused: WEB_CACHE_ITEM_REMOVED_REASON is
		external
			"IL enum signature :System.Web.Caching.CacheItemRemovedReason use System.Web.Caching.CacheItemRemovedReason"
		alias
			"3"
		end

	frozen removed: WEB_CACHE_ITEM_REMOVED_REASON is
		external
			"IL enum signature :System.Web.Caching.CacheItemRemovedReason use System.Web.Caching.CacheItemRemovedReason"
		alias
			"1"
		end

	frozen expired: WEB_CACHE_ITEM_REMOVED_REASON is
		external
			"IL enum signature :System.Web.Caching.CacheItemRemovedReason use System.Web.Caching.CacheItemRemovedReason"
		alias
			"2"
		end

	frozen dependency_changed: WEB_CACHE_ITEM_REMOVED_REASON is
		external
			"IL enum signature :System.Web.Caching.CacheItemRemovedReason use System.Web.Caching.CacheItemRemovedReason"
		alias
			"4"
		end

end -- class WEB_CACHE_ITEM_REMOVED_REASON
