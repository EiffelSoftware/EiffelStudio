indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlClient.SqlRowUpdatedEventArgs"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_SQL_ROW_UPDATED_EVENT_ARGS

inherit
	DATA_ROW_UPDATED_EVENT_ARGS

create
	make_data_sql_row_updated_event_args

feature {NONE} -- Initialization

	frozen make_data_sql_row_updated_event_args (row: DATA_DATA_ROW; command: DATA_IDB_COMMAND; statement_type: DATA_STATEMENT_TYPE; table_mapping: DATA_DATA_TABLE_MAPPING) is
		external
			"IL creator signature (System.Data.DataRow, System.Data.IDbCommand, System.Data.StatementType, System.Data.Common.DataTableMapping) use System.Data.SqlClient.SqlRowUpdatedEventArgs"
		end

feature -- Access

	frozen get_command_sql_command: DATA_SQL_COMMAND is
		external
			"IL signature (): System.Data.SqlClient.SqlCommand use System.Data.SqlClient.SqlRowUpdatedEventArgs"
		alias
			"get_Command"
		end

end -- class DATA_SQL_ROW_UPDATED_EVENT_ARGS
