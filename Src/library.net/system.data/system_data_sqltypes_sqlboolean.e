indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlTypes.SqlBoolean"

frozen expanded external class
	SYSTEM_DATA_SQLTYPES_SQLBOOLEAN

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

	frozen make_sqlboolean (value: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Data.SqlTypes.SqlBoolean"
		end

	frozen make_sqlboolean_1 (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Data.SqlTypes.SqlBoolean"
		end

feature -- Access

	frozen get_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"get_Value"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"get_IsNull"
		end

	frozen True_: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"True"
		end

	frozen False_: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"False"
		end

	frozen zero: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
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

	frozen one: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
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

	frozen null: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"Null"
		end

feature -- Basic Operations

	frozen equals_sql_boolean (x: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN; y: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean, System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"Equals"
		end

	equals_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"Equals"
		end

	frozen to_sql_int32: SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlInt32"
		end

	frozen to_sql_decimal: SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL signature (): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlDecimal"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlBoolean"
		alias
			"GetHashCode"
		end

	frozen to_sql_double: SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlDouble"
		end

	frozen to_sql_int64: SYSTEM_DATA_SQLTYPES_SQLINT64 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt64 use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlInt64"
		end

	frozen to_sql_string: SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlString"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlBoolean"
		alias
			"CompareTo"
		end

	frozen Or_ (x: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN; y: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean, System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"Or"
		end

	frozen to_sql_money: SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL signature (): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlMoney"
		end

	frozen to_sql_single: SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlSingle"
		end

	frozen Xor_ (x: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN; y: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean, System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"Xor"
		end

	frozen to_sql_int16: SYSTEM_DATA_SQLTYPES_SQLINT16 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt16 use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlInt16"
		end

	frozen to_sql_byte: SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL signature (): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToSqlByte"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlBoolean"
		alias
			"ToString"
		end

	frozen not_equals (x: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN; y: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean, System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"NotEquals"
		end

	frozen parse (s: STRING): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"Parse"
		end

	frozen ones_complement (x: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"OnesComplement"
		end

	frozen And_ (x: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN; y: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean, System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"And"
		end

feature -- Unary Operators

	frozen prefix "#~": SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_OnesComplement"
		end

	frozen prefix "#false": BOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBoolean): System.Boolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_False"
		end

	frozen prefix "#true": BOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBoolean): System.Boolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_True"
		end

	frozen prefix "not": SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_LogicalNot"
		end

feature -- Binary Operators

	frozen infix "&" (y: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_BitwiseAnd"
		end

	frozen infix "#==" (y: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Equality"
		end

	frozen infix "|=" (y: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Inequality"
		end

	frozen infix "xor" (y: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_ExclusiveOr"
		end

	frozen infix "|" (y: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_BitwiseOr"
		end

feature -- Specials

	frozen op_explicit_sql_double (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_decimal (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int64 (x: SYSTEM_DATA_SQLTYPES_SQLINT64): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt64): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_string (x: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int16 (x: SYSTEM_DATA_SQLTYPES_SQLINT16): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt16): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_implicit (x: BOOLEAN): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Boolean): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_byte (x: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_boolean (x: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Boolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_money (x: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int32 (x: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBoolean"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_DATA_SQLTYPES_SQLBOOLEAN
