indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlTypes.SqlMoney"

frozen expanded external class
	SYSTEM_DATA_SQLTYPES_SQLMONEY

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

	frozen make_sqlmoney_2 (value: SYSTEM_DECIMAL) is
		external
			"IL creator signature (System.Decimal) use System.Data.SqlTypes.SqlMoney"
		end

	frozen make_sqlmoney_3 (value: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.Data.SqlTypes.SqlMoney"
		end

	frozen make_sqlmoney (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Data.SqlTypes.SqlMoney"
		end

	frozen make_sqlmoney_1 (value: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.Data.SqlTypes.SqlMoney"
		end

feature -- Access

	frozen min_value: SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"MinValue"
		end

	frozen zero: SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"Zero"
		end

	frozen null: SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"Null"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlMoney"
		alias
			"get_IsNull"
		end

	frozen get_value: SYSTEM_DECIMAL is
		external
			"IL signature (): System.Decimal use System.Data.SqlTypes.SqlMoney"
		alias
			"get_Value"
		end

	frozen max_value: SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"MaxValue"
		end

feature -- Basic Operations

	frozen add (x: SYSTEM_DATA_SQLTYPES_SQLMONEY; y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"Add"
		end

	frozen greater_than (x: SYSTEM_DATA_SQLTYPES_SQLMONEY; y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"GreaterThan"
		end

	frozen less_than (x: SYSTEM_DATA_SQLTYPES_SQLMONEY; y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"LessThan"
		end

	frozen to_double: DOUBLE is
		external
			"IL signature (): System.Double use System.Data.SqlTypes.SqlMoney"
		alias
			"ToDouble"
		end

	equals_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlMoney"
		alias
			"Equals"
		end

	frozen to_sql_decimal: SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL signature (): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlDecimal"
		end

	frozen equals_sql_money (x: SYSTEM_DATA_SQLTYPES_SQLMONEY; y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlMoney"
		alias
			"GetHashCode"
		end

	frozen to_sql_double: SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlDouble"
		end

	frozen less_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLMONEY; y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"LessThanOrEqual"
		end

	frozen to_sql_int64: SYSTEM_DATA_SQLTYPES_SQLINT64 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt64 use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlInt64"
		end

	frozen to_sql_string: SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlString"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlMoney"
		alias
			"CompareTo"
		end

	frozen greater_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLMONEY; y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"GreaterThanOrEqual"
		end

	frozen to_sql_int32: SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlInt32"
		end

	frozen to_int32: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlMoney"
		alias
			"ToInt32"
		end

	frozen to_sql_single: SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlSingle"
		end

	frozen to_decimal: SYSTEM_DECIMAL is
		external
			"IL signature (): System.Decimal use System.Data.SqlTypes.SqlMoney"
		alias
			"ToDecimal"
		end

	frozen to_sql_int16: SYSTEM_DATA_SQLTYPES_SQLINT16 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt16 use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlInt16"
		end

	frozen divide (x: SYSTEM_DATA_SQLTYPES_SQLMONEY; y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"Divide"
		end

	frozen to_sql_byte: SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL signature (): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlByte"
		end

	frozen multiply (x: SYSTEM_DATA_SQLTYPES_SQLMONEY; y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"Multiply"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlMoney"
		alias
			"ToString"
		end

	frozen not_equals (x: SYSTEM_DATA_SQLTYPES_SQLMONEY; y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"NotEquals"
		end

	frozen parse (s: STRING): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"Parse"
		end

	frozen subtract (x: SYSTEM_DATA_SQLTYPES_SQLMONEY; y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"Subtract"
		end

	frozen to_int64: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Data.SqlTypes.SqlMoney"
		alias
			"ToInt64"
		end

	frozen to_sql_boolean: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL signature (): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlBoolean"
		end

feature -- Unary Operators

	frozen prefix "-": SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_UnaryNegation"
		end

feature -- Binary Operators

	frozen infix "|=" (y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Equality"
		end

	frozen infix "-" (y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Subtraction"
		end

	frozen infix "<=" (y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "/" (y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Division"
		end

	frozen infix "+" (y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Addition"
		end

	frozen infix ">" (y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"op_GreaterThan"
		end

	frozen infix "<" (y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"op_LessThan"
		end

	frozen infix "*" (y: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Multiply"
		end

feature -- Specials

	frozen op_implicit (x: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_decimal (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_string (x: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Explicit"
		end

	frozen op_implicit_sql_byte (x: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_int64 (x: SYSTEM_DATA_SQLTYPES_SQLINT64): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt64): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_int16 (x: SYSTEM_DATA_SQLTYPES_SQLINT16): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt16): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Implicit"
		end

	frozen op_implicit_decimal (x: SYSTEM_DECIMAL): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.Decimal): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Implicit"
		end

	frozen op_explicit (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_boolean (x: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_single (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_money (x: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney): System.Decimal use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_DATA_SQLTYPES_SQLMONEY
