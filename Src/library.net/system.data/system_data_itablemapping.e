indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.ITableMapping"

deferred external class
	SYSTEM_DATA_ITABLEMAPPING

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_data_set_table: STRING is
		external
			"IL deferred signature (): System.String use System.Data.ITableMapping"
		alias
			"get_DataSetTable"
		end

	get_source_table: STRING is
		external
			"IL deferred signature (): System.String use System.Data.ITableMapping"
		alias
			"get_SourceTable"
		end

	get_column_mappings: SYSTEM_DATA_ICOLUMNMAPPINGCOLLECTION is
		external
			"IL deferred signature (): System.Data.IColumnMappingCollection use System.Data.ITableMapping"
		alias
			"get_ColumnMappings"
		end

feature -- Element Change

	set_source_table (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.ITableMapping"
		alias
			"set_SourceTable"
		end

	set_data_set_table (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.ITableMapping"
		alias
			"set_DataSetTable"
		end

end -- class SYSTEM_DATA_ITABLEMAPPING
