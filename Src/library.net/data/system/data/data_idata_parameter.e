indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.IDataParameter"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_IDATA_PARAMETER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_direction: DATA_PARAMETER_DIRECTION is
		external
			"IL deferred signature (): System.Data.ParameterDirection use System.Data.IDataParameter"
		alias
			"get_Direction"
		end

	get_db_type: DATA_DB_TYPE is
		external
			"IL deferred signature (): System.Data.DbType use System.Data.IDataParameter"
		alias
			"get_DbType"
		end

	get_parameter_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Data.IDataParameter"
		alias
			"get_ParameterName"
		end

	get_source_version: DATA_DATA_ROW_VERSION is
		external
			"IL deferred signature (): System.Data.DataRowVersion use System.Data.IDataParameter"
		alias
			"get_SourceVersion"
		end

	get_source_column: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Data.IDataParameter"
		alias
			"get_SourceColumn"
		end

	get_value: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Data.IDataParameter"
		alias
			"get_Value"
		end

	get_is_nullable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Data.IDataParameter"
		alias
			"get_IsNullable"
		end

feature -- Element Change

	set_source_version (value: DATA_DATA_ROW_VERSION) is
		external
			"IL deferred signature (System.Data.DataRowVersion): System.Void use System.Data.IDataParameter"
		alias
			"set_SourceVersion"
		end

	set_source_column (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IDataParameter"
		alias
			"set_SourceColumn"
		end

	set_value (value: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use System.Data.IDataParameter"
		alias
			"set_Value"
		end

	set_direction (value: DATA_PARAMETER_DIRECTION) is
		external
			"IL deferred signature (System.Data.ParameterDirection): System.Void use System.Data.IDataParameter"
		alias
			"set_Direction"
		end

	set_parameter_name (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IDataParameter"
		alias
			"set_ParameterName"
		end

	set_db_type (value: DATA_DB_TYPE) is
		external
			"IL deferred signature (System.Data.DbType): System.Void use System.Data.IDataParameter"
		alias
			"set_DbType"
		end

end -- class DATA_IDATA_PARAMETER
