indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Caching.CacheItemRemovedCallback"

frozen external class
	SYSTEM_WEB_CACHING_CACHEITEMREMOVEDCALLBACK

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
		rename
			equals as equals_object
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			equals as equals_object
		end

create
	make_cacheitemremovedcallback

feature {NONE} -- Initialization

	frozen make_cacheitemremovedcallback (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.Caching.CacheItemRemovedCallback"
		end

feature -- Basic Operations

	begin_invoke (key: STRING; value: ANY; reason: SYSTEM_WEB_CACHING_CACHEITEMREMOVEDREASON; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.String, System.Object, System.Web.Caching.CacheItemRemovedReason, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.Caching.CacheItemRemovedCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.Caching.CacheItemRemovedCallback"
		alias
			"EndInvoke"
		end

	invoke (key: STRING; value: ANY; reason: SYSTEM_WEB_CACHING_CACHEITEMREMOVEDREASON) is
		external
			"IL signature (System.String, System.Object, System.Web.Caching.CacheItemRemovedReason): System.Void use System.Web.Caching.CacheItemRemovedCallback"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_CACHING_CACHEITEMREMOVEDCALLBACK
