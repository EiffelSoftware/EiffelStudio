indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbRowUpdatedEventArgs"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBROWUPDATEDEVENTARGS

inherit
	SYSTEM_DATA_COMMON_ROWUPDATEDEVENTARGS

create
	make_oledbrowupdatedeventargs

feature {NONE} -- Initialization

	frozen make_oledbrowupdatedeventargs (data_row: SYSTEM_DATA_DATAROW; command: SYSTEM_DATA_IDBCOMMAND; statement_type: SYSTEM_DATA_STATEMENTTYPE; table_mapping: SYSTEM_DATA_COMMON_DATATABLEMAPPING) is
		external
			"IL creator signature (System.Data.DataRow, System.Data.IDbCommand, System.Data.StatementType, System.Data.Common.DataTableMapping) use System.Data.OleDb.OleDbRowUpdatedEventArgs"
		end

feature -- Access

	frozen get_command_ole_db_command: SYSTEM_DATA_OLEDB_OLEDBCOMMAND is
		external
			"IL signature (): System.Data.OleDb.OleDbCommand use System.Data.OleDb.OleDbRowUpdatedEventArgs"
		alias
			"get_Command"
		end

end -- class SYSTEM_DATA_OLEDB_OLEDBROWUPDATEDEVENTARGS
