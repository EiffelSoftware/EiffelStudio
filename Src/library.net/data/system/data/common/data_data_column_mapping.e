indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.Common.DataColumnMapping"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_DATA_COLUMN_MAPPING

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			to_string
		end
	DATA_ICOLUMN_MAPPING
	ICLONEABLE
		rename
			clone_ as system_icloneable_clone
		end

create
	make_data_data_column_mapping,
	make_data_data_column_mapping_1

feature {NONE} -- Initialization

	frozen make_data_data_column_mapping is
		external
			"IL creator use System.Data.Common.DataColumnMapping"
		end

	frozen make_data_data_column_mapping_1 (source_column: SYSTEM_STRING; data_set_column: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Data.Common.DataColumnMapping"
		end

feature -- Access

	frozen get_source_column: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.Common.DataColumnMapping"
		alias
			"get_SourceColumn"
		end

	frozen get_data_set_column: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.Common.DataColumnMapping"
		alias
			"get_DataSetColumn"
		end

feature -- Element Change

	frozen set_source_column (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.Common.DataColumnMapping"
		alias
			"set_SourceColumn"
		end

	frozen set_data_set_column (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.Common.DataColumnMapping"
		alias
			"set_DataSetColumn"
		end

feature -- Basic Operations

	frozen get_data_column_by_schema_action (data_table: DATA_DATA_TABLE; data_type: TYPE; schema_action: DATA_MISSING_SCHEMA_ACTION): DATA_DATA_COLUMN is
		external
			"IL signature (System.Data.DataTable, System.Type, System.Data.MissingSchemaAction): System.Data.DataColumn use System.Data.Common.DataColumnMapping"
		alias
			"GetDataColumnBySchemaAction"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.Common.DataColumnMapping"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	frozen system_icloneable_clone: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.Common.DataColumnMapping"
		alias
			"System.ICloneable.Clone"
		end

end -- class DATA_DATA_COLUMN_MAPPING
