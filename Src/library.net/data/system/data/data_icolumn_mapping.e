indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.IColumnMapping"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_ICOLUMN_MAPPING

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_source_column: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Data.IColumnMapping"
		alias
			"get_SourceColumn"
		end

	get_data_set_column: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Data.IColumnMapping"
		alias
			"get_DataSetColumn"
		end

feature -- Element Change

	set_source_column (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IColumnMapping"
		alias
			"set_SourceColumn"
		end

	set_data_set_column (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IColumnMapping"
		alias
			"set_DataSetColumn"
		end

end -- class DATA_ICOLUMN_MAPPING
