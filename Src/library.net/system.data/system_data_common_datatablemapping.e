indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.Common.DataTableMapping"

frozen external class
	SYSTEM_DATA_COMMON_DATATABLEMAPPING

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			to_string
		end
	SYSTEM_DATA_ITABLEMAPPING
		rename
			get_column_mappings as system_data_itable_mapping_get_column_mappings
		end
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end

create
	make_datatablemapping,
	make_datatablemapping_2,
	make_datatablemapping_1

feature {NONE} -- Initialization

	frozen make_datatablemapping is
		external
			"IL creator use System.Data.Common.DataTableMapping"
		end

	frozen make_datatablemapping_2 (source_table: STRING; data_set_table: STRING; column_mappings: ARRAY [SYSTEM_DATA_COMMON_DATACOLUMNMAPPING]) is
		external
			"IL creator signature (System.String, System.String, System.Data.Common.DataColumnMapping[]) use System.Data.Common.DataTableMapping"
		end

	frozen make_datatablemapping_1 (source_table: STRING; data_set_table: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Data.Common.DataTableMapping"
		end

feature -- Access

	frozen get_data_set_table: STRING is
		external
			"IL signature (): System.String use System.Data.Common.DataTableMapping"
		alias
			"get_DataSetTable"
		end

	frozen get_source_table: STRING is
		external
			"IL signature (): System.String use System.Data.Common.DataTableMapping"
		alias
			"get_SourceTable"
		end

	frozen get_column_mappings: SYSTEM_DATA_COMMON_DATACOLUMNMAPPINGCOLLECTION is
		external
			"IL signature (): System.Data.Common.DataColumnMappingCollection use System.Data.Common.DataTableMapping"
		alias
			"get_ColumnMappings"
		end

feature -- Element Change

	frozen set_source_table (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.Common.DataTableMapping"
		alias
			"set_SourceTable"
		end

	frozen set_data_set_table (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.Common.DataTableMapping"
		alias
			"set_DataSetTable"
		end

feature -- Basic Operations

	frozen get_column_mapping_by_schema_action (source_column: STRING; mapping_action: SYSTEM_DATA_MISSINGMAPPINGACTION): SYSTEM_DATA_COMMON_DATACOLUMNMAPPING is
		external
			"IL signature (System.String, System.Data.MissingMappingAction): System.Data.Common.DataColumnMapping use System.Data.Common.DataTableMapping"
		alias
			"GetColumnMappingBySchemaAction"
		end

	frozen get_data_table_by_schema_action (data_set: SYSTEM_DATA_DATASET; schema_action: SYSTEM_DATA_MISSINGSCHEMAACTION): SYSTEM_DATA_DATATABLE is
		external
			"IL signature (System.Data.DataSet, System.Data.MissingSchemaAction): System.Data.DataTable use System.Data.Common.DataTableMapping"
		alias
			"GetDataTableBySchemaAction"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.Common.DataTableMapping"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	frozen system_data_itable_mapping_get_column_mappings: SYSTEM_DATA_ICOLUMNMAPPINGCOLLECTION is
		external
			"IL signature (): System.Data.IColumnMappingCollection use System.Data.Common.DataTableMapping"
		alias
			"System.Data.ITableMapping.get_ColumnMappings"
		end

	frozen system_icloneable_clone: ANY is
		external
			"IL signature (): System.Object use System.Data.Common.DataTableMapping"
		alias
			"System.ICloneable.Clone"
		end

end -- class SYSTEM_DATA_COMMON_DATATABLEMAPPING
