indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlRowUpdatingEventArgs"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLROWUPDATINGEVENTARGS

inherit
	SYSTEM_DATA_COMMON_ROWUPDATINGEVENTARGS

create
	make_sqlrowupdatingeventargs

feature {NONE} -- Initialization

	frozen make_sqlrowupdatingeventargs (row: SYSTEM_DATA_DATAROW; command: SYSTEM_DATA_IDBCOMMAND; statement_type: SYSTEM_DATA_STATEMENTTYPE; table_mapping: SYSTEM_DATA_COMMON_DATATABLEMAPPING) is
		external
			"IL creator signature (System.Data.DataRow, System.Data.IDbCommand, System.Data.StatementType, System.Data.Common.DataTableMapping) use System.Data.SqlClient.SqlRowUpdatingEventArgs"
		end

feature -- Access

	frozen get_command_sql_command: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND is
		external
			"IL signature (): System.Data.SqlClient.SqlCommand use System.Data.SqlClient.SqlRowUpdatingEventArgs"
		alias
			"get_Command"
		end

feature -- Element Change

	frozen set_command_sql_command (value: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND) is
		external
			"IL signature (System.Data.SqlClient.SqlCommand): System.Void use System.Data.SqlClient.SqlRowUpdatingEventArgs"
		alias
			"set_Command"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLROWUPDATINGEVENTARGS
