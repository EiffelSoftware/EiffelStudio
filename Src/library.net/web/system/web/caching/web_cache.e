indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Caching.Cache"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_CACHE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Caching.Cache"
		end

feature -- Access

	frozen get_item (key: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Web.Caching.Cache"
		alias
			"get_Item"
		end

	frozen no_absolute_expiration: SYSTEM_DATE_TIME is
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

	frozen no_sliding_expiration: TIME_SPAN is
		external
			"IL static_field signature :System.TimeSpan use System.Web.Caching.Cache"
		alias
			"NoSlidingExpiration"
		end

feature -- Element Change

	frozen set_item (key: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Web.Caching.Cache"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Caching.Cache"
		alias
			"ToString"
		end

	frozen add (key: SYSTEM_STRING; value: SYSTEM_OBJECT; dependencies: WEB_CACHE_DEPENDENCY; absolute_expiration: SYSTEM_DATE_TIME; sliding_expiration: TIME_SPAN; priority: WEB_CACHE_ITEM_PRIORITY; on_remove_callback: WEB_CACHE_ITEM_REMOVED_CALLBACK): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Object, System.Web.Caching.CacheDependency, System.DateTime, System.TimeSpan, System.Web.Caching.CacheItemPriority, System.Web.Caching.CacheItemRemovedCallback): System.Object use System.Web.Caching.Cache"
		alias
			"Add"
		end

	frozen insert_string_object_cache_dependency_date_time_time_span_cache_item_priority (key: SYSTEM_STRING; value: SYSTEM_OBJECT; dependencies: WEB_CACHE_DEPENDENCY; absolute_expiration: SYSTEM_DATE_TIME; sliding_expiration: TIME_SPAN; priority: WEB_CACHE_ITEM_PRIORITY; on_remove_callback: WEB_CACHE_ITEM_REMOVED_CALLBACK) is
		external
			"IL signature (System.String, System.Object, System.Web.Caching.CacheDependency, System.DateTime, System.TimeSpan, System.Web.Caching.CacheItemPriority, System.Web.Caching.CacheItemRemovedCallback): System.Void use System.Web.Caching.Cache"
		alias
			"Insert"
		end

	frozen insert (key: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Web.Caching.Cache"
		alias
			"Insert"
		end

	frozen get (key: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Web.Caching.Cache"
		alias
			"Get"
		end

	frozen insert_string_object_cache_dependency_date_time_time_span (key: SYSTEM_STRING; value: SYSTEM_OBJECT; dependencies: WEB_CACHE_DEPENDENCY; absolute_expiration: SYSTEM_DATE_TIME; sliding_expiration: TIME_SPAN) is
		external
			"IL signature (System.String, System.Object, System.Web.Caching.CacheDependency, System.DateTime, System.TimeSpan): System.Void use System.Web.Caching.Cache"
		alias
			"Insert"
		end

	frozen get_enumerator: IDICTIONARY_ENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Web.Caching.Cache"
		alias
			"GetEnumerator"
		end

	frozen remove (key: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Web.Caching.Cache"
		alias
			"Remove"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.Caching.Cache"
		alias
			"Equals"
		end

	frozen insert_string_object_cache_dependency (key: SYSTEM_STRING; value: SYSTEM_OBJECT; dependencies: WEB_CACHE_DEPENDENCY) is
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

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.Caching.Cache"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class WEB_CACHE
