indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.Common.DbDataAdapter"

deferred external class
	SYSTEM_DATA_COMMON_DBDATAADAPTER

inherit
	SYSTEM_DATA_COMMON_DATAADAPTER
		rename
			update as update_data_set
		end
	SYSTEM_DATA_IDATAADAPTER
		rename
			update as update_data_set,
			get_table_mappings as system_data_idata_adapter_get_table_mappings
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ICOMPONENT

feature -- Access

feature -- Element Change

	frozen remove_fill_error (value: SYSTEM_DATA_FILLERROREVENTHANDLER) is
		external
			"IL signature (System.Data.FillErrorEventHandler): System.Void use System.Data.Common.DbDataAdapter"
		alias
			"remove_FillError"
		end

	frozen add_fill_error (value: SYSTEM_DATA_FILLERROREVENTHANDLER) is
		external
			"IL signature (System.Data.FillErrorEventHandler): System.Void use System.Data.Common.DbDataAdapter"
		alias
			"add_FillError"
		end

feature -- Basic Operations

	fill_schema (data_set: SYSTEM_DATA_DATASET; schema_type: SYSTEM_DATA_SCHEMATYPE): ARRAY [SYSTEM_DATA_DATATABLE] is
		external
			"IL signature (System.Data.DataSet, System.Data.SchemaType): System.Data.DataTable[] use System.Data.Common.DbDataAdapter"
		alias
			"FillSchema"
		end

	get_fill_parameters: ARRAY [SYSTEM_DATA_IDATAPARAMETER] is
		external
			"IL signature (): System.Data.IDataParameter[] use System.Data.Common.DbDataAdapter"
		alias
			"GetFillParameters"
		end

	frozen fill_data_table (data_table: SYSTEM_DATA_DATATABLE): INTEGER is
		external
			"IL signature (System.Data.DataTable): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

	frozen fill_data_set_int32_int32_string (data_set: SYSTEM_DATA_DATASET; start_record: INTEGER; max_records: INTEGER; src_table: STRING): INTEGER is
		external
			"IL signature (System.Data.DataSet, System.Int32, System.Int32, System.String): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

	frozen fill_schema_data_table_schema_type (data_table: SYSTEM_DATA_DATATABLE; schema_type: SYSTEM_DATA_SCHEMATYPE): SYSTEM_DATA_DATATABLE is
		external
			"IL signature (System.Data.DataTable, System.Data.SchemaType): System.Data.DataTable use System.Data.Common.DbDataAdapter"
		alias
			"FillSchema"
		end

	frozen update (data_rows: ARRAY [SYSTEM_DATA_DATAROW]): INTEGER is
		external
			"IL signature (System.Data.DataRow[]): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Update"
		end

	frozen update_data_set_string (data_set: SYSTEM_DATA_DATASET; src_table: STRING): INTEGER is
		external
			"IL signature (System.Data.DataSet, System.String): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Update"
		end

	frozen fill_data_set_string (data_set: SYSTEM_DATA_DATASET; src_table: STRING): INTEGER is
		external
			"IL signature (System.Data.DataSet, System.String): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

	fill (data_set: SYSTEM_DATA_DATASET): INTEGER is
		external
			"IL signature (System.Data.DataSet): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

	frozen update_data_table (data_table: SYSTEM_DATA_DATATABLE): INTEGER is
		external
			"IL signature (System.Data.DataTable): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Update"
		end

	update_data_set (data_set: SYSTEM_DATA_DATASET): INTEGER is
		external
			"IL signature (System.Data.DataSet): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Update"
		end

	frozen fill_schema_data_set_schema_type_string (data_set: SYSTEM_DATA_DATASET; schema_type: SYSTEM_DATA_SCHEMATYPE; src_table: STRING): ARRAY [SYSTEM_DATA_DATATABLE] is
		external
			"IL signature (System.Data.DataSet, System.Data.SchemaType, System.String): System.Data.DataTable[] use System.Data.Common.DbDataAdapter"
		alias
			"FillSchema"
		end

feature {NONE} -- Implementation

	fill_data_table_idb_command (data_table: SYSTEM_DATA_DATATABLE; command: SYSTEM_DATA_IDBCOMMAND; behavior: SYSTEM_DATA_COMMANDBEHAVIOR): INTEGER is
		external
			"IL signature (System.Data.DataTable, System.Data.IDbCommand, System.Data.CommandBehavior): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

	create_row_updating_event (data_row: SYSTEM_DATA_DATAROW; command: SYSTEM_DATA_IDBCOMMAND; statement_type: SYSTEM_DATA_STATEMENTTYPE; table_mapping: SYSTEM_DATA_COMMON_DATATABLEMAPPING): SYSTEM_DATA_COMMON_ROWUPDATINGEVENTARGS is
		external
			"IL deferred signature (System.Data.DataRow, System.Data.IDbCommand, System.Data.StatementType, System.Data.Common.DataTableMapping): System.Data.Common.RowUpdatingEventArgs use System.Data.Common.DbDataAdapter"
		alias
			"CreateRowUpdatingEvent"
		end

	fill_data_set_int32_int32_string_idb_command (data_set: SYSTEM_DATA_DATASET; start_record: INTEGER; max_records: INTEGER; src_table: STRING; command: SYSTEM_DATA_IDBCOMMAND; behavior: SYSTEM_DATA_COMMANDBEHAVIOR): INTEGER is
		external
			"IL signature (System.Data.DataSet, System.Int32, System.Int32, System.String, System.Data.IDbCommand, System.Data.CommandBehavior): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

	on_fill_error (value: SYSTEM_DATA_FILLERROREVENTARGS) is
		external
			"IL signature (System.Data.FillErrorEventArgs): System.Void use System.Data.Common.DbDataAdapter"
		alias
			"OnFillError"
		end

	fill_schema_data_table_schema_type_idb_command_command_behavior (data_table: SYSTEM_DATA_DATATABLE; schema_type: SYSTEM_DATA_SCHEMATYPE; command: SYSTEM_DATA_IDBCOMMAND; behavior: SYSTEM_DATA_COMMANDBEHAVIOR): ARRAY [SYSTEM_DATA_DATATABLE] is
		external
			"IL signature (System.Data.DataTable, System.Data.SchemaType, System.Data.IDbCommand, System.Data.CommandBehavior): System.Data.DataTable[] use System.Data.Common.DbDataAdapter"
		alias
			"FillSchema"
		end

	update_array_data_row_data_table_mapping (data_rows: ARRAY [SYSTEM_DATA_DATAROW]; table_mapping: SYSTEM_DATA_COMMON_DATATABLEMAPPING): INTEGER is
		external
			"IL signature (System.Data.DataRow[], System.Data.Common.DataTableMapping): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Update"
		end

	fill_schema_data_set_schema_type_idb_command_string (data_set: SYSTEM_DATA_DATASET; schema_type: SYSTEM_DATA_SCHEMATYPE; command: SYSTEM_DATA_IDBCOMMAND; src_table: STRING; behavior: SYSTEM_DATA_COMMANDBEHAVIOR): ARRAY [SYSTEM_DATA_DATATABLE] is
		external
			"IL signature (System.Data.DataSet, System.Data.SchemaType, System.Data.IDbCommand, System.String, System.Data.CommandBehavior): System.Data.DataTable[] use System.Data.Common.DbDataAdapter"
		alias
			"FillSchema"
		end

	create_row_updated_event (data_row: SYSTEM_DATA_DATAROW; command: SYSTEM_DATA_IDBCOMMAND; statement_type: SYSTEM_DATA_STATEMENTTYPE; table_mapping: SYSTEM_DATA_COMMON_DATATABLEMAPPING): SYSTEM_DATA_COMMON_ROWUPDATEDEVENTARGS is
		external
			"IL deferred signature (System.Data.DataRow, System.Data.IDbCommand, System.Data.StatementType, System.Data.Common.DataTableMapping): System.Data.Common.RowUpdatedEventArgs use System.Data.Common.DbDataAdapter"
		alias
			"CreateRowUpdatedEvent"
		end

	on_row_updating (value: SYSTEM_DATA_COMMON_ROWUPDATINGEVENTARGS) is
		external
			"IL deferred signature (System.Data.Common.RowUpdatingEventArgs): System.Void use System.Data.Common.DbDataAdapter"
		alias
			"OnRowUpdating"
		end

	fill_data_table_idata_reader (data_table: SYSTEM_DATA_DATATABLE; data_reader: SYSTEM_DATA_IDATAREADER): INTEGER is
		external
			"IL signature (System.Data.DataTable, System.Data.IDataReader): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

	on_row_updated (value: SYSTEM_DATA_COMMON_ROWUPDATEDEVENTARGS) is
		external
			"IL deferred signature (System.Data.Common.RowUpdatedEventArgs): System.Void use System.Data.Common.DbDataAdapter"
		alias
			"OnRowUpdated"
		end

	fill_data_set_string_idata_reader (data_set: SYSTEM_DATA_DATASET; src_table: STRING; data_reader: SYSTEM_DATA_IDATAREADER; start_record: INTEGER; max_records: INTEGER): INTEGER is
		external
			"IL signature (System.Data.DataSet, System.String, System.Data.IDataReader, System.Int32, System.Int32): System.Int32 use System.Data.Common.DbDataAdapter"
		alias
			"Fill"
		end

end -- class SYSTEM_DATA_COMMON_DBDATAADAPTER
