indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.Common.DataColumnMapping"

frozen external class
	SYSTEM_DATA_COMMON_DATACOLUMNMAPPING

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			to_string
		end
	SYSTEM_DATA_ICOLUMNMAPPING
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end

create
	make_datacolumnmapping,
	make_datacolumnmapping_1

feature {NONE} -- Initialization

	frozen make_datacolumnmapping is
		external
			"IL creator use System.Data.Common.DataColumnMapping"
		end

	frozen make_datacolumnmapping_1 (source_column: STRING; data_set_column: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Data.Common.DataColumnMapping"
		end

feature -- Access

	frozen get_source_column: STRING is
		external
			"IL signature (): System.String use System.Data.Common.DataColumnMapping"
		alias
			"get_SourceColumn"
		end

	frozen get_data_set_column: STRING is
		external
			"IL signature (): System.String use System.Data.Common.DataColumnMapping"
		alias
			"get_DataSetColumn"
		end

feature -- Element Change

	frozen set_source_column (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.Common.DataColumnMapping"
		alias
			"set_SourceColumn"
		end

	frozen set_data_set_column (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.Common.DataColumnMapping"
		alias
			"set_DataSetColumn"
		end

feature -- Basic Operations

	frozen get_data_column_by_schema_action (data_table: SYSTEM_DATA_DATATABLE; data_type: SYSTEM_TYPE; schema_action: SYSTEM_DATA_MISSINGSCHEMAACTION): SYSTEM_DATA_DATACOLUMN is
		external
			"IL signature (System.Data.DataTable, System.Type, System.Data.MissingSchemaAction): System.Data.DataColumn use System.Data.Common.DataColumnMapping"
		alias
			"GetDataColumnBySchemaAction"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.Common.DataColumnMapping"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	frozen system_icloneable_clone: ANY is
		external
			"IL signature (): System.Object use System.Data.Common.DataColumnMapping"
		alias
			"System.ICloneable.Clone"
		end

end -- class SYSTEM_DATA_COMMON_DATACOLUMNMAPPING
