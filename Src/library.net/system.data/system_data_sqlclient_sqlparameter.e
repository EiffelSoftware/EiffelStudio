indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlParameter"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLPARAMETER

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			to_string
		end
	SYSTEM_DATA_IDATAPARAMETER
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end

create
	make_sqlparameter_2,
	make_sqlparameter_1,
	make_sqlparameter,
	make_sqlparameter_5,
	make_sqlparameter_4,
	make_sqlparameter_3

feature {NONE} -- Initialization

	frozen make_sqlparameter_2 (parameter_name: STRING; db_type: SYSTEM_DATA_SQLDBTYPE) is
		external
			"IL creator signature (System.String, System.Data.SqlDbType) use System.Data.SqlClient.SqlParameter"
		end

	frozen make_sqlparameter_1 (parameter_name: STRING; db_type: SYSTEM_DATA_SQLDBTYPE; size: INTEGER; direction: SYSTEM_DATA_PARAMETERDIRECTION; is_nullable: BOOLEAN; precision: INTEGER_8; scale: INTEGER_8; source_column: STRING; source_version: SYSTEM_DATA_DATAROWVERSION; value: ANY) is
		external
			"IL creator signature (System.String, System.Data.SqlDbType, System.Int32, System.Data.ParameterDirection, System.Boolean, System.Byte, System.Byte, System.String, System.Data.DataRowVersion, System.Object) use System.Data.SqlClient.SqlParameter"
		end

	frozen make_sqlparameter is
		external
			"IL creator use System.Data.SqlClient.SqlParameter"
		end

	frozen make_sqlparameter_5 (parameter_name: STRING; db_type: SYSTEM_DATA_SQLDBTYPE; size: INTEGER; source_column: STRING) is
		external
			"IL creator signature (System.String, System.Data.SqlDbType, System.Int32, System.String) use System.Data.SqlClient.SqlParameter"
		end

	frozen make_sqlparameter_4 (parameter_name: STRING; db_type: SYSTEM_DATA_SQLDBTYPE; size: INTEGER) is
		external
			"IL creator signature (System.String, System.Data.SqlDbType, System.Int32) use System.Data.SqlClient.SqlParameter"
		end

	frozen make_sqlparameter_3 (parameter_name: STRING; value: ANY) is
		external
			"IL creator signature (System.String, System.Object) use System.Data.SqlClient.SqlParameter"
		end

feature -- Access

	frozen get_value: ANY is
		external
			"IL signature (): System.Object use System.Data.SqlClient.SqlParameter"
		alias
			"get_Value"
		end

	frozen get_db_type: SYSTEM_DATA_DBTYPE is
		external
			"IL signature (): System.Data.DbType use System.Data.SqlClient.SqlParameter"
		alias
			"get_DbType"
		end

	frozen get_source_column: STRING is
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

	frozen get_direction: SYSTEM_DATA_PARAMETERDIRECTION is
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

	frozen get_source_version: SYSTEM_DATA_DATAROWVERSION is
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

	frozen get_parameter_name: STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlParameter"
		alias
			"get_ParameterName"
		end

	frozen get_sql_db_type: SYSTEM_DATA_SQLDBTYPE is
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

	frozen set_parameter_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_ParameterName"
		end

	frozen set_value (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_Value"
		end

	frozen set_db_type (value: SYSTEM_DATA_DBTYPE) is
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

	frozen set_precision (value: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_Precision"
		end

	frozen set_offset (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_Offset"
		end

	frozen set_direction (value: SYSTEM_DATA_PARAMETERDIRECTION) is
		external
			"IL signature (System.Data.ParameterDirection): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_Direction"
		end

	frozen set_source_version (value: SYSTEM_DATA_DATAROWVERSION) is
		external
			"IL signature (System.Data.DataRowVersion): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_SourceVersion"
		end

	frozen set_source_column (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_SourceColumn"
		end

	frozen set_sql_db_type (value: SYSTEM_DATA_SQLDBTYPE) is
		external
			"IL signature (System.Data.SqlDbType): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_SqlDbType"
		end

	frozen set_is_nullable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.SqlClient.SqlParameter"
		alias
			"set_IsNullable"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlParameter"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	frozen system_icloneable_clone: ANY is
		external
			"IL signature (): System.Object use System.Data.SqlClient.SqlParameter"
		alias
			"System.ICloneable.Clone"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLPARAMETER
