indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlTypes.SqlDouble"

frozen expanded external class
	SYSTEM_DATA_SQLTYPES_SQLDOUBLE

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

	frozen make_sqldouble (value: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.Data.SqlTypes.SqlDouble"
		end

feature -- Access

	frozen min_value: SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"MinValue"
		end

	frozen zero: SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"Zero"
		end

	frozen null: SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"Null"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlDouble"
		alias
			"get_IsNull"
		end

	frozen get_value: DOUBLE is
		external
			"IL signature (): System.Double use System.Data.SqlTypes.SqlDouble"
		alias
			"get_Value"
		end

	frozen max_value: SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"MaxValue"
		end

feature -- Basic Operations

	equals_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlDouble"
		alias
			"Equals"
		end

	frozen less_than (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE; y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble, System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDouble"
		alias
			"LessThan"
		end

	frozen greater_than (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE; y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble, System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDouble"
		alias
			"GreaterThan"
		end

	frozen to_sql_decimal: SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL signature (): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDouble"
		alias
			"ToSqlDecimal"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlDouble"
		alias
			"GetHashCode"
		end

	frozen less_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE; y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble, System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDouble"
		alias
			"LessThanOrEqual"
		end

	frozen to_sql_int64: SYSTEM_DATA_SQLTYPES_SQLINT64 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt64 use System.Data.SqlTypes.SqlDouble"
		alias
			"ToSqlInt64"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlDouble"
		alias
			"CompareTo"
		end

	frozen greater_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE; y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble, System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDouble"
		alias
			"GreaterThanOrEqual"
		end

	frozen to_sql_int32: SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlDouble"
		alias
			"ToSqlInt32"
		end

	frozen add (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE; y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble, System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"Add"
		end

	frozen to_sql_money: SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL signature (): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlDouble"
		alias
			"ToSqlMoney"
		end

	frozen to_sql_single: SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlDouble"
		alias
			"ToSqlSingle"
		end

	frozen equals_sql_double (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE; y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble, System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDouble"
		alias
			"Equals"
		end

	frozen to_sql_int16: SYSTEM_DATA_SQLTYPES_SQLINT16 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt16 use System.Data.SqlTypes.SqlDouble"
		alias
			"ToSqlInt16"
		end

	frozen divide (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE; y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble, System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"Divide"
		end

	frozen to_sql_byte: SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL signature (): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlDouble"
		alias
			"ToSqlByte"
		end

	frozen multiply (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE; y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble, System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"Multiply"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlDouble"
		alias
			"ToString"
		end

	frozen not_equals (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE; y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble, System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDouble"
		alias
			"NotEquals"
		end

	frozen parse (s: STRING): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"Parse"
		end

	frozen subtract (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE; y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble, System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"Subtract"
		end

	frozen to_sql_string: SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlDouble"
		alias
			"ToSqlString"
		end

	frozen to_sql_boolean: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL signature (): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDouble"
		alias
			"ToSqlBoolean"
		end

feature -- Unary Operators

	frozen prefix "-": SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_UnaryNegation"
		end

feature -- Binary Operators

	frozen infix "|=" (y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDouble"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Equality"
		end

	frozen infix "-" (y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Subtraction"
		end

	frozen infix "<=" (y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDouble"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "/" (y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Division"
		end

	frozen infix "+" (y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Addition"
		end

	frozen infix ">" (y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDouble"
		alias
			"op_GreaterThan"
		end

	frozen infix "<" (y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDouble"
		alias
			"op_LessThan"
		end

	frozen infix "*" (y: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Multiply"
		end

feature -- Specials

	frozen op_implicit_sql_int32 (x: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Implicit"
		end

	frozen op_implicit (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_decimal (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_byte (x: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_money (x: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_int64 (x: SYSTEM_DATA_SQLTYPES_SQLINT64): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt64): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_int16 (x: SYSTEM_DATA_SQLTYPES_SQLINT16): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt16): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Implicit"
		end

	frozen op_implicit_double (x: DOUBLE): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.Double): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Implicit"
		end

	frozen op_explicit (x: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_boolean (x: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_double (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): DOUBLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble): System.Double use System.Data.SqlTypes.SqlDouble"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_DATA_SQLTYPES_SQLDOUBLE
