indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.IColumnMapping"

deferred external class
	SYSTEM_DATA_ICOLUMNMAPPING

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_source_column: STRING is
		external
			"IL deferred signature (): System.String use System.Data.IColumnMapping"
		alias
			"get_SourceColumn"
		end

	get_data_set_column: STRING is
		external
			"IL deferred signature (): System.String use System.Data.IColumnMapping"
		alias
			"get_DataSetColumn"
		end

feature -- Element Change

	set_source_column (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IColumnMapping"
		alias
			"set_SourceColumn"
		end

	set_data_set_column (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IColumnMapping"
		alias
			"set_DataSetColumn"
		end

end -- class SYSTEM_DATA_ICOLUMNMAPPING
