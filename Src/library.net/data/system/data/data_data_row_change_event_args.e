indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataRowChangeEventArgs"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_ROW_CHANGE_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_data_data_row_change_event_args

feature {NONE} -- Initialization

	frozen make_data_data_row_change_event_args (row: DATA_DATA_ROW; action: DATA_DATA_ROW_ACTION) is
		external
			"IL creator signature (System.Data.DataRow, System.Data.DataRowAction) use System.Data.DataRowChangeEventArgs"
		end

feature -- Access

	frozen get_action: DATA_DATA_ROW_ACTION is
		external
			"IL signature (): System.Data.DataRowAction use System.Data.DataRowChangeEventArgs"
		alias
			"get_Action"
		end

	frozen get_row: DATA_DATA_ROW is
		external
			"IL signature (): System.Data.DataRow use System.Data.DataRowChangeEventArgs"
		alias
			"get_Row"
		end

end -- class DATA_DATA_ROW_CHANGE_EVENT_ARGS
