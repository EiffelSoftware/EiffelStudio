indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.Common.DataTableMapping"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_DATA_TABLE_MAPPING

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			to_string
		end
	DATA_ITABLE_MAPPING
		rename
			get_column_mappings as system_data_itable_mapping_get_column_mappings
		end
	ICLONEABLE
		rename
			clone_ as system_icloneable_clone
		end

create
	make_data_data_table_mapping_1,
	make_data_data_table_mapping,
	make_data_data_table_mapping_2

feature {NONE} -- Initialization

	frozen make_data_data_table_mapping_1 (source_table: SYSTEM_STRING; data_set_table: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Data.Common.DataTableMapping"
		end

	frozen make_data_data_table_mapping is
		external
			"IL creator use System.Data.Common.DataTableMapping"
		end

	frozen make_data_data_table_mapping_2 (source_table: SYSTEM_STRING; data_set_table: SYSTEM_STRING; column_mappings: NATIVE_ARRAY [DATA_DATA_COLUMN_MAPPING]) is
		external
			"IL creator signature (System.String, System.String, System.Data.Common.DataColumnMapping[]) use System.Data.Common.DataTableMapping"
		end

feature -- Access

	frozen get_data_set_table: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.Common.DataTableMapping"
		alias
			"get_DataSetTable"
		end

	frozen get_source_table: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.Common.DataTableMapping"
		alias
			"get_SourceTable"
		end

	frozen get_column_mappings: DATA_DATA_COLUMN_MAPPING_COLLECTION is
		external
			"IL signature (): System.Data.Common.DataColumnMappingCollection use System.Data.Common.DataTableMapping"
		alias
			"get_ColumnMappings"
		end

feature -- Element Change

	frozen set_source_table (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.Common.DataTableMapping"
		alias
			"set_SourceTable"
		end

	frozen set_data_set_table (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.Common.DataTableMapping"
		alias
			"set_DataSetTable"
		end

feature -- Basic Operations

	frozen get_column_mapping_by_schema_action (source_column: SYSTEM_STRING; mapping_action: DATA_MISSING_MAPPING_ACTION): DATA_DATA_COLUMN_MAPPING is
		external
			"IL signature (System.String, System.Data.MissingMappingAction): System.Data.Common.DataColumnMapping use System.Data.Common.DataTableMapping"
		alias
			"GetColumnMappingBySchemaAction"
		end

	frozen get_data_table_by_schema_action (data_set: DATA_DATA_SET; schema_action: DATA_MISSING_SCHEMA_ACTION): DATA_DATA_TABLE is
		external
			"IL signature (System.Data.DataSet, System.Data.MissingSchemaAction): System.Data.DataTable use System.Data.Common.DataTableMapping"
		alias
			"GetDataTableBySchemaAction"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.Common.DataTableMapping"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	frozen system_data_itable_mapping_get_column_mappings: DATA_ICOLUMN_MAPPING_COLLECTION is
		external
			"IL signature (): System.Data.IColumnMappingCollection use System.Data.Common.DataTableMapping"
		alias
			"System.Data.ITableMapping.get_ColumnMappings"
		end

	frozen system_icloneable_clone: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.Common.DataTableMapping"
		alias
			"System.ICloneable.Clone"
		end

end -- class DATA_DATA_TABLE_MAPPING
