indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlTypes.SqlBoolean"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DATA_SQL_BOOLEAN

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

	frozen make_data_sql_boolean (value: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Data.SqlTypes.SqlBoolean"
		end

	frozen make_data_sql_boolean_1 (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Data.SqlTypes.SqlBoolean"
		end

feature -- Access

	frozen true_: DATA_SQL_BOOLEAN is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"True"
		end

	frozen get_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"get_Value"
		end

	frozen false_: DATA_SQL_BOOLEAN is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"False"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"get_IsNull"
		end

	frozen zero: DATA_SQL_BOOLEAN is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"Zero"
		end

	frozen get_is_true: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"get_IsTrue"
		end

	frozen get_is_false: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"get_IsFalse"
		end

	frozen one: DATA_SQL_BOOLEAN is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"One"
		end

	frozen get_byte_value: INTEGER_8 is
		external
			"IL signature (): System.Byte use System.Data.SqlTypes.SqlBoolean"
		alias
			"get_ByteValue"
		end

	frozen null: DATA_SQL_BOOLEAN is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"Null"
		end

feature -- Basic Operations

	frozen equals_sql_boolean (x: DATA_SQL_BOOLEAN; y: DATA_SQL_BOOLEAN): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean, System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"Equals"
		end

	frozen xor_ (x: DATA_SQL_BOOLEAN; y: DATA_SQL_BOOLEAN): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean, System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"Xor"
		end

	frozen to_sql_int32: DATA_SQL_INT32 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlInt32"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlBoolean"
		alias
			"GetHashCode"
		end

	frozen to_sql_double: DATA_SQL_DOUBLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlDouble"
		end

	frozen to_sql_int64: DATA_SQL_INT64 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt64 use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlInt64"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlBoolean"
		alias
			"CompareTo"
		end

	frozen to_sql_money: DATA_SQL_MONEY is
		external
			"IL signature (): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlMoney"
		end

	frozen to_sql_single: DATA_SQL_SINGLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlSingle"
		end

	frozen to_sql_decimal: DATA_SQL_DECIMAL is
		external
			"IL signature (): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlDecimal"
		end

	frozen to_sql_int16: DATA_SQL_INT16 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt16 use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlInt16"
		end

	frozen and_ (x: DATA_SQL_BOOLEAN; y: DATA_SQL_BOOLEAN): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean, System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"And"
		end

	frozen to_sql_byte: DATA_SQL_BYTE is
		external
			"IL signature (): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlByte"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToString"
		end

	frozen not_equals (x: DATA_SQL_BOOLEAN; y: DATA_SQL_BOOLEAN): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean, System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"NotEquals"
		end

	frozen parse (s: SYSTEM_STRING): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"Parse"
		end

	frozen ones_complement (x: DATA_SQL_BOOLEAN): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"OnesComplement"
		end

	frozen to_sql_string: DATA_SQL_STRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlString"
		end

	frozen or_ (x: DATA_SQL_BOOLEAN; y: DATA_SQL_BOOLEAN): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean, System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"Or"
		end

feature -- Unary Operators

	frozen prefix "#~": DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_OnesComplement"
		end

	frozen prefix "#false": BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBoolean): System.Boolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_False"
		end

	frozen prefix "#true": BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBoolean): System.Boolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_True"
		end

	frozen prefix "not": DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_LogicalNot"
		end

feature -- Binary Operators

	frozen infix "&" (y: DATA_SQL_BOOLEAN): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_BitwiseAnd"
		end

	frozen infix "#==" (y: DATA_SQL_BOOLEAN): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Equality"
		end

	frozen infix "|=" (y: DATA_SQL_BOOLEAN): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Inequality"
		end

	frozen infix "xor" (y: DATA_SQL_BOOLEAN): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_ExclusiveOr"
		end

	frozen infix "|" (y: DATA_SQL_BOOLEAN): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_BitwiseOr"
		end

feature -- Specials

	frozen op_explicit_sql_double (x: DATA_SQL_DOUBLE): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_decimal (x: DATA_SQL_DECIMAL): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int64 (x: DATA_SQL_INT64): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt64): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_string (x: DATA_SQL_STRING): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int16 (x: DATA_SQL_INT16): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt16): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_implicit (x: BOOLEAN): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Boolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_byte (x: DATA_SQL_BYTE): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit (x: DATA_SQL_SINGLE): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_boolean (x: DATA_SQL_BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Boolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_money (x: DATA_SQL_MONEY): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int32 (x: DATA_SQL_INT32): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

end -- class DATA_SQL_BOOLEAN
