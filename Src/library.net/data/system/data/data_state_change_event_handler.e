indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.StateChangeEventHandler"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_STATE_CHANGE_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_data_state_change_event_handler

feature {NONE} -- Initialization

	frozen make_data_state_change_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Data.StateChangeEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: SYSTEM_OBJECT; e: DATA_STATE_CHANGE_EVENT_ARGS; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.Data.StateChangeEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Data.StateChangeEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Data.StateChangeEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: SYSTEM_OBJECT; e: DATA_STATE_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Data.StateChangeEventArgs): System.Void use System.Data.StateChangeEventHandler"
		alias
			"Invoke"
		end

end -- class DATA_STATE_CHANGE_EVENT_HANDLER
