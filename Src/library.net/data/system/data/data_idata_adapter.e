indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.IDataAdapter"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_IDATA_ADAPTER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_table_mappings: DATA_ITABLE_MAPPING_COLLECTION is
		external
			"IL deferred signature (): System.Data.ITableMappingCollection use System.Data.IDataAdapter"
		alias
			"get_TableMappings"
		end

	get_missing_schema_action: DATA_MISSING_SCHEMA_ACTION is
		external
			"IL deferred signature (): System.Data.MissingSchemaAction use System.Data.IDataAdapter"
		alias
			"get_MissingSchemaAction"
		end

	get_missing_mapping_action: DATA_MISSING_MAPPING_ACTION is
		external
			"IL deferred signature (): System.Data.MissingMappingAction use System.Data.IDataAdapter"
		alias
			"get_MissingMappingAction"
		end

feature -- Element Change

	set_missing_mapping_action (value: DATA_MISSING_MAPPING_ACTION) is
		external
			"IL deferred signature (System.Data.MissingMappingAction): System.Void use System.Data.IDataAdapter"
		alias
			"set_MissingMappingAction"
		end

	set_missing_schema_action (value: DATA_MISSING_SCHEMA_ACTION) is
		external
			"IL deferred signature (System.Data.MissingSchemaAction): System.Void use System.Data.IDataAdapter"
		alias
			"set_MissingSchemaAction"
		end

feature -- Basic Operations

	fill (data_set: DATA_DATA_SET): INTEGER is
		external
			"IL deferred signature (System.Data.DataSet): System.Int32 use System.Data.IDataAdapter"
		alias
			"Fill"
		end

	get_fill_parameters: NATIVE_ARRAY [DATA_IDATA_PARAMETER] is
		external
			"IL deferred signature (): System.Data.IDataParameter[] use System.Data.IDataAdapter"
		alias
			"GetFillParameters"
		end

	fill_schema (data_set: DATA_DATA_SET; schema_type: DATA_SCHEMA_TYPE): NATIVE_ARRAY [DATA_DATA_TABLE] is
		external
			"IL deferred signature (System.Data.DataSet, System.Data.SchemaType): System.Data.DataTable[] use System.Data.IDataAdapter"
		alias
			"FillSchema"
		end

	update (data_set: DATA_DATA_SET): INTEGER is
		external
			"IL deferred signature (System.Data.DataSet): System.Int32 use System.Data.IDataAdapter"
		alias
			"Update"
		end

end -- class DATA_IDATA_ADAPTER
