indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlTypes.SqlDecimal"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DATA_SQL_DECIMAL

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

	frozen make_data_sql_decimal (value: DECIMAL) is
		external
			"IL creator signature (System.Decimal) use System.Data.SqlTypes.SqlDecimal"
		end

	frozen make_data_sql_decimal_2 (value: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.Data.SqlTypes.SqlDecimal"
		end

	frozen make_data_sql_decimal_3 (b_precision: INTEGER_8; b_scale: INTEGER_8; f_positive: BOOLEAN; bits: NATIVE_ARRAY [INTEGER]) is
		external
			"IL creator signature (System.Byte, System.Byte, System.Boolean, System.Int32[]) use System.Data.SqlTypes.SqlDecimal"
		end

	frozen make_data_sql_decimal_5 (d_val: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.Data.SqlTypes.SqlDecimal"
		end

	frozen make_data_sql_decimal_4 (b_precision: INTEGER_8; b_scale: INTEGER_8; f_positive: BOOLEAN; data1: INTEGER; data2: INTEGER; data3: INTEGER; data4: INTEGER) is
		external
			"IL creator signature (System.Byte, System.Byte, System.Boolean, System.Int32, System.Int32, System.Int32, System.Int32) use System.Data.SqlTypes.SqlDecimal"
		end

	frozen make_data_sql_decimal_1 (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Data.SqlTypes.SqlDecimal"
		end

feature -- Access

	frozen get_is_positive: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"get_IsPositive"
		end

	frozen max_value: DATA_SQL_DECIMAL is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"MaxValue"
		end

	frozen get_data: NATIVE_ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Data.SqlTypes.SqlDecimal"
		alias
			"get_Data"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"get_IsNull"
		end

	frozen get_bin_data: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Data.SqlTypes.SqlDecimal"
		alias
			"get_BinData"
		end

	frozen get_value: DECIMAL is
		external
			"IL signature (): System.Decimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"get_Value"
		end

	frozen max_precision: INTEGER_8 is
		external
			"IL static_field signature :System.Byte use System.Data.SqlTypes.SqlDecimal"
		alias
			"MaxPrecision"
		end

	frozen get_precision: INTEGER_8 is
		external
			"IL signature (): System.Byte use System.Data.SqlTypes.SqlDecimal"
		alias
			"get_Precision"
		end

	frozen min_value: DATA_SQL_DECIMAL is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"MinValue"
		end

	frozen max_scale: INTEGER_8 is
		external
			"IL static_field signature :System.Byte use System.Data.SqlTypes.SqlDecimal"
		alias
			"MaxScale"
		end

	frozen get_scale: INTEGER_8 is
		external
			"IL signature (): System.Byte use System.Data.SqlTypes.SqlDecimal"
		alias
			"get_Scale"
		end

	frozen null: DATA_SQL_DECIMAL is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Null"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlDecimal"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToString"
		end

	frozen to_sql_int32: DATA_SQL_INT32 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlInt32"
		end

	frozen power (n: DATA_SQL_DECIMAL; exp: DOUBLE): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Double): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Power"
		end

	frozen to_sql_single: DATA_SQL_SINGLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlSingle"
		end

	frozen to_sql_double: DATA_SQL_DOUBLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlDouble"
		end

	frozen to_sql_money: DATA_SQL_MONEY is
		external
			"IL signature (): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlMoney"
		end

	frozen to_double: DOUBLE is
		external
			"IL signature (): System.Double use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToDouble"
		end

	frozen parse (s: SYSTEM_STRING): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Parse"
		end

	frozen ceiling (n: DATA_SQL_DECIMAL): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Ceiling"
		end

	frozen greater_than_or_equal (x: DATA_SQL_DECIMAL; y: DATA_SQL_DECIMAL): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"GreaterThanOrEqual"
		end

	frozen less_than_or_equal (x: DATA_SQL_DECIMAL; y: DATA_SQL_DECIMAL): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"LessThanOrEqual"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"Equals"
		end

	frozen to_sql_byte: DATA_SQL_BYTE is
		external
			"IL signature (): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlByte"
		end

	frozen divide (x: DATA_SQL_DECIMAL; y: DATA_SQL_DECIMAL): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Divide"
		end

	frozen convert_to_prec_scale (n: DATA_SQL_DECIMAL; precision: INTEGER; scale: INTEGER): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Int32, System.Int32): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"ConvertToPrecScale"
		end

	frozen not_equals (x: DATA_SQL_DECIMAL; y: DATA_SQL_DECIMAL): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"NotEquals"
		end

	frozen to_sql_int16: DATA_SQL_INT16 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt16 use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlInt16"
		end

	frozen to_sql_string: DATA_SQL_STRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlString"
		end

	frozen round (n: DATA_SQL_DECIMAL; position: INTEGER): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Int32): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Round"
		end

	frozen equals_sql_decimal (x: DATA_SQL_DECIMAL; y: DATA_SQL_DECIMAL): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"Equals"
		end

	frozen adjust_scale (n: DATA_SQL_DECIMAL; digits: INTEGER; f_round: BOOLEAN): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Int32, System.Boolean): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"AdjustScale"
		end

	frozen multiply (x: DATA_SQL_DECIMAL; y: DATA_SQL_DECIMAL): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Multiply"
		end

	frozen less_than (x: DATA_SQL_DECIMAL; y: DATA_SQL_DECIMAL): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"LessThan"
		end

	frozen truncate (n: DATA_SQL_DECIMAL; position: INTEGER): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Int32): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Truncate"
		end

	frozen subtract (x: DATA_SQL_DECIMAL; y: DATA_SQL_DECIMAL): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Subtract"
		end

	frozen sign (n: DATA_SQL_DECIMAL): DATA_SQL_INT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlDecimal"
		alias
			"Sign"
		end

	frozen greater_than (x: DATA_SQL_DECIMAL; y: DATA_SQL_DECIMAL): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"GreaterThan"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlDecimal"
		alias
			"CompareTo"
		end

	frozen abs (n: DATA_SQL_DECIMAL): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Abs"
		end

	frozen add (x: DATA_SQL_DECIMAL; y: DATA_SQL_DECIMAL): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Add"
		end

	frozen to_sql_boolean: DATA_SQL_BOOLEAN is
		external
			"IL signature (): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlBoolean"
		end

	frozen to_sql_int64: DATA_SQL_INT64 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt64 use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlInt64"
		end

	frozen floor (n: DATA_SQL_DECIMAL): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Floor"
		end

feature -- Unary Operators

	frozen prefix "-": DATA_SQL_DECIMAL is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_UnaryNegation"
		end

feature -- Binary Operators

	frozen infix "|=" (y: DATA_SQL_DECIMAL): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (y: DATA_SQL_DECIMAL): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: DATA_SQL_DECIMAL): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Equality"
		end

	frozen infix "-" (y: DATA_SQL_DECIMAL): DATA_SQL_DECIMAL is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Subtraction"
		end

	frozen infix "<=" (y: DATA_SQL_DECIMAL): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "/" (y: DATA_SQL_DECIMAL): DATA_SQL_DECIMAL is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Division"
		end

	frozen infix "+" (y: DATA_SQL_DECIMAL): DATA_SQL_DECIMAL is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Addition"
		end

	frozen infix ">" (y: DATA_SQL_DECIMAL): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_GreaterThan"
		end

	frozen infix "<" (y: DATA_SQL_DECIMAL): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_LessThan"
		end

	frozen infix "*" (y: DATA_SQL_DECIMAL): DATA_SQL_DECIMAL is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Multiply"
		end

feature -- Specials

	frozen op_implicit (x: DATA_SQL_INT32): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_decimal (x: DATA_SQL_DECIMAL): DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Decimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_string (x: DATA_SQL_STRING): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Explicit"
		end

	frozen op_implicit_sql_byte (x: DATA_SQL_BYTE): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_int64 (x: DATA_SQL_INT64): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt64): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_int16 (x: DATA_SQL_INT16): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt16): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_money (x: DATA_SQL_MONEY): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Implicit"
		end

	frozen op_implicit_decimal (x: DECIMAL): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Decimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Implicit"
		end

	frozen op_explicit (x: DATA_SQL_DOUBLE): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_boolean (x: DATA_SQL_BOOLEAN): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_single (x: DATA_SQL_SINGLE): DATA_SQL_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Explicit"
		end

end -- class DATA_SQL_DECIMAL
