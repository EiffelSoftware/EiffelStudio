indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.RepeaterItemEventHandler"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_REPEATER_ITEM_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_web_repeater_item_event_handler

feature {NONE} -- Initialization

	frozen make_web_repeater_item_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Web.UI.WebControls.RepeaterItemEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: SYSTEM_OBJECT; e: WEB_REPEATER_ITEM_EVENT_ARGS; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.RepeaterItemEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.WebControls.RepeaterItemEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.UI.WebControls.RepeaterItemEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: SYSTEM_OBJECT; e: WEB_REPEATER_ITEM_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.RepeaterItemEventArgs): System.Void use System.Web.UI.WebControls.RepeaterItemEventHandler"
		alias
			"Invoke"
		end

end -- class WEB_REPEATER_ITEM_EVENT_HANDLER
