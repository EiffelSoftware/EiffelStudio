indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.EndEventHandler"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_END_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_web_end_event_handler

feature {NONE} -- Initialization

	frozen make_web_end_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Web.EndEventHandler"
		end

feature -- Basic Operations

	begin_invoke (ar: IASYNC_RESULT; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.IAsyncResult, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.EndEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.EndEventHandler"
		alias
			"EndInvoke"
		end

	invoke (ar: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.EndEventHandler"
		alias
			"Invoke"
		end

end -- class WEB_END_EVENT_HANDLER
