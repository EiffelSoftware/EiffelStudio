indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlTypes.SqlDecimal"

frozen expanded external class
	SYSTEM_DATA_SQLTYPES_SQLDECIMAL

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

	frozen make_sqldecimal_1 (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Data.SqlTypes.SqlDecimal"
		end

	frozen make_sqldecimal_3 (b_precision: INTEGER_8; b_scale: INTEGER_8; f_positive: BOOLEAN; bits: ARRAY [INTEGER]) is
		external
			"IL creator signature (System.Byte, System.Byte, System.Boolean, System.Int32[]) use System.Data.SqlTypes.SqlDecimal"
		end

	frozen make_sqldecimal_2 (value: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.Data.SqlTypes.SqlDecimal"
		end

	frozen make_sqldecimal_4 (b_precision: INTEGER_8; b_scale: INTEGER_8; f_positive: BOOLEAN; data1: INTEGER; data2: INTEGER; data3: INTEGER; data4: INTEGER) is
		external
			"IL creator signature (System.Byte, System.Byte, System.Boolean, System.Int32, System.Int32, System.Int32, System.Int32) use System.Data.SqlTypes.SqlDecimal"
		end

	frozen make_sqldecimal_5 (d_val: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.Data.SqlTypes.SqlDecimal"
		end

	frozen make_sqldecimal (value: SYSTEM_DECIMAL) is
		external
			"IL creator signature (System.Decimal) use System.Data.SqlTypes.SqlDecimal"
		end

feature -- Access

	frozen get_is_positive: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"get_IsPositive"
		end

	frozen max_value: SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"MaxValue"
		end

	frozen get_data: ARRAY [INTEGER] is
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

	frozen get_bin_data: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Data.SqlTypes.SqlDecimal"
		alias
			"get_BinData"
		end

	frozen get_value: SYSTEM_DECIMAL is
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

	frozen min_value: SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
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

	frozen null: SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToString"
		end

	frozen to_sql_int32: SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlInt32"
		end

	frozen power (n: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; exp: DOUBLE): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Double): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Power"
		end

	frozen to_sql_single: SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlSingle"
		end

	frozen to_sql_double: SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlDouble"
		end

	frozen to_sql_money: SYSTEM_DATA_SQLTYPES_SQLMONEY is
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

	frozen parse (s: STRING): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Parse"
		end

	frozen ceiling (n: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Ceiling"
		end

	frozen greater_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"GreaterThanOrEqual"
		end

	frozen add (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Add"
		end

	frozen to_sql_byte: SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL signature (): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlByte"
		end

	frozen divide (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Divide"
		end

	frozen convert_to_prec_scale (n: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; precision: INTEGER; scale: INTEGER): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Int32, System.Int32): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"ConvertToPrecScale"
		end

	frozen less_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"LessThanOrEqual"
		end

	frozen not_equals (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"NotEquals"
		end

	frozen to_sql_int16: SYSTEM_DATA_SQLTYPES_SQLINT16 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt16 use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlInt16"
		end

	frozen to_sql_string: SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlString"
		end

	frozen round (n: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; position: INTEGER): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Int32): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Round"
		end

	frozen equals_sql_decimal (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"Equals"
		end

	frozen adjust_scale (n: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; digits: INTEGER; f_round: BOOLEAN): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Int32, System.Boolean): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"AdjustScale"
		end

	frozen multiply (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Multiply"
		end

	frozen less_than (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"LessThan"
		end

	frozen truncate (n: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; position: INTEGER): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Int32): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Truncate"
		end

	frozen subtract (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Subtract"
		end

	frozen sign (n: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlDecimal"
		alias
			"Sign"
		end

	equals_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"Equals"
		end

	frozen greater_than (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL; y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal, System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"GreaterThan"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlDecimal"
		alias
			"CompareTo"
		end

	frozen abs (n: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Abs"
		end

	frozen to_sql_boolean: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL signature (): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlBoolean"
		end

	frozen to_sql_int64: SYSTEM_DATA_SQLTYPES_SQLINT64 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt64 use System.Data.SqlTypes.SqlDecimal"
		alias
			"ToSqlInt64"
		end

	frozen floor (n: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"Floor"
		end

feature -- Unary Operators

	frozen prefix "-": SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_UnaryNegation"
		end

feature -- Binary Operators

	frozen infix "|=" (y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Equality"
		end

	frozen infix "-" (y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Subtraction"
		end

	frozen infix "<=" (y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "/" (y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Division"
		end

	frozen infix "+" (y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Addition"
		end

	frozen infix ">" (y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_GreaterThan"
		end

	frozen infix "<" (y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_LessThan"
		end

	frozen infix "*" (y: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Multiply"
		end

feature -- Specials

	frozen op_implicit (x: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_decimal (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Decimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_string (x: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Explicit"
		end

	frozen op_implicit_sql_byte (x: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_int64 (x: SYSTEM_DATA_SQLTYPES_SQLINT64): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt64): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_int16 (x: SYSTEM_DATA_SQLTYPES_SQLINT16): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt16): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_money (x: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Implicit"
		end

	frozen op_implicit_decimal (x: SYSTEM_DECIMAL): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Decimal): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Implicit"
		end

	frozen op_explicit (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_boolean (x: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_single (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlDecimal"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_DATA_SQLTYPES_SQLDECIMAL
