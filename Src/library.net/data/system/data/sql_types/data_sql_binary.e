indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlTypes.SqlBinary"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DATA_SQL_BINARY

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

	frozen make_data_sql_binary (value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Data.SqlTypes.SqlBinary"
		end

feature -- Access

	frozen get_item (index: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use System.Data.SqlTypes.SqlBinary"
		alias
			"get_Item"
		end

	frozen null: DATA_SQL_BINARY is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlBinary use System.Data.SqlTypes.SqlBinary"
		alias
			"Null"
		end

	frozen get_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlBinary"
		alias
			"get_Length"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlBinary"
		alias
			"get_IsNull"
		end

	frozen get_value: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Data.SqlTypes.SqlBinary"
		alias
			"get_Value"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlBinary"
		alias
			"ToString"
		end

	frozen greater_than (x: DATA_SQL_BINARY; y: DATA_SQL_BINARY): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary, System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"GreaterThan"
		end

	frozen concat (x: DATA_SQL_BINARY; y: DATA_SQL_BINARY): DATA_SQL_BINARY is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary, System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBinary use System.Data.SqlTypes.SqlBinary"
		alias
			"Concat"
		end

	frozen less_than (x: DATA_SQL_BINARY; y: DATA_SQL_BINARY): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary, System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"LessThan"
		end

	frozen not_equals (x: DATA_SQL_BINARY; y: DATA_SQL_BINARY): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary, System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"NotEquals"
		end

	frozen greater_than_or_equal (x: DATA_SQL_BINARY; y: DATA_SQL_BINARY): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary, System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"GreaterThanOrEqual"
		end

	frozen less_than_or_equal (x: DATA_SQL_BINARY; y: DATA_SQL_BINARY): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary, System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"LessThanOrEqual"
		end

	frozen equals_sql_binary (x: DATA_SQL_BINARY; y: DATA_SQL_BINARY): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary, System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"Equals"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlBinary"
		alias
			"Equals"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlBinary"
		alias
			"CompareTo"
		end

	frozen to_sql_guid: DATA_SQL_GUID is
		external
			"IL signature (): System.Data.SqlTypes.SqlGuid use System.Data.SqlTypes.SqlBinary"
		alias
			"ToSqlGuid"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlBinary"
		alias
			"GetHashCode"
		end

feature -- Binary Operators

	frozen infix ">=" (y: DATA_SQL_BINARY): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: DATA_SQL_BINARY): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"op_Equality"
		end

	frozen infix "|=" (y: DATA_SQL_BINARY): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"op_Inequality"
		end

	frozen infix "+" (y: DATA_SQL_BINARY): DATA_SQL_BINARY is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBinary use System.Data.SqlTypes.SqlBinary"
		alias
			"op_Addition"
		end

	frozen infix "<" (y: DATA_SQL_BINARY): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"op_LessThan"
		end

	frozen infix "<=" (y: DATA_SQL_BINARY): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix ">" (y: DATA_SQL_BINARY): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"op_GreaterThan"
		end

feature -- Specials

	frozen op_explicit_sql_binary (x: DATA_SQL_BINARY): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary): System.Byte[] use System.Data.SqlTypes.SqlBinary"
		alias
			"op_Explicit"
		end

	frozen op_implicit (x: NATIVE_ARRAY [INTEGER_8]): DATA_SQL_BINARY is
		external
			"IL static signature (System.Byte[]): System.Data.SqlTypes.SqlBinary use System.Data.SqlTypes.SqlBinary"
		alias
			"op_Implicit"
		end

	frozen op_explicit (x: DATA_SQL_GUID): DATA_SQL_BINARY is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBinary use System.Data.SqlTypes.SqlBinary"
		alias
			"op_Explicit"
		end

end -- class DATA_SQL_BINARY
