indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.IHttpAsyncHandler"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_IHTTP_ASYNC_HANDLER

inherit
	WEB_IHTTP_HANDLER

feature -- Basic Operations

	end_process_request (result_: IASYNC_RESULT) is
		external
			"IL deferred signature (System.IAsyncResult): System.Void use System.Web.IHttpAsyncHandler"
		alias
			"EndProcessRequest"
		end

	begin_process_request (context: WEB_HTTP_CONTEXT; cb: ASYNC_CALLBACK; extra_data: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL deferred signature (System.Web.HttpContext, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.IHttpAsyncHandler"
		alias
			"BeginProcessRequest"
		end

end -- class WEB_IHTTP_ASYNC_HANDLER
