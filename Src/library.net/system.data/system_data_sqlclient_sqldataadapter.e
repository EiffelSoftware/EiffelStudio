indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlDataAdapter"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLDATAADAPTER

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_DATA_IDATAADAPTER
		rename
			update as update_data_set,
			fill as fill_data_set,
			fill_schema as fill_schema_data_set_schema_type,
			get_table_mappings as system_data_idata_adapter_get_table_mappings
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end
	SYSTEM_DATA_COMMON_DBDATAADAPTER
		rename
			fill as fill_data_set,
			fill_schema as fill_schema_data_set_schema_type
		redefine
			dispose_boolean
		end
	SYSTEM_DATA_IDBDATAADAPTER
		rename
			set_update_command as system_data_idb_data_adapter_set_update_command,
			get_update_command as system_data_idb_data_adapter_get_update_command,
			set_select_command as system_data_idb_data_adapter_set_select_command,
			get_select_command as system_data_idb_data_adapter_get_select_command,
			set_insert_command as system_data_idb_data_adapter_set_insert_command,
			get_insert_command as system_data_idb_data_adapter_get_insert_command,
			set_delete_command as system_data_idb_data_adapter_set_delete_command,
			get_delete_command as system_data_idb_data_adapter_get_delete_command,
			update as update_data_set,
			fill as fill_data_set,
			fill_schema as fill_schema_data_set_schema_type,
			get_table_mappings as system_data_idata_adapter_get_table_mappings
		end

create
	make_sqldataadapter_1,
	make_sqldataadapter_3,
	make_sqldataadapter_2,
	make_sqldataadapter

feature {NONE} -- Initialization

	frozen make_sqldataadapter_1 (select_command: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND) is
		external
			"IL creator signature (System.Data.SqlClient.SqlCommand) use System.Data.SqlClient.SqlDataAdapter"
		end

	frozen make_sqldataadapter_3 (select_command_text: STRING; select_connection: SYSTEM_DATA_SQLCLIENT_SQLCONNECTION) is
		external
			"IL creator signature (System.String, System.Data.SqlClient.SqlConnection) use System.Data.SqlClient.SqlDataAdapter"
		end

	frozen make_sqldataadapter_2 (select_command_text: STRING; select_connection_string: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Data.SqlClient.SqlDataAdapter"
		end

	frozen make_sqldataadapter is
		external
			"IL creator use System.Data.SqlClient.SqlDataAdapter"
		end

feature -- Access

	frozen get_update_command: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND is
		external
			"IL signature (): System.Data.SqlClient.SqlCommand use System.Data.SqlClient.SqlDataAdapter"
		alias
			"get_UpdateCommand"
		end

	frozen get_delete_command: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND is
		external
			"IL signature (): System.Data.SqlClient.SqlCommand use System.Data.SqlClient.SqlDataAdapter"
		alias
			"get_DeleteCommand"
		end

	frozen get_select_command: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND is
		external
			"IL signature (): System.Data.SqlClient.SqlCommand use System.Data.SqlClient.SqlDataAdapter"
		alias
			"get_SelectCommand"
		end

	frozen get_insert_command: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND is
		external
			"IL signature (): System.Data.SqlClient.SqlCommand use System.Data.SqlClient.SqlDataAdapter"
		alias
			"get_InsertCommand"
		end

feature -- Element Change

	frozen add_row_updated (value: SYSTEM_DATA_SQLCLIENT_SQLROWUPDATEDEVENTHANDLER) is
		external
			"IL signature (System.Data.SqlClient.SqlRowUpdatedEventHandler): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"add_RowUpdated"
		end

	frozen set_insert_command (value: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND) is
		external
			"IL signature (System.Data.SqlClient.SqlCommand): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"set_InsertCommand"
		end

	frozen set_delete_command (value: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND) is
		external
			"IL signature (System.Data.SqlClient.SqlCommand): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"set_DeleteCommand"
		end

	frozen add_row_updating (value: SYSTEM_DATA_SQLCLIENT_SQLROWUPDATINGEVENTHANDLER) is
		external
			"IL signature (System.Data.SqlClient.SqlRowUpdatingEventHandler): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"add_RowUpdating"
		end

	frozen set_select_command (value: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND) is
		external
			"IL signature (System.Data.SqlClient.SqlCommand): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"set_SelectCommand"
		end

	frozen remove_row_updated (value: SYSTEM_DATA_SQLCLIENT_SQLROWUPDATEDEVENTHANDLER) is
		external
			"IL signature (System.Data.SqlClient.SqlRowUpdatedEventHandler): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"remove_RowUpdated"
		end

	frozen remove_row_updating (value: SYSTEM_DATA_SQLCLIENT_SQLROWUPDATINGEVENTHANDLER) is
		external
			"IL signature (System.Data.SqlClient.SqlRowUpdatingEventHandler): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"remove_RowUpdating"
		end

	frozen set_update_command (value: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND) is
		external
			"IL signature (System.Data.SqlClient.SqlCommand): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"set_UpdateCommand"
		end

feature {NONE} -- Implementation

	frozen system_data_idb_data_adapter_get_update_command: SYSTEM_DATA_IDBCOMMAND is
		external
			"IL signature (): System.Data.IDbCommand use System.Data.SqlClient.SqlDataAdapter"
		alias
			"System.Data.IDbDataAdapter.get_UpdateCommand"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"Dispose"
		end

	on_row_updated (value: SYSTEM_DATA_COMMON_ROWUPDATEDEVENTARGS) is
		external
			"IL signature (System.Data.Common.RowUpdatedEventArgs): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"OnRowUpdated"
		end

	frozen system_data_idb_data_adapter_set_delete_command (value: SYSTEM_DATA_IDBCOMMAND) is
		external
			"IL signature (System.Data.IDbCommand): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"System.Data.IDbDataAdapter.set_DeleteCommand"
		end

	create_row_updated_event (data_row: SYSTEM_DATA_DATAROW; command: SYSTEM_DATA_IDBCOMMAND; statement_type: SYSTEM_DATA_STATEMENTTYPE; table_mapping: SYSTEM_DATA_COMMON_DATATABLEMAPPING): SYSTEM_DATA_COMMON_ROWUPDATEDEVENTARGS is
		external
			"IL signature (System.Data.DataRow, System.Data.IDbCommand, System.Data.StatementType, System.Data.Common.DataTableMapping): System.Data.Common.RowUpdatedEventArgs use System.Data.SqlClient.SqlDataAdapter"
		alias
			"CreateRowUpdatedEvent"
		end

	frozen system_data_idb_data_adapter_get_delete_command: SYSTEM_DATA_IDBCOMMAND is
		external
			"IL signature (): System.Data.IDbCommand use System.Data.SqlClient.SqlDataAdapter"
		alias
			"System.Data.IDbDataAdapter.get_DeleteCommand"
		end

	create_row_updating_event (data_row: SYSTEM_DATA_DATAROW; command: SYSTEM_DATA_IDBCOMMAND; statement_type: SYSTEM_DATA_STATEMENTTYPE; table_mapping: SYSTEM_DATA_COMMON_DATATABLEMAPPING): SYSTEM_DATA_COMMON_ROWUPDATINGEVENTARGS is
		external
			"IL signature (System.Data.DataRow, System.Data.IDbCommand, System.Data.StatementType, System.Data.Common.DataTableMapping): System.Data.Common.RowUpdatingEventArgs use System.Data.SqlClient.SqlDataAdapter"
		alias
			"CreateRowUpdatingEvent"
		end

	frozen system_data_idb_data_adapter_set_update_command (value: SYSTEM_DATA_IDBCOMMAND) is
		external
			"IL signature (System.Data.IDbCommand): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"System.Data.IDbDataAdapter.set_UpdateCommand"
		end

	frozen system_icloneable_clone: ANY is
		external
			"IL signature (): System.Object use System.Data.SqlClient.SqlDataAdapter"
		alias
			"System.ICloneable.Clone"
		end

	frozen system_data_idb_data_adapter_set_insert_command (value: SYSTEM_DATA_IDBCOMMAND) is
		external
			"IL signature (System.Data.IDbCommand): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"System.Data.IDbDataAdapter.set_InsertCommand"
		end

	frozen system_data_idb_data_adapter_set_select_command (value: SYSTEM_DATA_IDBCOMMAND) is
		external
			"IL signature (System.Data.IDbCommand): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"System.Data.IDbDataAdapter.set_SelectCommand"
		end

	on_row_updating (value: SYSTEM_DATA_COMMON_ROWUPDATINGEVENTARGS) is
		external
			"IL signature (System.Data.Common.RowUpdatingEventArgs): System.Void use System.Data.SqlClient.SqlDataAdapter"
		alias
			"OnRowUpdating"
		end

	frozen system_data_idb_data_adapter_get_insert_command: SYSTEM_DATA_IDBCOMMAND is
		external
			"IL signature (): System.Data.IDbCommand use System.Data.SqlClient.SqlDataAdapter"
		alias
			"System.Data.IDbDataAdapter.get_InsertCommand"
		end

	frozen system_data_idb_data_adapter_get_select_command: SYSTEM_DATA_IDBCOMMAND is
		external
			"IL signature (): System.Data.IDbCommand use System.Data.SqlClient.SqlDataAdapter"
		alias
			"System.Data.IDbDataAdapter.get_SelectCommand"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLDATAADAPTER
