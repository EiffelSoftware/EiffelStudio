indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.OleDb.OleDbDataAdapter"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_OLE_DB_DATA_ADAPTER

inherit
	DATA_DB_DATA_ADAPTER
		rename
			update as update_data_set,
			fill as fill_data_set,
			fill_schema as fill_schema_data_set_schema_type
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	DATA_IDATA_ADAPTER
		rename
			update as update_data_set,
			fill as fill_data_set,
			fill_schema as fill_schema_data_set_schema_type,
			get_table_mappings as system_data_idata_adapter_get_table_mappings
		end
	ICLONEABLE
		rename
			clone_ as system_icloneable_clone
		end
	DATA_IDB_DATA_ADAPTER
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
	make_data_ole_db_data_adapter,
	make_data_ole_db_data_adapter_3,
	make_data_ole_db_data_adapter_2,
	make_data_ole_db_data_adapter_1

feature {NONE} -- Initialization

	frozen make_data_ole_db_data_adapter is
		external
			"IL creator use System.Data.OleDb.OleDbDataAdapter"
		end

	frozen make_data_ole_db_data_adapter_3 (select_command_text: SYSTEM_STRING; select_connection: DATA_OLE_DB_CONNECTION) is
		external
			"IL creator signature (System.String, System.Data.OleDb.OleDbConnection) use System.Data.OleDb.OleDbDataAdapter"
		end

	frozen make_data_ole_db_data_adapter_2 (select_command_text: SYSTEM_STRING; select_connection_string: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Data.OleDb.OleDbDataAdapter"
		end

	frozen make_data_ole_db_data_adapter_1 (select_command: DATA_OLE_DB_COMMAND) is
		external
			"IL creator signature (System.Data.OleDb.OleDbCommand) use System.Data.OleDb.OleDbDataAdapter"
		end

feature -- Access

	frozen get_update_command: DATA_OLE_DB_COMMAND is
		external
			"IL signature (): System.Data.OleDb.OleDbCommand use System.Data.OleDb.OleDbDataAdapter"
		alias
			"get_UpdateCommand"
		end

	frozen get_delete_command: DATA_OLE_DB_COMMAND is
		external
			"IL signature (): System.Data.OleDb.OleDbCommand use System.Data.OleDb.OleDbDataAdapter"
		alias
			"get_DeleteCommand"
		end

	frozen get_select_command: DATA_OLE_DB_COMMAND is
		external
			"IL signature (): System.Data.OleDb.OleDbCommand use System.Data.OleDb.OleDbDataAdapter"
		alias
			"get_SelectCommand"
		end

	frozen get_insert_command: DATA_OLE_DB_COMMAND is
		external
			"IL signature (): System.Data.OleDb.OleDbCommand use System.Data.OleDb.OleDbDataAdapter"
		alias
			"get_InsertCommand"
		end

feature -- Element Change

	frozen add_row_updated (value: DATA_OLE_DB_ROW_UPDATED_EVENT_HANDLER) is
		external
			"IL signature (System.Data.OleDb.OleDbRowUpdatedEventHandler): System.Void use System.Data.OleDb.OleDbDataAdapter"
		alias
			"add_RowUpdated"
		end

	frozen set_insert_command (value: DATA_OLE_DB_COMMAND) is
		external
			"IL signature (System.Data.OleDb.OleDbCommand): System.Void use System.Data.OleDb.OleDbDataAdapter"
		alias
			"set_InsertCommand"
		end

	frozen set_delete_command (value: DATA_OLE_DB_COMMAND) is
		external
			"IL signature (System.Data.OleDb.OleDbCommand): System.Void use System.Data.OleDb.OleDbDataAdapter"
		alias
			"set_DeleteCommand"
		end

	frozen add_row_updating (value: DATA_OLE_DB_ROW_UPDATING_EVENT_HANDLER) is
		external
			"IL signature (System.Data.OleDb.OleDbRowUpdatingEventHandler): System.Void use System.Data.OleDb.OleDbDataAdapter"
		alias
			"add_RowUpdating"
		end

	frozen set_select_command (value: DATA_OLE_DB_COMMAND) is
		external
			"IL signature (System.Data.OleDb.OleDbCommand): System.Void use System.Data.OleDb.OleDbDataAdapter"
		alias
			"set_SelectCommand"
		end

	frozen remove_row_updated (value: DATA_OLE_DB_ROW_UPDATED_EVENT_HANDLER) is
		external
			"IL signature (System.Data.OleDb.OleDbRowUpdatedEventHandler): System.Void use System.Data.OleDb.OleDbDataAdapter"
		alias
			"remove_RowUpdated"
		end

	frozen remove_row_updating (value: DATA_OLE_DB_ROW_UPDATING_EVENT_HANDLER) is
		external
			"IL signature (System.Data.OleDb.OleDbRowUpdatingEventHandler): System.Void use System.Data.OleDb.OleDbDataAdapter"
		alias
			"remove_RowUpdating"
		end

	frozen set_update_command (value: DATA_OLE_DB_COMMAND) is
		external
			"IL signature (System.Data.OleDb.OleDbCommand): System.Void use System.Data.OleDb.OleDbDataAdapter"
		alias
			"set_UpdateCommand"
		end

feature -- Basic Operations

	frozen fill_data_set_object_string (data_set: DATA_DATA_SET; adodbrecord_set: SYSTEM_OBJECT; src_table: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.Data.DataSet, System.Object, System.String): System.Int32 use System.Data.OleDb.OleDbDataAdapter"
		alias
			"Fill"
		end

	frozen fill_data_table_object (data_table: DATA_DATA_TABLE; adodbrecord_set: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Data.DataTable, System.Object): System.Int32 use System.Data.OleDb.OleDbDataAdapter"
		alias
			"Fill"
		end

feature {NONE} -- Implementation

	frozen system_data_idb_data_adapter_get_update_command: DATA_IDB_COMMAND is
		external
			"IL signature (): System.Data.IDbCommand use System.Data.OleDb.OleDbDataAdapter"
		alias
			"System.Data.IDbDataAdapter.get_UpdateCommand"
		end

	on_row_updating (value: DATA_ROW_UPDATING_EVENT_ARGS) is
		external
			"IL signature (System.Data.Common.RowUpdatingEventArgs): System.Void use System.Data.OleDb.OleDbDataAdapter"
		alias
			"OnRowUpdating"
		end

	create_row_updated_event (data_row: DATA_DATA_ROW; command: DATA_IDB_COMMAND; statement_type: DATA_STATEMENT_TYPE; table_mapping: DATA_DATA_TABLE_MAPPING): DATA_ROW_UPDATED_EVENT_ARGS is
		external
			"IL signature (System.Data.DataRow, System.Data.IDbCommand, System.Data.StatementType, System.Data.Common.DataTableMapping): System.Data.Common.RowUpdatedEventArgs use System.Data.OleDb.OleDbDataAdapter"
		alias
			"CreateRowUpdatedEvent"
		end

	frozen system_data_idb_data_adapter_get_delete_command: DATA_IDB_COMMAND is
		external
			"IL signature (): System.Data.IDbCommand use System.Data.OleDb.OleDbDataAdapter"
		alias
			"System.Data.IDbDataAdapter.get_DeleteCommand"
		end

	create_row_updating_event (data_row: DATA_DATA_ROW; command: DATA_IDB_COMMAND; statement_type: DATA_STATEMENT_TYPE; table_mapping: DATA_DATA_TABLE_MAPPING): DATA_ROW_UPDATING_EVENT_ARGS is
		external
			"IL signature (System.Data.DataRow, System.Data.IDbCommand, System.Data.StatementType, System.Data.Common.DataTableMapping): System.Data.Common.RowUpdatingEventArgs use System.Data.OleDb.OleDbDataAdapter"
		alias
			"CreateRowUpdatingEvent"
		end

	frozen system_data_idb_data_adapter_set_update_command (value: DATA_IDB_COMMAND) is
		external
			"IL signature (System.Data.IDbCommand): System.Void use System.Data.OleDb.OleDbDataAdapter"
		alias
			"System.Data.IDbDataAdapter.set_UpdateCommand"
		end

	frozen system_data_idb_data_adapter_set_delete_command (value: DATA_IDB_COMMAND) is
		external
			"IL signature (System.Data.IDbCommand): System.Void use System.Data.OleDb.OleDbDataAdapter"
		alias
			"System.Data.IDbDataAdapter.set_DeleteCommand"
		end

	frozen system_data_idb_data_adapter_set_insert_command (value: DATA_IDB_COMMAND) is
		external
			"IL signature (System.Data.IDbCommand): System.Void use System.Data.OleDb.OleDbDataAdapter"
		alias
			"System.Data.IDbDataAdapter.set_InsertCommand"
		end

	frozen system_data_idb_data_adapter_set_select_command (value: DATA_IDB_COMMAND) is
		external
			"IL signature (System.Data.IDbCommand): System.Void use System.Data.OleDb.OleDbDataAdapter"
		alias
			"System.Data.IDbDataAdapter.set_SelectCommand"
		end

	on_row_updated (value: DATA_ROW_UPDATED_EVENT_ARGS) is
		external
			"IL signature (System.Data.Common.RowUpdatedEventArgs): System.Void use System.Data.OleDb.OleDbDataAdapter"
		alias
			"OnRowUpdated"
		end

	frozen system_data_idb_data_adapter_get_insert_command: DATA_IDB_COMMAND is
		external
			"IL signature (): System.Data.IDbCommand use System.Data.OleDb.OleDbDataAdapter"
		alias
			"System.Data.IDbDataAdapter.get_InsertCommand"
		end

	frozen system_data_idb_data_adapter_get_select_command: DATA_IDB_COMMAND is
		external
			"IL signature (): System.Data.IDbCommand use System.Data.OleDb.OleDbDataAdapter"
		alias
			"System.Data.IDbDataAdapter.get_SelectCommand"
		end

end -- class DATA_OLE_DB_DATA_ADAPTER
