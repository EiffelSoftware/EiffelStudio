indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlTypes.SqlInt32"

frozen expanded external class
	SYSTEM_DATA_SQLTYPES_SQLINT32

inherit
	VALUE_TYPE
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

	frozen make_sqlint32 (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Data.SqlTypes.SqlInt32"
		end

feature -- Access

	frozen min_value: SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"MinValue"
		end

	frozen zero: SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"Zero"
		end

	frozen null: SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"Null"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlInt32"
		alias
			"get_IsNull"
		end

	frozen get_value: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlInt32"
		alias
			"get_Value"
		end

	frozen max_value: SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"MaxValue"
		end

feature -- Basic Operations

	equals_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlInt32"
		alias
			"Equals"
		end

	frozen mod (x: SYSTEM_DATA_SQLTYPES_SQLINT32; y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32, System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"Mod"
		end

	frozen less_than (x: SYSTEM_DATA_SQLTYPES_SQLINT32; y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32, System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlInt32"
		alias
			"LessThan"
		end

	frozen greater_than (x: SYSTEM_DATA_SQLTYPES_SQLINT32; y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32, System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlInt32"
		alias
			"GreaterThan"
		end

	frozen to_sql_decimal: SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL signature (): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlInt32"
		alias
			"ToSqlDecimal"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlInt32"
		alias
			"GetHashCode"
		end

	frozen to_sql_double: SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlInt32"
		alias
			"ToSqlDouble"
		end

	frozen less_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLINT32; y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32, System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlInt32"
		alias
			"LessThanOrEqual"
		end

	frozen to_sql_int64: SYSTEM_DATA_SQLTYPES_SQLINT64 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt64 use System.Data.SqlTypes.SqlInt32"
		alias
			"ToSqlInt64"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlInt32"
		alias
			"CompareTo"
		end

	frozen greater_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLINT32; y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32, System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlInt32"
		alias
			"GreaterThanOrEqual"
		end

	frozen subtract (x: SYSTEM_DATA_SQLTYPES_SQLINT32; y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32, System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"Subtract"
		end

	frozen bitwise_and (x: SYSTEM_DATA_SQLTYPES_SQLINT32; y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32, System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"BitwiseAnd"
		end

	frozen add (x: SYSTEM_DATA_SQLTYPES_SQLINT32; y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32, System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"Add"
		end

	frozen to_sql_money: SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL signature (): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlInt32"
		alias
			"ToSqlMoney"
		end

	frozen to_sql_single: SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlInt32"
		alias
			"ToSqlSingle"
		end

	frozen bitwise_or (x: SYSTEM_DATA_SQLTYPES_SQLINT32; y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32, System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"BitwiseOr"
		end

	frozen to_sql_int16: SYSTEM_DATA_SQLTYPES_SQLINT16 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt16 use System.Data.SqlTypes.SqlInt32"
		alias
			"ToSqlInt16"
		end

	frozen Xor_ (x: SYSTEM_DATA_SQLTYPES_SQLINT32; y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32, System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"Xor"
		end

	frozen equals_sql_int32 (x: SYSTEM_DATA_SQLTYPES_SQLINT32; y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32, System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlInt32"
		alias
			"Equals"
		end

	frozen divide (x: SYSTEM_DATA_SQLTYPES_SQLINT32; y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32, System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"Divide"
		end

	frozen to_sql_byte: SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL signature (): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlInt32"
		alias
			"ToSqlByte"
		end

	frozen multiply (x: SYSTEM_DATA_SQLTYPES_SQLINT32; y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32, System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"Multiply"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlInt32"
		alias
			"ToString"
		end

	frozen not_equals (x: SYSTEM_DATA_SQLTYPES_SQLINT32; y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32, System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlInt32"
		alias
			"NotEquals"
		end

	frozen parse (s: STRING): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"Parse"
		end

	frozen ones_complement (x: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"OnesComplement"
		end

	frozen to_sql_string: SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlInt32"
		alias
			"ToSqlString"
		end

	frozen to_sql_boolean: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL signature (): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlInt32"
		alias
			"ToSqlBoolean"
		end

feature -- Unary Operators

	frozen prefix "#~": SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_OnesComplement"
		end

	frozen prefix "-": SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_UnaryNegation"
		end

feature -- Binary Operators

	frozen infix "|" (y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_BitwiseOr"
		end

	frozen infix "|=" (y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlInt32"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "/" (y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Division"
		end

	frozen infix "#==" (y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Equality"
		end

	frozen infix "-" (y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Subtraction"
		end

	frozen infix "<=" (y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlInt32"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "\\" (y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Modulus"
		end

	frozen infix "&" (y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_BitwiseAnd"
		end

	frozen infix "+" (y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Addition"
		end

	frozen infix ">" (y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlInt32"
		alias
			"op_GreaterThan"
		end

	frozen infix "<" (y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlInt32"
		alias
			"op_LessThan"
		end

	frozen infix "xor" (y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_ExclusiveOr"
		end

	frozen infix "*" (y: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Multiply"
		end

feature -- Specials

	frozen op_implicit (x: SYSTEM_DATA_SQLTYPES_SQLINT16): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt16): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_decimal (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int64 (x: SYSTEM_DATA_SQLTYPES_SQLINT64): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt64): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_double (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Explicit"
		end

	frozen op_implicit_int32 (x: INTEGER): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Int32): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_byte (x: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_string (x: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Explicit"
		end

	frozen op_explicit (x: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_boolean (x: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_single (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int32 (x: SYSTEM_DATA_SQLTYPES_SQLINT32): INTEGER is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32): System.Int32 use System.Data.SqlTypes.SqlInt32"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_DATA_SQLTYPES_SQLINT32
