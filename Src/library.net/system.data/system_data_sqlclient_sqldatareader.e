indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlDataReader"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLDATAREADER

inherit
	SYSTEM_DATA_IDATARECORD
	SYSTEM_MARSHALBYREFOBJECT
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end
	SYSTEM_DATA_IDATAREADER
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create {NONE}

feature -- Access

	frozen get_records_affected: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlClient.SqlDataReader"
		alias
			"get_RecordsAffected"
		end

	frozen get_item (i: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Data.SqlClient.SqlDataReader"
		alias
			"get_Item"
		end

	frozen get_depth: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlClient.SqlDataReader"
		alias
			"get_Depth"
		end

	frozen get_item_string (name: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Data.SqlClient.SqlDataReader"
		alias
			"get_Item"
		end

	frozen get_field_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlClient.SqlDataReader"
		alias
			"get_FieldCount"
		end

	frozen get_is_closed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlClient.SqlDataReader"
		alias
			"get_IsClosed"
		end

feature -- Basic Operations

	frozen next_result: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlClient.SqlDataReader"
		alias
			"NextResult"
		end

	frozen get_sql_boolean (i: INTEGER): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL signature (System.Int32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlBoolean"
		end

	frozen get_int64 (i: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int32): System.Int64 use System.Data.SqlClient.SqlDataReader"
		alias
			"GetInt64"
		end

	frozen get_byte (i: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use System.Data.SqlClient.SqlDataReader"
		alias
			"GetByte"
		end

	frozen get_schema_table: SYSTEM_DATA_DATATABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSchemaTable"
		end

	frozen get_sql_string (i: INTEGER): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL signature (System.Int32): System.Data.SqlTypes.SqlString use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlString"
		end

	frozen is_dbnull (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Data.SqlClient.SqlDataReader"
		alias
			"IsDBNull"
		end

	frozen get_sql_value (i: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlValue"
		end

	frozen get_guid (i: INTEGER): SYSTEM_GUID is
		external
			"IL signature (System.Int32): System.Guid use System.Data.SqlClient.SqlDataReader"
		alias
			"GetGuid"
		end

	frozen get_date_time (i: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.Int32): System.DateTime use System.Data.SqlClient.SqlDataReader"
		alias
			"GetDateTime"
		end

	frozen get_int16 (i: INTEGER): INTEGER_16 is
		external
			"IL signature (System.Int32): System.Int16 use System.Data.SqlClient.SqlDataReader"
		alias
			"GetInt16"
		end

	frozen get_int32 (i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Data.SqlClient.SqlDataReader"
		alias
			"GetInt32"
		end

	frozen get_sql_single (i: INTEGER): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL signature (System.Int32): System.Data.SqlTypes.SqlSingle use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlSingle"
		end

	frozen read: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlClient.SqlDataReader"
		alias
			"Read"
		end

	frozen get_sql_values (values: ARRAY [ANY]): INTEGER is
		external
			"IL signature (System.Object[]): System.Int32 use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlValues"
		end

	frozen get_sql_guid (i: INTEGER): SYSTEM_DATA_SQLTYPES_SQLGUID is
		external
			"IL signature (System.Int32): System.Data.SqlTypes.SqlGuid use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlGuid"
		end

	frozen get_sql_int32 (i: INTEGER): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL signature (System.Int32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlInt32"
		end

	frozen get_sql_double (i: INTEGER): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL signature (System.Int32): System.Data.SqlTypes.SqlDouble use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlDouble"
		end

	frozen get_data (i: INTEGER): SYSTEM_DATA_IDATAREADER is
		external
			"IL signature (System.Int32): System.Data.IDataReader use System.Data.SqlClient.SqlDataReader"
		alias
			"GetData"
		end

	frozen get_char (i: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use System.Data.SqlClient.SqlDataReader"
		alias
			"GetChar"
		end

	frozen get_double (i: INTEGER): DOUBLE is
		external
			"IL signature (System.Int32): System.Double use System.Data.SqlClient.SqlDataReader"
		alias
			"GetDouble"
		end

	frozen get_sql_int64 (i: INTEGER): SYSTEM_DATA_SQLTYPES_SQLINT64 is
		external
			"IL signature (System.Int32): System.Data.SqlTypes.SqlInt64 use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlInt64"
		end

	frozen get_decimal (i: INTEGER): SYSTEM_DECIMAL is
		external
			"IL signature (System.Int32): System.Decimal use System.Data.SqlClient.SqlDataReader"
		alias
			"GetDecimal"
		end

	frozen get_boolean (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Data.SqlClient.SqlDataReader"
		alias
			"GetBoolean"
		end

	frozen get_values (values: ARRAY [ANY]): INTEGER is
		external
			"IL signature (System.Object[]): System.Int32 use System.Data.SqlClient.SqlDataReader"
		alias
			"GetValues"
		end

	frozen get_ordinal (name: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.SqlClient.SqlDataReader"
		alias
			"GetOrdinal"
		end

	frozen get_field_type (i: INTEGER): SYSTEM_TYPE is
		external
			"IL signature (System.Int32): System.Type use System.Data.SqlClient.SqlDataReader"
		alias
			"GetFieldType"
		end

	frozen get_sql_decimal (i: INTEGER): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL signature (System.Int32): System.Data.SqlTypes.SqlDecimal use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlDecimal"
		end

	frozen get_name (i: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Data.SqlClient.SqlDataReader"
		alias
			"GetName"
		end

	frozen get_sql_binary (i: INTEGER): SYSTEM_DATA_SQLTYPES_SQLBINARY is
		external
			"IL signature (System.Int32): System.Data.SqlTypes.SqlBinary use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlBinary"
		end

	frozen get_bytes (i: INTEGER; data_index: INTEGER_64; buffer: ARRAY [INTEGER_8]; buffer_index: INTEGER; length: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int32, System.Int64, System.Byte[], System.Int32, System.Int32): System.Int64 use System.Data.SqlClient.SqlDataReader"
		alias
			"GetBytes"
		end

	frozen get_value (i: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Data.SqlClient.SqlDataReader"
		alias
			"GetValue"
		end

	frozen get_sql_date_time (i: INTEGER): SYSTEM_DATA_SQLTYPES_SQLDATETIME is
		external
			"IL signature (System.Int32): System.Data.SqlTypes.SqlDateTime use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlDateTime"
		end

	frozen get_sql_int16 (i: INTEGER): SYSTEM_DATA_SQLTYPES_SQLINT16 is
		external
			"IL signature (System.Int32): System.Data.SqlTypes.SqlInt16 use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlInt16"
		end

	frozen get_float (i: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use System.Data.SqlClient.SqlDataReader"
		alias
			"GetFloat"
		end

	frozen get_chars (i: INTEGER; data_index: INTEGER_64; buffer: ARRAY [CHARACTER]; buffer_index: INTEGER; length: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int32, System.Int64, System.Char[], System.Int32, System.Int32): System.Int64 use System.Data.SqlClient.SqlDataReader"
		alias
			"GetChars"
		end

	frozen get_string (i: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Data.SqlClient.SqlDataReader"
		alias
			"GetString"
		end

	frozen get_sql_money (i: INTEGER): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL signature (System.Int32): System.Data.SqlTypes.SqlMoney use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlMoney"
		end

	frozen get_data_type_name (i: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Data.SqlClient.SqlDataReader"
		alias
			"GetDataTypeName"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Data.SqlClient.SqlDataReader"
		alias
			"Close"
		end

	frozen get_sql_byte (i: INTEGER): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL signature (System.Int32): System.Data.SqlTypes.SqlByte use System.Data.SqlClient.SqlDataReader"
		alias
			"GetSqlByte"
		end

feature {NONE} -- Implementation

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Data.SqlClient.SqlDataReader"
		alias
			"System.IDisposable.Dispose"
		end

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.SqlClient.SqlDataReader"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLDATAREADER
