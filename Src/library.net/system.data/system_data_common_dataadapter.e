indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.Common.DataAdapter"

deferred external class
	SYSTEM_DATA_COMMON_DATAADAPTER

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_DATA_IDATAADAPTER
		rename
			get_table_mappings as system_data_idata_adapter_get_table_mappings
		end
	SYSTEM_IDISPOSABLE

feature -- Access

	frozen get_table_mappings: SYSTEM_DATA_COMMON_DATATABLEMAPPINGCOLLECTION is
		external
			"IL signature (): System.Data.Common.DataTableMappingCollection use System.Data.Common.DataAdapter"
		alias
			"get_TableMappings"
		end

	frozen get_accept_changes_during_fill: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DataAdapter"
		alias
			"get_AcceptChangesDuringFill"
		end

	frozen get_missing_schema_action: SYSTEM_DATA_MISSINGSCHEMAACTION is
		external
			"IL signature (): System.Data.MissingSchemaAction use System.Data.Common.DataAdapter"
		alias
			"get_MissingSchemaAction"
		end

	frozen get_missing_mapping_action: SYSTEM_DATA_MISSINGMAPPINGACTION is
		external
			"IL signature (): System.Data.MissingMappingAction use System.Data.Common.DataAdapter"
		alias
			"get_MissingMappingAction"
		end

feature -- Element Change

	frozen set_missing_mapping_action (value: SYSTEM_DATA_MISSINGMAPPINGACTION) is
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

	frozen set_missing_schema_action (value: SYSTEM_DATA_MISSINGSCHEMAACTION) is
		external
			"IL signature (System.Data.MissingSchemaAction): System.Void use System.Data.Common.DataAdapter"
		alias
			"set_MissingSchemaAction"
		end

feature -- Basic Operations

	fill (data_set: SYSTEM_DATA_DATASET): INTEGER is
		external
			"IL deferred signature (System.Data.DataSet): System.Int32 use System.Data.Common.DataAdapter"
		alias
			"Fill"
		end

	get_fill_parameters: ARRAY [SYSTEM_DATA_IDATAPARAMETER] is
		external
			"IL deferred signature (): System.Data.IDataParameter[] use System.Data.Common.DataAdapter"
		alias
			"GetFillParameters"
		end

	fill_schema (data_set: SYSTEM_DATA_DATASET; schema_type: SYSTEM_DATA_SCHEMATYPE): ARRAY [SYSTEM_DATA_DATATABLE] is
		external
			"IL deferred signature (System.Data.DataSet, System.Data.SchemaType): System.Data.DataTable[] use System.Data.Common.DataAdapter"
		alias
			"FillSchema"
		end

	update (data_set: SYSTEM_DATA_DATASET): INTEGER is
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

	clone_internals: SYSTEM_DATA_COMMON_DATAADAPTER is
		external
			"IL signature (): System.Data.Common.DataAdapter use System.Data.Common.DataAdapter"
		alias
			"CloneInternals"
		end

	create_table_mappings: SYSTEM_DATA_COMMON_DATATABLEMAPPINGCOLLECTION is
		external
			"IL signature (): System.Data.Common.DataTableMappingCollection use System.Data.Common.DataAdapter"
		alias
			"CreateTableMappings"
		end

	frozen system_data_idata_adapter_get_table_mappings: SYSTEM_DATA_ITABLEMAPPINGCOLLECTION is
		external
			"IL signature (): System.Data.ITableMappingCollection use System.Data.Common.DataAdapter"
		alias
			"System.Data.IDataAdapter.get_TableMappings"
		end

end -- class SYSTEM_DATA_COMMON_DATAADAPTER
