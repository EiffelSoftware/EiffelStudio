indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Caching.CacheItemRemovedCallback"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_CACHE_ITEM_REMOVED_CALLBACK

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_web_cache_item_removed_callback

feature {NONE} -- Initialization

	frozen make_web_cache_item_removed_callback (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Web.Caching.CacheItemRemovedCallback"
		end

feature -- Basic Operations

	begin_invoke (key: SYSTEM_STRING; value: SYSTEM_OBJECT; reason: WEB_CACHE_ITEM_REMOVED_REASON; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.String, System.Object, System.Web.Caching.CacheItemRemovedReason, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.Caching.CacheItemRemovedCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.Caching.CacheItemRemovedCallback"
		alias
			"EndInvoke"
		end

	invoke (key: SYSTEM_STRING; value: SYSTEM_OBJECT; reason: WEB_CACHE_ITEM_REMOVED_REASON) is
		external
			"IL signature (System.String, System.Object, System.Web.Caching.CacheItemRemovedReason): System.Void use System.Web.Caching.CacheItemRemovedCallback"
		alias
			"Invoke"
		end

end -- class WEB_CACHE_ITEM_REMOVED_CALLBACK
