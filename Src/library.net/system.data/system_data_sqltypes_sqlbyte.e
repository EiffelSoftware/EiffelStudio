indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlTypes.SqlByte"

frozen expanded external class
	SYSTEM_DATA_SQLTYPES_SQLBYTE

inherit
	VALUE_TYPE
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object,
			to_string
		end
	SYSTEM_DATA_SQLTYPES_INULLABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end



feature -- Initialization

	frozen make_sqlbyte (value: INTEGER_8) is
		external
			"IL creator signature (System.Byte) use System.Data.SqlTypes.SqlByte"
		end

feature -- Access

	frozen min_value: SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"MinValue"
		end

	frozen zero: SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"Zero"
		end

	frozen null: SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"Null"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlByte"
		alias
			"get_IsNull"
		end

	frozen get_value: INTEGER_8 is
		external
			"IL signature (): System.Byte use System.Data.SqlTypes.SqlByte"
		alias
			"get_Value"
		end

	frozen max_value: SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"MaxValue"
		end

feature -- Basic Operations

	equals_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlByte"
		alias
			"Equals"
		end

	frozen mod (x: SYSTEM_DATA_SQLTYPES_SQLBYTE; y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte, System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"Mod"
		end

	frozen less_than (x: SYSTEM_DATA_SQLTYPES_SQLBYTE; y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte, System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlByte"
		alias
			"LessThan"
		end

	frozen to_sql_boolean: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL signature (): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlByte"
		alias
			"ToSqlBoolean"
		end

	frozen greater_than (x: SYSTEM_DATA_SQLTYPES_SQLBYTE; y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte, System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlByte"
		alias
			"GreaterThan"
		end

	frozen to_sql_decimal: SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL signature (): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlByte"
		alias
			"ToSqlDecimal"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlByte"
		alias
			"GetHashCode"
		end

	frozen to_sql_double: SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlByte"
		alias
			"ToSqlDouble"
		end

	frozen less_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLBYTE; y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte, System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlByte"
		alias
			"LessThanOrEqual"
		end

	frozen to_sql_int64: SYSTEM_DATA_SQLTYPES_SQLINT64 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt64 use System.Data.SqlTypes.SqlByte"
		alias
			"ToSqlInt64"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlByte"
		alias
			"CompareTo"
		end

	frozen greater_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLBYTE; y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte, System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlByte"
		alias
			"GreaterThanOrEqual"
		end

	frozen subtract (x: SYSTEM_DATA_SQLTYPES_SQLBYTE; y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte, System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"Subtract"
		end

	frozen to_sql_int32: SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlByte"
		alias
			"ToSqlInt32"
		end

	frozen bitwise_and (x: SYSTEM_DATA_SQLTYPES_SQLBYTE; y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte, System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"BitwiseAnd"
		end

	frozen add (x: SYSTEM_DATA_SQLTYPES_SQLBYTE; y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte, System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"Add"
		end

	frozen to_sql_money: SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL signature (): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlByte"
		alias
			"ToSqlMoney"
		end

	frozen to_sql_single: SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlByte"
		alias
			"ToSqlSingle"
		end

	frozen bitwise_or (x: SYSTEM_DATA_SQLTYPES_SQLBYTE; y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte, System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"BitwiseOr"
		end

	frozen to_sql_int16: SYSTEM_DATA_SQLTYPES_SQLINT16 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt16 use System.Data.SqlTypes.SqlByte"
		alias
			"ToSqlInt16"
		end

	frozen Xor_ (x: SYSTEM_DATA_SQLTYPES_SQLBYTE; y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte, System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"Xor"
		end

	frozen divide (x: SYSTEM_DATA_SQLTYPES_SQLBYTE; y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte, System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"Divide"
		end

	frozen multiply (x: SYSTEM_DATA_SQLTYPES_SQLBYTE; y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte, System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"Multiply"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlByte"
		alias
			"ToString"
		end

	frozen not_equals (x: SYSTEM_DATA_SQLTYPES_SQLBYTE; y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte, System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlByte"
		alias
			"NotEquals"
		end

	frozen parse (s: STRING): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"Parse"
		end

	frozen ones_complement (x: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"OnesComplement"
		end

	frozen to_sql_string: SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlByte"
		alias
			"ToSqlString"
		end

	frozen equals_sql_byte (x: SYSTEM_DATA_SQLTYPES_SQLBYTE; y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte, System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlByte"
		alias
			"Equals"
		end

feature -- Unary Operators

	frozen prefix "#~": SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_OnesComplement"
		end

feature -- Binary Operators

	frozen infix "|" (y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_BitwiseOr"
		end

	frozen infix "|=" (y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlByte"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlByte"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "/" (y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Division"
		end

	frozen infix "#==" (y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlByte"
		alias
			"op_Equality"
		end

	frozen infix "-" (y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Subtraction"
		end

	frozen infix "<=" (y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlByte"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "\\" (y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Modulus"
		end

	frozen infix "&" (y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_BitwiseAnd"
		end

	frozen infix "+" (y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Addition"
		end

	frozen infix ">" (y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlByte"
		alias
			"op_GreaterThan"
		end

	frozen infix "<" (y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlByte"
		alias
			"op_LessThan"
		end

	frozen infix "xor" (y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_ExclusiveOr"
		end

	frozen infix "*" (y: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Multiply"
		end

feature -- Specials

	frozen op_implicit (x: INTEGER_8): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Byte): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_decimal (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int64 (x: SYSTEM_DATA_SQLTYPES_SQLINT64): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt64): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_double (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int16 (x: SYSTEM_DATA_SQLTYPES_SQLINT16): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt16): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_string (x: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_byte (x: SYSTEM_DATA_SQLTYPES_SQLBYTE): INTEGER_8 is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte): System.Byte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Explicit"
		end

	frozen op_explicit (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_boolean (x: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_money (x: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int32 (x: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlByte"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_DATA_SQLTYPES_SQLBYTE
