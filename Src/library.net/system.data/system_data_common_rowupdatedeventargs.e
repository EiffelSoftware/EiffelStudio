indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.Common.RowUpdatedEventArgs"

deferred external class
	SYSTEM_DATA_COMMON_ROWUPDATEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

feature -- Access

	frozen get_statement_type: SYSTEM_DATA_STATEMENTTYPE is
		external
			"IL signature (): System.Data.StatementType use System.Data.Common.RowUpdatedEventArgs"
		alias
			"get_StatementType"
		end

	frozen get_records_affected: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.Common.RowUpdatedEventArgs"
		alias
			"get_RecordsAffected"
		end

	frozen get_status: SYSTEM_DATA_UPDATESTATUS is
		external
			"IL signature (): System.Data.UpdateStatus use System.Data.Common.RowUpdatedEventArgs"
		alias
			"get_Status"
		end

	frozen get_command: SYSTEM_DATA_IDBCOMMAND is
		external
			"IL signature (): System.Data.IDbCommand use System.Data.Common.RowUpdatedEventArgs"
		alias
			"get_Command"
		end

	frozen get_errors: SYSTEM_EXCEPTION is
		external
			"IL signature (): System.Exception use System.Data.Common.RowUpdatedEventArgs"
		alias
			"get_Errors"
		end

	frozen get_table_mapping: SYSTEM_DATA_COMMON_DATATABLEMAPPING is
		external
			"IL signature (): System.Data.Common.DataTableMapping use System.Data.Common.RowUpdatedEventArgs"
		alias
			"get_TableMapping"
		end

	frozen get_row: SYSTEM_DATA_DATAROW is
		external
			"IL signature (): System.Data.DataRow use System.Data.Common.RowUpdatedEventArgs"
		alias
			"get_Row"
		end

feature -- Element Change

	frozen set_status (value: SYSTEM_DATA_UPDATESTATUS) is
		external
			"IL signature (System.Data.UpdateStatus): System.Void use System.Data.Common.RowUpdatedEventArgs"
		alias
			"set_Status"
		end

	frozen set_errors (value: SYSTEM_EXCEPTION) is
		external
			"IL signature (System.Exception): System.Void use System.Data.Common.RowUpdatedEventArgs"
		alias
			"set_Errors"
		end

end -- class SYSTEM_DATA_COMMON_ROWUPDATEDEVENTARGS
