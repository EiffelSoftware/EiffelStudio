indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Caching.Cache"

frozen external class
	SYSTEM_WEB_CACHING_CACHE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create {NONE}

feature -- Access

	frozen get_item (key: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Web.Caching.Cache"
		alias
			"get_Item"
		end

	frozen no_absolute_expiration: SYSTEM_DATETIME is
		external
			"IL static_field signature :System.DateTime use System.Web.Caching.Cache"
		alias
			"NoAbsoluteExpiration"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Caching.Cache"
		alias
			"get_Count"
		end

	frozen no_sliding_expiration: SYSTEM_TIMESPAN is
		external
			"IL static_field signature :System.TimeSpan use System.Web.Caching.Cache"
		alias
			"NoSlidingExpiration"
		end

feature -- Element Change

	frozen set_item (key: STRING; value: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Web.Caching.Cache"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.Caching.Cache"
		alias
			"ToString"
		end

	frozen add (key: STRING; value: ANY; dependencies: SYSTEM_WEB_CACHING_CACHEDEPENDENCY; absolute_expiration: SYSTEM_DATETIME; sliding_expiration: SYSTEM_TIMESPAN; priority: SYSTEM_WEB_CACHING_CACHEITEMPRIORITY; priority_decay: SYSTEM_WEB_CACHING_CACHEITEMPRIORITYDECAY; on_remove_callback: SYSTEM_WEB_CACHING_CACHEITEMREMOVEDCALLBACK): ANY is
		external
			"IL signature (System.String, System.Object, System.Web.Caching.CacheDependency, System.DateTime, System.TimeSpan, System.Web.Caching.CacheItemPriority, System.Web.Caching.CacheItemPriorityDecay, System.Web.Caching.CacheItemRemovedCallback): System.Object use System.Web.Caching.Cache"
		alias
			"Add"
		end

	frozen insert_string_object_cache_dependency_date_time_time_span_cache_item_priority (key: STRING; value: ANY; dependencies: SYSTEM_WEB_CACHING_CACHEDEPENDENCY; absolute_expiration: SYSTEM_DATETIME; sliding_expiration: SYSTEM_TIMESPAN; priority: SYSTEM_WEB_CACHING_CACHEITEMPRIORITY; priority_decay: SYSTEM_WEB_CACHING_CACHEITEMPRIORITYDECAY; on_remove_callback: SYSTEM_WEB_CACHING_CACHEITEMREMOVEDCALLBACK) is
		external
			"IL signature (System.String, System.Object, System.Web.Caching.CacheDependency, System.DateTime, System.TimeSpan, System.Web.Caching.CacheItemPriority, System.Web.Caching.CacheItemPriorityDecay, System.Web.Caching.CacheItemRemovedCallback): System.Void use System.Web.Caching.Cache"
		alias
			"Insert"
		end

	frozen insert (key: STRING; value: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Web.Caching.Cache"
		alias
			"Insert"
		end

	frozen get (key: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Web.Caching.Cache"
		alias
			"Get"
		end

	frozen insert_string_object_cache_dependency_date_time_time_span (key: STRING; value: ANY; dependencies: SYSTEM_WEB_CACHING_CACHEDEPENDENCY; absolute_expiration: SYSTEM_DATETIME; sliding_expiration: SYSTEM_TIMESPAN) is
		external
			"IL signature (System.String, System.Object, System.Web.Caching.CacheDependency, System.DateTime, System.TimeSpan): System.Void use System.Web.Caching.Cache"
		alias
			"Insert"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Web.Caching.Cache"
		alias
			"GetEnumerator"
		end

	frozen remove (key: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Web.Caching.Cache"
		alias
			"Remove"
		end

	equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.Caching.Cache"
		alias
			"Equals"
		end

	frozen insert_string_object_cache_dependency (key: STRING; value: ANY; dependencies: SYSTEM_WEB_CACHING_CACHEDEPENDENCY) is
		external
			"IL signature (System.String, System.Object, System.Web.Caching.CacheDependency): System.Void use System.Web.Caching.Cache"
		alias
			"Insert"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Caching.Cache"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.Caching.Cache"
		alias
			"Finalize"
		end

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.Caching.Cache"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_WEB_CACHING_CACHE
