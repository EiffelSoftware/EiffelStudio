indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.DataGridCommandEventHandler"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_DATA_GRID_COMMAND_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_web_data_grid_command_event_handler

feature {NONE} -- Initialization

	frozen make_web_data_grid_command_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Web.UI.WebControls.DataGridCommandEventHandler"
		end

feature -- Basic Operations

	begin_invoke (source: SYSTEM_OBJECT; e: WEB_DATA_GRID_COMMAND_EVENT_ARGS; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.DataGridCommandEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.WebControls.DataGridCommandEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.UI.WebControls.DataGridCommandEventHandler"
		alias
			"EndInvoke"
		end

	invoke (source: SYSTEM_OBJECT; e: WEB_DATA_GRID_COMMAND_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.DataGridCommandEventArgs): System.Void use System.Web.UI.WebControls.DataGridCommandEventHandler"
		alias
			"Invoke"
		end

end -- class WEB_DATA_GRID_COMMAND_EVENT_HANDLER
