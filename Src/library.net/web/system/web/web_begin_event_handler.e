indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.BeginEventHandler"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_BEGIN_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_web_begin_event_handler

feature {NONE} -- Initialization

	frozen make_web_begin_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Web.BeginEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: SYSTEM_OBJECT; e: EVENT_ARGS; cb: ASYNC_CALLBACK; extra_data: SYSTEM_OBJECT; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.EventArgs, System.AsyncCallback, System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.BeginEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): IASYNC_RESULT is
		external
			"IL signature (System.IAsyncResult): System.IAsyncResult use System.Web.BeginEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: SYSTEM_OBJECT; e: EVENT_ARGS; cb: ASYNC_CALLBACK; extra_data: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.EventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.BeginEventHandler"
		alias
			"Invoke"
		end

end -- class WEB_BEGIN_EVENT_HANDLER
