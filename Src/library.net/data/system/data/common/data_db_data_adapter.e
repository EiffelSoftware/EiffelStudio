indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.Common.DbDataAdapter"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_DB_DATA_ADAPTER

inherit
	DATA_DATA_ADAPTER
		redefine
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	DATA_IDATA_ADAPTER
		rename
			get_table_mappings as system_data_idata_adapter_get_table_mappings
		end
	ICLONEABLE
		rename
			clone_ as system_icloneable_clone
		end

feature -- Access

--	frozen default_source_table_name: SYSTEM_STRING is "Table"

feature -- Element Change

	frozen remove_fill_error (value: DATA_FILL_ERROR_EVENT_HANDLER) is
		external
			"IL signature (System.Data.FillErrorEventHandler): System.Void use System.Data.Common.DbDataAdapter"
		alias
			"remove_FillError"
		end

	frozen add_fill_error (value: DATA_FILL_ERROR_EVENT_HANDLER) is
		external
			"IL signature (System.Data.FillErrorEventHandler): System.Void use System.Data.Common.DbDataAdapter"
		alias
			"add_FillError"
		end

feature -- Basic Operations

	fill_schema (data_set: DATA_DATA_SET; schema_type: DATA_SCHEMA_TYPE): NATIVE_ARRAY [DATA_DATA_TABLE] is
		external
			"IL signature (System.Data.DataSet, System.Data.SchemaType): System.Data.DataTable[] use System.Data.Common.DbDataAdapter"
		alias
			"FillSchema"
		end

	get_fill_parameters: NATIVE_ARRAY [DATA_IDATA_PARAMETER] is
		external
			"IL signature (): System.Data.IDataParameter[] use System.Data.Common.DbDataAdapter"
		alias
			"GetFillParameters"
		end

	frozen fill_data_table (data_table: DATA_DATA_TABLE): INTEGER is
		external
			"IL signature (System.Data.DataTable): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

	frozen fill_data_set_int32_int32_string (data_set: DATA_DATA_SET; start_record: INTEGER; max_records: INTEGER; src_table: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.Data.DataSet, System.Int32, System.Int32, System.String): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

	frozen update_array_data_row (data_rows: NATIVE_ARRAY [DATA_DATA_ROW]): INTEGER is
		external
			"IL signature (System.Data.DataRow[]): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Update"
		end

	frozen fill_schema_data_table_schema_type (data_table: DATA_DATA_TABLE; schema_type: DATA_SCHEMA_TYPE): DATA_DATA_TABLE is
		external
			"IL signature (System.Data.DataTable, System.Data.SchemaType): System.Data.DataTable use System.Data.Common.DbDataAdapter"
		alias
			"FillSchema"
		end

	frozen fill_schema_data_set_schema_type_string (data_set: DATA_DATA_SET; schema_type: DATA_SCHEMA_TYPE; src_table: SYSTEM_STRING): NATIVE_ARRAY [DATA_DATA_TABLE] is
		external
			"IL signature (System.Data.DataSet, System.Data.SchemaType, System.String): System.Data.DataTable[] use System.Data.Common.DbDataAdapter"
		alias
			"FillSchema"
		end

	frozen update_data_set_string (data_set: DATA_DATA_SET; src_table: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.Data.DataSet, System.String): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Update"
		end

	frozen fill_data_set_string (data_set: DATA_DATA_SET; src_table: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.Data.DataSet, System.String): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

	fill (data_set: DATA_DATA_SET): INTEGER is
		external
			"IL signature (System.Data.DataSet): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

	frozen update_data_table (data_table: DATA_DATA_TABLE): INTEGER is
		external
			"IL signature (System.Data.DataTable): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Update"
		end

	update (data_set: DATA_DATA_SET): INTEGER is
		external
			"IL signature (System.Data.DataSet): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Update"
		end

feature {NONE} -- Implementation

	fill_data_table_idb_command (data_table: DATA_DATA_TABLE; command: DATA_IDB_COMMAND; behavior: DATA_COMMAND_BEHAVIOR): INTEGER is
		external
			"IL signature (System.Data.DataTable, System.Data.IDbCommand, System.Data.CommandBehavior): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

	frozen system_icloneable_clone: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.Common.DbDataAdapter"
		alias
			"System.ICloneable.Clone"
		end

	create_row_updating_event (data_row: DATA_DATA_ROW; command: DATA_IDB_COMMAND; statement_type: DATA_STATEMENT_TYPE; table_mapping: DATA_DATA_TABLE_MAPPING): DATA_ROW_UPDATING_EVENT_ARGS is
		external
			"IL deferred signature (System.Data.DataRow, System.Data.IDbCommand, System.Data.StatementType, System.Data.Common.DataTableMapping): System.Data.Common.RowUpdatingEventArgs use System.Data.Common.DbDataAdapter"
		alias
			"CreateRowUpdatingEvent"
		end

	fill_data_set_int32_int32_string_idb_command (data_set: DATA_DATA_SET; start_record: INTEGER; max_records: INTEGER; src_table: SYSTEM_STRING; command: DATA_IDB_COMMAND; behavior: DATA_COMMAND_BEHAVIOR): INTEGER is
		external
			"IL signature (System.Data.DataSet, System.Int32, System.Int32, System.String, System.Data.IDbCommand, System.Data.CommandBehavior): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

	on_fill_error (value: DATA_FILL_ERROR_EVENT_ARGS) is
		external
			"IL signature (System.Data.FillErrorEventArgs): System.Void use System.Data.Common.DbDataAdapter"
		alias
			"OnFillError"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.Common.DbDataAdapter"
		alias
			"Dispose"
		end

	fill_schema_data_table_schema_type_idb_command_command_behavior (data_table: DATA_DATA_TABLE; schema_type: DATA_SCHEMA_TYPE; command: DATA_IDB_COMMAND; behavior: DATA_COMMAND_BEHAVIOR): DATA_DATA_TABLE is
		external
			"IL signature (System.Data.DataTable, System.Data.SchemaType, System.Data.IDbCommand, System.Data.CommandBehavior): System.Data.DataTable use System.Data.Common.DbDataAdapter"
		alias
			"FillSchema"
		end

	update_array_data_row_data_table_mapping (data_rows: NATIVE_ARRAY [DATA_DATA_ROW]; table_mapping: DATA_DATA_TABLE_MAPPING): INTEGER is
		external
			"IL signature (System.Data.DataRow[], System.Data.Common.DataTableMapping): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Update"
		end

	fill_schema_data_set_schema_type_idb_command_string (data_set: DATA_DATA_SET; schema_type: DATA_SCHEMA_TYPE; command: DATA_IDB_COMMAND; src_table: SYSTEM_STRING; behavior: DATA_COMMAND_BEHAVIOR): NATIVE_ARRAY [DATA_DATA_TABLE] is
		external
			"IL signature (System.Data.DataSet, System.Data.SchemaType, System.Data.IDbCommand, System.String, System.Data.CommandBehavior): System.Data.DataTable[] use System.Data.Common.DbDataAdapter"
		alias
			"FillSchema"
		end

	create_row_updated_event (data_row: DATA_DATA_ROW; command: DATA_IDB_COMMAND; statement_type: DATA_STATEMENT_TYPE; table_mapping: DATA_DATA_TABLE_MAPPING): DATA_ROW_UPDATED_EVENT_ARGS is
		external
			"IL deferred signature (System.Data.DataRow, System.Data.IDbCommand, System.Data.StatementType, System.Data.Common.DataTableMapping): System.Data.Common.RowUpdatedEventArgs use System.Data.Common.DbDataAdapter"
		alias
			"CreateRowUpdatedEvent"
		end

	on_row_updating (value: DATA_ROW_UPDATING_EVENT_ARGS) is
		external
			"IL deferred signature (System.Data.Common.RowUpdatingEventArgs): System.Void use System.Data.Common.DbDataAdapter"
		alias
			"OnRowUpdating"
		end

	fill_data_table_idata_reader (data_table: DATA_DATA_TABLE; data_reader: DATA_IDATA_READER): INTEGER is
		external
			"IL signature (System.Data.DataTable, System.Data.IDataReader): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

	on_row_updated (value: DATA_ROW_UPDATED_EVENT_ARGS) is
		external
			"IL deferred signature (System.Data.Common.RowUpdatedEventArgs): System.Void use System.Data.Common.DbDataAdapter"
		alias
			"OnRowUpdated"
		end

	fill_data_set_string_idata_reader (data_set: DATA_DATA_SET; src_table: SYSTEM_STRING; data_reader: DATA_IDATA_READER; start_record: INTEGER; max_records: INTEGER): INTEGER is
		external
			"IL signature (System.Data.DataSet, System.String, System.Data.IDataReader, System.Int32, System.Int32): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

end -- class DATA_DB_DATA_ADAPTER
