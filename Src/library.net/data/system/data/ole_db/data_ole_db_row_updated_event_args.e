indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.OleDb.OleDbRowUpdatedEventArgs"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_OLE_DB_ROW_UPDATED_EVENT_ARGS

inherit
	DATA_ROW_UPDATED_EVENT_ARGS

create
	make_data_ole_db_row_updated_event_args

feature {NONE} -- Initialization

	frozen make_data_ole_db_row_updated_event_args (data_row: DATA_DATA_ROW; command: DATA_IDB_COMMAND; statement_type: DATA_STATEMENT_TYPE; table_mapping: DATA_DATA_TABLE_MAPPING) is
		external
			"IL creator signature (System.Data.DataRow, System.Data.IDbCommand, System.Data.StatementType, System.Data.Common.DataTableMapping) use System.Data.OleDb.OleDbRowUpdatedEventArgs"
		end

feature -- Access

	frozen get_command_ole_db_command: DATA_OLE_DB_COMMAND is
		external
			"IL signature (): System.Data.OleDb.OleDbCommand use System.Data.OleDb.OleDbRowUpdatedEventArgs"
		alias
			"get_Command"
		end

end -- class DATA_OLE_DB_ROW_UPDATED_EVENT_ARGS
