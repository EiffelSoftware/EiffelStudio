indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlTypes.SqlSingle"

frozen expanded external class
	SYSTEM_DATA_SQLTYPES_SQLSINGLE

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

	frozen make_sqlsingle (value: REAL) is
		external
			"IL creator signature (System.Single) use System.Data.SqlTypes.SqlSingle"
		end

	frozen make_sqlsingle_1 (value: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.Data.SqlTypes.SqlSingle"
		end

feature -- Access

	frozen min_value: SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"MinValue"
		end

	frozen zero: SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"Zero"
		end

	frozen null: SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"Null"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlSingle"
		alias
			"get_IsNull"
		end

	frozen get_value: REAL is
		external
			"IL signature (): System.Single use System.Data.SqlTypes.SqlSingle"
		alias
			"get_Value"
		end

	frozen max_value: SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"MaxValue"
		end

feature -- Basic Operations

	equals_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlSingle"
		alias
			"Equals"
		end

	frozen less_than (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE; y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"LessThan"
		end

	frozen greater_than (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE; y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"GreaterThan"
		end

	frozen to_sql_decimal: SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL signature (): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlDecimal"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlSingle"
		alias
			"GetHashCode"
		end

	frozen to_sql_double: SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlDouble"
		end

	frozen less_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE; y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"LessThanOrEqual"
		end

	frozen to_sql_int64: SYSTEM_DATA_SQLTYPES_SQLINT64 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt64 use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlInt64"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlSingle"
		alias
			"CompareTo"
		end

	frozen greater_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE; y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"GreaterThanOrEqual"
		end

	frozen to_sql_int32: SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlInt32"
		end

	frozen add (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE; y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"Add"
		end

	frozen to_sql_money: SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL signature (): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlMoney"
		end

	frozen equals_sql_single (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE; y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"Equals"
		end

	frozen to_sql_int16: SYSTEM_DATA_SQLTYPES_SQLINT16 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt16 use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlInt16"
		end

	frozen divide (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE; y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"Divide"
		end

	frozen to_sql_byte: SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL signature (): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlByte"
		end

	frozen multiply (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE; y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"Multiply"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlSingle"
		alias
			"ToString"
		end

	frozen not_equals (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE; y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"NotEquals"
		end

	frozen parse (s: STRING): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"Parse"
		end

	frozen subtract (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE; y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"Subtract"
		end

	frozen to_sql_string: SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlString"
		end

	frozen to_sql_boolean: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL signature (): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlBoolean"
		end

feature -- Unary Operators

	frozen prefix "-": SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_UnaryNegation"
		end

feature -- Binary Operators

	frozen infix "|=" (y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Equality"
		end

	frozen infix "-" (y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Subtraction"
		end

	frozen infix "<=" (y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "/" (y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Division"
		end

	frozen infix "+" (y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Addition"
		end

	frozen infix ">" (y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"op_GreaterThan"
		end

	frozen infix "<" (y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"op_LessThan"
		end

	frozen infix "*" (y: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Multiply"
		end

feature -- Specials

	frozen op_implicit_sql_int32 (x: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Implicit"
		end

	frozen op_implicit (x: SYSTEM_DATA_SQLTYPES_SQLINT64): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt64): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Implicit"
		end

	frozen op_implicit_single (x: REAL): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.Single): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_string (x: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Explicit"
		end

	frozen op_implicit_sql_byte (x: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_int16 (x: SYSTEM_DATA_SQLTYPES_SQLINT16): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt16): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_money (x: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Implicit"
		end

	frozen op_explicit (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_boolean (x: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_single (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE): REAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle): System.Single use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Explicit"
		end

	frozen op_implicit_sql_decimal (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Implicit"
		end

end -- class SYSTEM_DATA_SQLTYPES_SQLSINGLE
