indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlTypes.SqlMoney"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DATA_SQL_MONEY

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

	frozen make_data_sql_money_3 (value: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.Data.SqlTypes.SqlMoney"
		end

	frozen make_data_sql_money (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Data.SqlTypes.SqlMoney"
		end

	frozen make_data_sql_money_1 (value: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.Data.SqlTypes.SqlMoney"
		end

	frozen make_data_sql_money_2 (value: DECIMAL) is
		external
			"IL creator signature (System.Decimal) use System.Data.SqlTypes.SqlMoney"
		end

feature -- Access

	frozen min_value: DATA_SQL_MONEY is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"MinValue"
		end

	frozen zero: DATA_SQL_MONEY is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"Zero"
		end

	frozen null: DATA_SQL_MONEY is
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

	frozen get_value: DECIMAL is
		external
			"IL signature (): System.Decimal use System.Data.SqlTypes.SqlMoney"
		alias
			"get_Value"
		end

	frozen max_value: DATA_SQL_MONEY is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"MaxValue"
		end

feature -- Basic Operations

	frozen add (x: DATA_SQL_MONEY; y: DATA_SQL_MONEY): DATA_SQL_MONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"Add"
		end

	frozen less_than (x: DATA_SQL_MONEY; y: DATA_SQL_MONEY): DATA_SQL_BOOLEAN is
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

	frozen greater_than (x: DATA_SQL_MONEY; y: DATA_SQL_MONEY): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"GreaterThan"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlMoney"
		alias
			"Equals"
		end

	frozen to_sql_decimal: DATA_SQL_DECIMAL is
		external
			"IL signature (): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlDecimal"
		end

	frozen equals_sql_money (x: DATA_SQL_MONEY; y: DATA_SQL_MONEY): DATA_SQL_BOOLEAN is
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

	frozen to_sql_double: DATA_SQL_DOUBLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlDouble"
		end

	frozen less_than_or_equal (x: DATA_SQL_MONEY; y: DATA_SQL_MONEY): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"LessThanOrEqual"
		end

	frozen to_sql_int64: DATA_SQL_INT64 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt64 use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlInt64"
		end

	frozen to_sql_string: DATA_SQL_STRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlString"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlMoney"
		alias
			"CompareTo"
		end

	frozen greater_than_or_equal (x: DATA_SQL_MONEY; y: DATA_SQL_MONEY): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"GreaterThanOrEqual"
		end

	frozen to_sql_int32: DATA_SQL_INT32 is
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

	frozen to_sql_single: DATA_SQL_SINGLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlSingle"
		end

	frozen to_decimal: DECIMAL is
		external
			"IL signature (): System.Decimal use System.Data.SqlTypes.SqlMoney"
		alias
			"ToDecimal"
		end

	frozen to_sql_int16: DATA_SQL_INT16 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt16 use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlInt16"
		end

	frozen divide (x: DATA_SQL_MONEY; y: DATA_SQL_MONEY): DATA_SQL_MONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"Divide"
		end

	frozen to_sql_byte: DATA_SQL_BYTE is
		external
			"IL signature (): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlByte"
		end

	frozen multiply (x: DATA_SQL_MONEY; y: DATA_SQL_MONEY): DATA_SQL_MONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"Multiply"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlMoney"
		alias
			"ToString"
		end

	frozen not_equals (x: DATA_SQL_MONEY; y: DATA_SQL_MONEY): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney, System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"NotEquals"
		end

	frozen parse (s: SYSTEM_STRING): DATA_SQL_MONEY is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"Parse"
		end

	frozen subtract (x: DATA_SQL_MONEY; y: DATA_SQL_MONEY): DATA_SQL_MONEY is
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

	frozen to_sql_boolean: DATA_SQL_BOOLEAN is
		external
			"IL signature (): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"ToSqlBoolean"
		end

feature -- Unary Operators

	frozen prefix "-": DATA_SQL_MONEY is
		external
			"IL operator signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_UnaryNegation"
		end

feature -- Binary Operators

	frozen infix "|=" (y: DATA_SQL_MONEY): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (y: DATA_SQL_MONEY): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: DATA_SQL_MONEY): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Equality"
		end

	frozen infix "-" (y: DATA_SQL_MONEY): DATA_SQL_MONEY is
		external
			"IL operator signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Subtraction"
		end

	frozen infix "<=" (y: DATA_SQL_MONEY): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "/" (y: DATA_SQL_MONEY): DATA_SQL_MONEY is
		external
			"IL operator signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Division"
		end

	frozen infix "+" (y: DATA_SQL_MONEY): DATA_SQL_MONEY is
		external
			"IL operator signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Addition"
		end

	frozen infix ">" (y: DATA_SQL_MONEY): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"op_GreaterThan"
		end

	frozen infix "<" (y: DATA_SQL_MONEY): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlMoney"
		alias
			"op_LessThan"
		end

	frozen infix "*" (y: DATA_SQL_MONEY): DATA_SQL_MONEY is
		external
			"IL operator signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Multiply"
		end

feature -- Specials

	frozen op_implicit (x: DATA_SQL_INT32): DATA_SQL_MONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_decimal (x: DATA_SQL_DECIMAL): DATA_SQL_MONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_string (x: DATA_SQL_STRING): DATA_SQL_MONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Explicit"
		end

	frozen op_implicit_sql_byte (x: DATA_SQL_BYTE): DATA_SQL_MONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_int64 (x: DATA_SQL_INT64): DATA_SQL_MONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt64): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_int16 (x: DATA_SQL_INT16): DATA_SQL_MONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt16): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Implicit"
		end

	frozen op_implicit_decimal (x: DECIMAL): DATA_SQL_MONEY is
		external
			"IL static signature (System.Decimal): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Implicit"
		end

	frozen op_explicit (x: DATA_SQL_DOUBLE): DATA_SQL_MONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_boolean (x: DATA_SQL_BOOLEAN): DATA_SQL_MONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_single (x: DATA_SQL_SINGLE): DATA_SQL_MONEY is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_money (x: DATA_SQL_MONEY): DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney): System.Decimal use System.Data.SqlTypes.SqlMoney"
		alias
			"op_Explicit"
		end

end -- class DATA_SQL_MONEY
