indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.Common.DataAdapter"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_DATA_ADAPTER

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	DATA_IDATA_ADAPTER
		rename
			get_table_mappings as system_data_idata_adapter_get_table_mappings
		end

feature -- Access

	frozen get_table_mappings: DATA_DATA_TABLE_MAPPING_COLLECTION is
		external
			"IL signature (): System.Data.Common.DataTableMappingCollection use System.Data.Common.DataAdapter"
		alias
			"get_TableMappings"
		end

	frozen get_continue_update_on_error: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DataAdapter"
		alias
			"get_ContinueUpdateOnError"
		end

	frozen get_accept_changes_during_fill: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DataAdapter"
		alias
			"get_AcceptChangesDuringFill"
		end

	frozen get_missing_schema_action: DATA_MISSING_SCHEMA_ACTION is
		external
			"IL signature (): System.Data.MissingSchemaAction use System.Data.Common.DataAdapter"
		alias
			"get_MissingSchemaAction"
		end

	frozen get_missing_mapping_action: DATA_MISSING_MAPPING_ACTION is
		external
			"IL signature (): System.Data.MissingMappingAction use System.Data.Common.DataAdapter"
		alias
			"get_MissingMappingAction"
		end

feature -- Element Change

	frozen set_missing_mapping_action (value: DATA_MISSING_MAPPING_ACTION) is
		external
			"IL signature (System.Data.MissingMappingAction): System.Void use System.Data.Common.DataAdapter"
		alias
			"set_MissingMappingAction"
		end

	frozen set_accept_changes_during_fill (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.Common.DataAdapter"
		alias
			"set_AcceptChangesDuringFill"
		end

	frozen set_continue_update_on_error (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.Common.DataAdapter"
		alias
			"set_ContinueUpdateOnError"
		end

	frozen set_missing_schema_action (value: DATA_MISSING_SCHEMA_ACTION) is
		external
			"IL signature (System.Data.MissingSchemaAction): System.Void use System.Data.Common.DataAdapter"
		alias
			"set_MissingSchemaAction"
		end

feature -- Basic Operations

	fill (data_set: DATA_DATA_SET): INTEGER is
		external
			"IL deferred signature (System.Data.DataSet): System.Int32 use System.Data.Common.DataAdapter"
		alias
			"Fill"
		end

	get_fill_parameters: NATIVE_ARRAY [DATA_IDATA_PARAMETER] is
		external
			"IL deferred signature (): System.Data.IDataParameter[] use System.Data.Common.DataAdapter"
		alias
			"GetFillParameters"
		end

	fill_schema (data_set: DATA_DATA_SET; schema_type: DATA_SCHEMA_TYPE): NATIVE_ARRAY [DATA_DATA_TABLE] is
		external
			"IL deferred signature (System.Data.DataSet, System.Data.SchemaType): System.Data.DataTable[] use System.Data.Common.DataAdapter"
		alias
			"FillSchema"
		end

	update (data_set: DATA_DATA_SET): INTEGER is
		external
			"IL deferred signature (System.Data.DataSet): System.Int32 use System.Data.Common.DataAdapter"
		alias
			"Update"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.Common.DataAdapter"
		alias
			"Dispose"
		end

	should_serialize_table_mappings: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DataAdapter"
		alias
			"ShouldSerializeTableMappings"
		end

	clone_internals: DATA_DATA_ADAPTER is
		external
			"IL signature (): System.Data.Common.DataAdapter use System.Data.Common.DataAdapter"
		alias
			"CloneInternals"
		end

	create_table_mappings: DATA_DATA_TABLE_MAPPING_COLLECTION is
		external
			"IL signature (): System.Data.Common.DataTableMappingCollection use System.Data.Common.DataAdapter"
		alias
			"CreateTableMappings"
		end

	frozen system_data_idata_adapter_get_table_mappings: DATA_ITABLE_MAPPING_COLLECTION is
		external
			"IL signature (): System.Data.ITableMappingCollection use System.Data.Common.DataAdapter"
		alias
			"System.Data.IDataAdapter.get_TableMappings"
		end

end -- class DATA_DATA_ADAPTER
