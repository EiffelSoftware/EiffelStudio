indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.QueryPageSettingsEventHandler"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_QUERY_PAGE_SETTINGS_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_drawing_query_page_settings_event_handler

feature {NONE} -- Initialization

	frozen make_drawing_query_page_settings_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Drawing.Printing.QueryPageSettingsEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: SYSTEM_OBJECT; e: DRAWING_QUERY_PAGE_SETTINGS_EVENT_ARGS; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.Drawing.Printing.QueryPageSettingsEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Printing.QueryPageSettingsEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Drawing.Printing.QueryPageSettingsEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: SYSTEM_OBJECT; e: DRAWING_QUERY_PAGE_SETTINGS_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Drawing.Printing.QueryPageSettingsEventArgs): System.Void use System.Drawing.Printing.QueryPageSettingsEventHandler"
		alias
			"Invoke"
		end

end -- class DRAWING_QUERY_PAGE_SETTINGS_EVENT_HANDLER
