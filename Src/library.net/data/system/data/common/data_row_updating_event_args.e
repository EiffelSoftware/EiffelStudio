indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.Common.RowUpdatingEventArgs"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_ROW_UPDATING_EVENT_ARGS

inherit
	EVENT_ARGS

feature -- Access

	frozen get_statement_type: DATA_STATEMENT_TYPE is
		external
			"IL signature (): System.Data.StatementType use System.Data.Common.RowUpdatingEventArgs"
		alias
			"get_StatementType"
		end

	frozen get_status: DATA_UPDATE_STATUS is
		external
			"IL signature (): System.Data.UpdateStatus use System.Data.Common.RowUpdatingEventArgs"
		alias
			"get_Status"
		end

	frozen get_command: DATA_IDB_COMMAND is
		external
			"IL signature (): System.Data.IDbCommand use System.Data.Common.RowUpdatingEventArgs"
		alias
			"get_Command"
		end

	frozen get_errors: EXCEPTION is
		external
			"IL signature (): System.Exception use System.Data.Common.RowUpdatingEventArgs"
		alias
			"get_Errors"
		end

	frozen get_table_mapping: DATA_DATA_TABLE_MAPPING is
		external
			"IL signature (): System.Data.Common.DataTableMapping use System.Data.Common.RowUpdatingEventArgs"
		alias
			"get_TableMapping"
		end

	frozen get_row: DATA_DATA_ROW is
		external
			"IL signature (): System.Data.DataRow use System.Data.Common.RowUpdatingEventArgs"
		alias
			"get_Row"
		end

feature -- Element Change

	frozen set_command (value: DATA_IDB_COMMAND) is
		external
			"IL signature (System.Data.IDbCommand): System.Void use System.Data.Common.RowUpdatingEventArgs"
		alias
			"set_Command"
		end

	frozen set_status (value: DATA_UPDATE_STATUS) is
		external
			"IL signature (System.Data.UpdateStatus): System.Void use System.Data.Common.RowUpdatingEventArgs"
		alias
			"set_Status"
		end

	frozen set_errors (value: EXCEPTION) is
		external
			"IL signature (System.Exception): System.Void use System.Data.Common.RowUpdatingEventArgs"
		alias
			"set_Errors"
		end

end -- class DATA_ROW_UPDATING_EVENT_ARGS
