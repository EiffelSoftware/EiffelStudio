indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.ITableMapping"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_ITABLE_MAPPING

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_data_set_table: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Data.ITableMapping"
		alias
			"get_DataSetTable"
		end

	get_source_table: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Data.ITableMapping"
		alias
			"get_SourceTable"
		end

	get_column_mappings: DATA_ICOLUMN_MAPPING_COLLECTION is
		external
			"IL deferred signature (): System.Data.IColumnMappingCollection use System.Data.ITableMapping"
		alias
			"get_ColumnMappings"
		end

feature -- Element Change

	set_source_table (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.ITableMapping"
		alias
			"set_SourceTable"
		end

	set_data_set_table (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.ITableMapping"
		alias
			"set_DataSetTable"
		end

end -- class DATA_ITABLE_MAPPING
