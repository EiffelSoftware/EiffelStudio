indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.OleDb.OleDbRowUpdatedEventHandler"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_OLE_DB_ROW_UPDATED_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_data_ole_db_row_updated_event_handler

feature {NONE} -- Initialization

	frozen make_data_ole_db_row_updated_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Data.OleDb.OleDbRowUpdatedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: SYSTEM_OBJECT; e: DATA_OLE_DB_ROW_UPDATED_EVENT_ARGS; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.Data.OleDb.OleDbRowUpdatedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Data.OleDb.OleDbRowUpdatedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Data.OleDb.OleDbRowUpdatedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: SYSTEM_OBJECT; e: DATA_OLE_DB_ROW_UPDATED_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Data.OleDb.OleDbRowUpdatedEventArgs): System.Void use System.Data.OleDb.OleDbRowUpdatedEventHandler"
		alias
			"Invoke"
		end

end -- class DATA_OLE_DB_ROW_UPDATED_EVENT_HANDLER
