indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.IDataAdapter"

deferred external class
	SYSTEM_DATA_IDATAADAPTER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_table_mappings: SYSTEM_DATA_ITABLEMAPPINGCOLLECTION is
		external
			"IL deferred signature (): System.Data.ITableMappingCollection use System.Data.IDataAdapter"
		alias
			"get_TableMappings"
		end

	get_missing_schema_action: SYSTEM_DATA_MISSINGSCHEMAACTION is
		external
			"IL deferred signature (): System.Data.MissingSchemaAction use System.Data.IDataAdapter"
		alias
			"get_MissingSchemaAction"
		end

	get_missing_mapping_action: SYSTEM_DATA_MISSINGMAPPINGACTION is
		external
			"IL deferred signature (): System.Data.MissingMappingAction use System.Data.IDataAdapter"
		alias
			"get_MissingMappingAction"
		end

feature -- Element Change

	set_missing_mapping_action (value: SYSTEM_DATA_MISSINGMAPPINGACTION) is
		external
			"IL deferred signature (System.Data.MissingMappingAction): System.Void use System.Data.IDataAdapter"
		alias
			"set_MissingMappingAction"
		end

	set_missing_schema_action (value: SYSTEM_DATA_MISSINGSCHEMAACTION) is
		external
			"IL deferred signature (System.Data.MissingSchemaAction): System.Void use System.Data.IDataAdapter"
		alias
			"set_MissingSchemaAction"
		end

feature -- Basic Operations

	fill (data_set: SYSTEM_DATA_DATASET): INTEGER is
		external
			"IL deferred signature (System.Data.DataSet): System.Int32 use System.Data.IDataAdapter"
		alias
			"Fill"
		end

	get_fill_parameters: ARRAY [SYSTEM_DATA_IDATAPARAMETER] is
		external
			"IL deferred signature (): System.Data.IDataParameter[] use System.Data.IDataAdapter"
		alias
			"GetFillParameters"
		end

	fill_schema (data_set: SYSTEM_DATA_DATASET; schema_type: SYSTEM_DATA_SCHEMATYPE): ARRAY [SYSTEM_DATA_DATATABLE] is
		external
			"IL deferred signature (System.Data.DataSet, System.Data.SchemaType): System.Data.DataTable[] use System.Data.IDataAdapter"
		alias
			"FillSchema"
		end

	update (data_set: SYSTEM_DATA_DATASET): INTEGER is
		external
			"IL deferred signature (System.Data.DataSet): System.Int32 use System.Data.IDataAdapter"
		alias
			"Update"
		end

end -- class SYSTEM_DATA_IDATAADAPTER
