indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.IDataParameter"

deferred external class
	SYSTEM_DATA_IDATAPARAMETER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_direction: SYSTEM_DATA_PARAMETERDIRECTION is
		external
			"IL deferred signature (): System.Data.ParameterDirection use System.Data.IDataParameter"
		alias
			"get_Direction"
		end

	get_db_type: SYSTEM_DATA_DBTYPE is
		external
			"IL deferred signature (): System.Data.DbType use System.Data.IDataParameter"
		alias
			"get_DbType"
		end

	get_parameter_name: STRING is
		external
			"IL deferred signature (): System.String use System.Data.IDataParameter"
		alias
			"get_ParameterName"
		end

	get_source_version: SYSTEM_DATA_DATAROWVERSION is
		external
			"IL deferred signature (): System.Data.DataRowVersion use System.Data.IDataParameter"
		alias
			"get_SourceVersion"
		end

	get_source_column: STRING is
		external
			"IL deferred signature (): System.String use System.Data.IDataParameter"
		alias
			"get_SourceColumn"
		end

	get_value: ANY is
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

	set_source_version (value: SYSTEM_DATA_DATAROWVERSION) is
		external
			"IL deferred signature (System.Data.DataRowVersion): System.Void use System.Data.IDataParameter"
		alias
			"set_SourceVersion"
		end

	set_source_column (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IDataParameter"
		alias
			"set_SourceColumn"
		end

	set_value (value: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use System.Data.IDataParameter"
		alias
			"set_Value"
		end

	set_direction (value: SYSTEM_DATA_PARAMETERDIRECTION) is
		external
			"IL deferred signature (System.Data.ParameterDirection): System.Void use System.Data.IDataParameter"
		alias
			"set_Direction"
		end

	set_parameter_name (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IDataParameter"
		alias
			"set_ParameterName"
		end

	set_db_type (value: SYSTEM_DATA_DBTYPE) is
		external
			"IL deferred signature (System.Data.DbType): System.Void use System.Data.IDataParameter"
		alias
			"set_DbType"
		end

end -- class SYSTEM_DATA_IDATAPARAMETER
