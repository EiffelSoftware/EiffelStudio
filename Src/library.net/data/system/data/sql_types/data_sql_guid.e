indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlTypes.SqlGuid"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DATA_SQL_GUID

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end
	DATA_INULLABLE
	ICOMPARABLE

feature -- Initialization

	frozen make_data_sql_guid_3 (a: INTEGER; b: INTEGER_16; c: INTEGER_16; d: INTEGER_8; e: INTEGER_8; f: INTEGER_8; g: INTEGER_8; h: INTEGER_8; i: INTEGER_8; j: INTEGER_8; k: INTEGER_8) is
		external
			"IL creator signature (System.Int32, System.Int16, System.Int16, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte) use System.Data.SqlTypes.SqlGuid"
		end

	frozen make_data_sql_guid_2 (g: GUID) is
		external
			"IL creator signature (System.Guid) use System.Data.SqlTypes.SqlGuid"
		end

	frozen make_data_sql_guid (value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Data.SqlTypes.SqlGuid"
		end

	frozen make_data_sql_guid_1 (s: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.SqlTypes.SqlGuid"
		end

feature -- Access

	frozen null: DATA_SQL_GUID is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlGuid use System.Data.SqlTypes.SqlGuid"
		alias
			"Null"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlGuid"
		alias
			"get_IsNull"
		end

	frozen get_value: GUID is
		external
			"IL signature (): System.Guid use System.Data.SqlTypes.SqlGuid"
		alias
			"get_Value"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlGuid"
		alias
			"ToString"
		end

	frozen greater_than (x: DATA_SQL_GUID; y: DATA_SQL_GUID): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid, System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"GreaterThan"
		end

	frozen to_byte_array: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Data.SqlTypes.SqlGuid"
		alias
			"ToByteArray"
		end

	frozen equals_sql_guid (x: DATA_SQL_GUID; y: DATA_SQL_GUID): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid, System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"Equals"
		end

	frozen less_than (x: DATA_SQL_GUID; y: DATA_SQL_GUID): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid, System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"LessThan"
		end

	frozen not_equals (x: DATA_SQL_GUID; y: DATA_SQL_GUID): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid, System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"NotEquals"
		end

	frozen to_sql_string: DATA_SQL_STRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlGuid"
		alias
			"ToSqlString"
		end

	frozen greater_than_or_equal (x: DATA_SQL_GUID; y: DATA_SQL_GUID): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid, System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"GreaterThanOrEqual"
		end

	frozen to_sql_binary: DATA_SQL_BINARY is
		external
			"IL signature (): System.Data.SqlTypes.SqlBinary use System.Data.SqlTypes.SqlGuid"
		alias
			"ToSqlBinary"
		end

	frozen parse (s: SYSTEM_STRING): DATA_SQL_GUID is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlGuid use System.Data.SqlTypes.SqlGuid"
		alias
			"Parse"
		end

	frozen less_than_or_equal (x: DATA_SQL_GUID; y: DATA_SQL_GUID): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid, System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"LessThanOrEqual"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlGuid"
		alias
			"Equals"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlGuid"
		alias
			"CompareTo"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlGuid"
		alias
			"GetHashCode"
		end

feature -- Binary Operators

	frozen infix ">=" (y: DATA_SQL_GUID): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: DATA_SQL_GUID): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"op_Equality"
		end

	frozen infix "|=" (y: DATA_SQL_GUID): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"op_Inequality"
		end

	frozen infix "<" (y: DATA_SQL_GUID): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"op_LessThan"
		end

	frozen infix "<=" (y: DATA_SQL_GUID): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix ">" (y: DATA_SQL_GUID): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"op_GreaterThan"
		end

feature -- Specials

	frozen op_implicit (x: GUID): DATA_SQL_GUID is
		external
			"IL static signature (System.Guid): System.Data.SqlTypes.SqlGuid use System.Data.SqlTypes.SqlGuid"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_guid (x: DATA_SQL_GUID): GUID is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid): System.Guid use System.Data.SqlTypes.SqlGuid"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_string (x: DATA_SQL_STRING): DATA_SQL_GUID is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlGuid use System.Data.SqlTypes.SqlGuid"
		alias
			"op_Explicit"
		end

	frozen op_explicit (x: DATA_SQL_BINARY): DATA_SQL_GUID is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlGuid use System.Data.SqlTypes.SqlGuid"
		alias
			"op_Explicit"
		end

end -- class DATA_SQL_GUID
