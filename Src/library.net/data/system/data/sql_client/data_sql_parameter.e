indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlClient.SqlParameter"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_SQL_PARAMETER

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			to_string
		end
	DATA_IDB_DATA_PARAMETER
	DATA_IDATA_PARAMETER
	ICLONEABLE
		rename
			clone_ as system_icloneable_clone
		end

create
	make_data_sql_parameter,
	make_data_sql_parameter_5,
	make_data_sql_parameter_4,
	make_data_sql_parameter_3,
	make_data_sql_parameter_2,
	make_data_sql_parameter_1

feature {NONE} -- Initialization

	frozen make_data_sql_parameter is
		external
			"IL creator use System.Data.SqlClient.SqlParameter"
		end

	frozen make_data_sql_parameter_5 (parameter_name: SYSTEM_STRING; db_type: DATA_SQL_DB_TYPE; size: INTEGER; direction: DATA_PARAMETER_DIRECTION; is_nullable: BOOLEAN; precision: INTEGER_8; scale: INTEGER_8; source_column: SYSTEM_STRING; source_version: DATA_DATA_ROW_VERSION; value: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.String, System.Data.SqlDbType, System.Int32, System.Data.ParameterDirection, System.Boolean, System.Byte, System.Byte, System.String, System.Data.DataRowVersion, System.Object) use System.Data.SqlClient.SqlParameter"
		end

	frozen make_data_sql_parameter_4 (parameter_name: SYSTEM_STRING; db_type: DATA_SQL_DB_TYPE; size: INTEGER; source_column: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.Data.SqlDbType, System.Int32, System.String) use System.Data.SqlClient.SqlParameter"
		end

	frozen make_data_sql_parameter_3 (parameter_name: SYSTEM_STRING; db_type: DATA_SQL_DB_TYPE; size: INTEGER) is
		external
			"IL creator signature (System.String, System.Data.SqlDbType, System.Int32) use System.Data.SqlClient.SqlParameter"
		end

	frozen make_data_sql_parameter_2 (parameter_name: SYSTEM_STRING; db_type: DATA_SQL_DB_TYPE) is
		external
			"IL creator signature (System.String, System.Data.SqlDbType) use System.Data.SqlClient.SqlParameter"
		end

	frozen make_data_sql_parameter_1 (parameter_name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.String, System.Object) use System.Data.SqlClient.SqlParameter"
		end

feature -- Access

	frozen get_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.SqlClient.SqlParameter"
		alias
			"get_Value"
		end

	frozen get_db_type: DATA_DB_TYPE is
		external
			"IL signature (): System.Data.DbType use System.Data.SqlClient.SqlParameter"
		alias
			"get_DbType"
		end

	frozen get_source_column: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlParameter"
		alias
			"get_SourceColumn"
		end

	frozen get_offset: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlClient.SqlParameter"
		alias
			"get_Offset"
		end

	frozen get_precision: INTEGER_8 is
		external
			"IL signature (): System.Byte use System.Data.SqlClient.SqlParameter"
		alias
			"get_Precision"
		end

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlClient.SqlParameter"
		alias
			"get_Size"
		end

	frozen get_direction: DATA_PARAMETER_DIRECTION is
		external
			"IL signature (): System.Data.ParameterDirection use System.Data.SqlClient.SqlParameter"
		alias
			"get_Direction"
		end

	frozen get_is_nullable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlClient.SqlParameter"
		alias
			"get_IsNullable"
		end

	frozen get_source_version: DATA_DATA_ROW_VERSION is
		external
			"IL signature (): System.Data.DataRowVersion use System.Data.SqlClient.SqlParameter"
		alias
			"get_SourceVersion"
		end

	frozen get_scale: INTEGER_8 is
		external
			"IL signature (): System.Byte use System.Data.SqlClient.SqlParameter"
		alias
			"get_Scale"
		end

	frozen get_parameter_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlParameter"
		alias
			"get_ParameterName"
		end

	frozen get_sql_db_type: DATA_SQL_DB_TYPE is
		external
			"IL signature (): System.Data.SqlDbType use System.Data.SqlClient.SqlParameter"
		alias
			"get_SqlDbType"
		end

feature -- Element Change

	frozen set_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_Size"
		end

	frozen set_parameter_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_ParameterName"
		end

	frozen set_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_Value"
		end

	frozen set_db_type (value: DATA_DB_TYPE) is
		external
			"IL signature (System.Data.DbType): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_DbType"
		end

	frozen set_scale (value: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_Scale"
		end

	frozen set_is_nullable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_IsNullable"
		end

	frozen set_offset (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_Offset"
		end

	frozen set_direction (value: DATA_PARAMETER_DIRECTION) is
		external
			"IL signature (System.Data.ParameterDirection): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_Direction"
		end

	frozen set_source_version (value: DATA_DATA_ROW_VERSION) is
		external
			"IL signature (System.Data.DataRowVersion): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_SourceVersion"
		end

	frozen set_source_column (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_SourceColumn"
		end

	frozen set_sql_db_type (value: DATA_SQL_DB_TYPE) is
		external
			"IL signature (System.Data.SqlDbType): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_SqlDbType"
		end

	frozen set_precision (value: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_Precision"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlParameter"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	frozen system_icloneable_clone: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.SqlClient.SqlParameter"
		alias
			"System.ICloneable.Clone"
		end

end -- class DATA_SQL_PARAMETER
