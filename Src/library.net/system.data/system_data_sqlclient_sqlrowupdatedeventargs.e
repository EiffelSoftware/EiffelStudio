indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlRowUpdatedEventArgs"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLROWUPDATEDEVENTARGS

inherit
	SYSTEM_DATA_COMMON_ROWUPDATEDEVENTARGS

create
	make_sqlrowupdatedeventargs

feature {NONE} -- Initialization

	frozen make_sqlrowupdatedeventargs (row: SYSTEM_DATA_DATAROW; command: SYSTEM_DATA_IDBCOMMAND; statement_type: SYSTEM_DATA_STATEMENTTYPE; table_mapping: SYSTEM_DATA_COMMON_DATATABLEMAPPING) is
		external
			"IL creator signature (System.Data.DataRow, System.Data.IDbCommand, System.Data.StatementType, System.Data.Common.DataTableMapping) use System.Data.SqlClient.SqlRowUpdatedEventArgs"
		end

feature -- Access

	frozen get_command_sql_command: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND is
		external
			"IL signature (): System.Data.SqlClient.SqlCommand use System.Data.SqlClient.SqlRowUpdatedEventArgs"
		alias
			"get_Command"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLROWUPDATEDEVENTARGS
