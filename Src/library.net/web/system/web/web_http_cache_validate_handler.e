indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpCacheValidateHandler"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_CACHE_VALIDATE_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_web_http_cache_validate_handler

feature {NONE} -- Initialization

	frozen make_web_http_cache_validate_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Web.HttpCacheValidateHandler"
		end

feature -- Basic Operations

	begin_invoke (context: WEB_HTTP_CONTEXT; data: SYSTEM_OBJECT; validation_status: WEB_HTTP_VALIDATION_STATUS; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Web.HttpContext, System.Object, System.Web.HttpValidationStatus&, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.HttpCacheValidateHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (validation_status: WEB_HTTP_VALIDATION_STATUS; result_: IASYNC_RESULT) is
		external
			"IL signature (System.Web.HttpValidationStatus&, System.IAsyncResult): System.Void use System.Web.HttpCacheValidateHandler"
		alias
			"EndInvoke"
		end

	invoke (context: WEB_HTTP_CONTEXT; data: SYSTEM_OBJECT; validation_status: WEB_HTTP_VALIDATION_STATUS) is
		external
			"IL signature (System.Web.HttpContext, System.Object, System.Web.HttpValidationStatus&): System.Void use System.Web.HttpCacheValidateHandler"
		alias
			"Invoke"
		end

end -- class WEB_HTTP_CACHE_VALIDATE_HANDLER
