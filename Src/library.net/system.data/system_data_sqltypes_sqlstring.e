indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlTypes.SqlString"

frozen expanded external class
	SYSTEM_DATA_SQLTYPES_SQLSTRING

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

	frozen make_sqlstring_6 (data: STRING) is
		external
			"IL creator signature (System.String) use System.Data.SqlTypes.SqlString"
		end

	frozen make_sqlstring (lcid: INTEGER; compare_options: SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS; data: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER; f_unicode: BOOLEAN) is
		external
			"IL creator signature (System.Int32, System.Data.SqlTypes.SqlCompareOptions, System.Byte[], System.Int32, System.Int32, System.Boolean) use System.Data.SqlTypes.SqlString"
		end

	frozen make_sqlstring_2 (lcid: INTEGER; compare_options: SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS; data: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Data.SqlTypes.SqlCompareOptions, System.Byte[], System.Int32, System.Int32) use System.Data.SqlTypes.SqlString"
		end

	frozen make_sqlstring_1 (lcid: INTEGER; compare_options: SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS; data: ARRAY [INTEGER_8]; f_unicode: BOOLEAN) is
		external
			"IL creator signature (System.Int32, System.Data.SqlTypes.SqlCompareOptions, System.Byte[], System.Boolean) use System.Data.SqlTypes.SqlString"
		end

	frozen make_sqlstring_3 (lcid: INTEGER; compare_options: SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS; data: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Int32, System.Data.SqlTypes.SqlCompareOptions, System.Byte[]) use System.Data.SqlTypes.SqlString"
		end

	frozen make_sqlstring_5 (data: STRING; lcid: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Data.SqlTypes.SqlString"
		end

	frozen make_sqlstring_4 (data: STRING; lcid: INTEGER; compare_options: SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS) is
		external
			"IL creator signature (System.String, System.Int32, System.Data.SqlTypes.SqlCompareOptions) use System.Data.SqlTypes.SqlString"
		end

feature -- Access

	frozen get_sql_compare_options: SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS is
		external
			"IL signature (): System.Data.SqlTypes.SqlCompareOptions use System.Data.SqlTypes.SqlString"
		alias
			"get_SqlCompareOptions"
		end

	frozen get_lcid: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlString"
		alias
			"get_LCID"
		end

	frozen ignore_case: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Data.SqlTypes.SqlString"
		alias
			"IgnoreCase"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlString"
		alias
			"get_IsNull"
		end

	frozen ignore_non_space: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Data.SqlTypes.SqlString"
		alias
			"IgnoreNonSpace"
		end

	frozen ignore_width: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Data.SqlTypes.SqlString"
		alias
			"IgnoreWidth"
		end

	frozen get_compare_info: SYSTEM_GLOBALIZATION_COMPAREINFO is
		external
			"IL signature (): System.Globalization.CompareInfo use System.Data.SqlTypes.SqlString"
		alias
			"get_CompareInfo"
		end

	frozen binary_sort: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Data.SqlTypes.SqlString"
		alias
			"BinarySort"
		end

	frozen ignore_kana_type: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Data.SqlTypes.SqlString"
		alias
			"IgnoreKanaType"
		end

	frozen get_culture_info: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Data.SqlTypes.SqlString"
		alias
			"get_CultureInfo"
		end

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlString"
		alias
			"get_Value"
		end

	frozen null: SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"Null"
		end

feature -- Basic Operations

	frozen compare_options_from_sql_compare_options (compare_options: SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS): SYSTEM_GLOBALIZATION_COMPAREOPTIONS is
		external
			"IL static signature (System.Data.SqlTypes.SqlCompareOptions): System.Globalization.CompareOptions use System.Data.SqlTypes.SqlString"
		alias
			"CompareOptionsFromSqlCompareOptions"
		end

	equals_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlString"
		alias
			"Equals"
		end

	frozen less_than (x: SYSTEM_DATA_SQLTYPES_SQLSTRING; y: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlString, System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"LessThan"
		end

	frozen to_sql_double: SYSTEM_DATA_SQLTYPES_SQLDOUBLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlDouble"
		end

	frozen greater_than (x: SYSTEM_DATA_SQLTYPES_SQLSTRING; y: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlString, System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"GreaterThan"
		end

	frozen not_equals (x: SYSTEM_DATA_SQLTYPES_SQLSTRING; y: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlString, System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"NotEquals"
		end

	frozen clone: SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"Clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlString"
		alias
			"GetHashCode"
		end

	frozen to_sql_date_time: SYSTEM_DATA_SQLTYPES_SQLDATETIME is
		external
			"IL signature (): System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlDateTime"
		end

	frozen less_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLSTRING; y: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlString, System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"LessThanOrEqual"
		end

	frozen to_sql_int64: SYSTEM_DATA_SQLTYPES_SQLINT64 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt64 use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlInt64"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlString"
		alias
			"CompareTo"
		end

	frozen greater_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLSTRING; y: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlString, System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"GreaterThanOrEqual"
		end

	frozen to_sql_int32: SYSTEM_DATA_SQLTYPES_SQLINT32 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlInt32"
		end

	frozen to_sql_money: SYSTEM_DATA_SQLTYPES_SQLMONEY is
		external
			"IL signature (): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlMoney"
		end

	frozen to_sql_single: SYSTEM_DATA_SQLTYPES_SQLSINGLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlSingle"
		end

	frozen to_sql_decimal: SYSTEM_DATA_SQLTYPES_SQLDECIMAL is
		external
			"IL signature (): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlDecimal"
		end

	frozen to_sql_int16: SYSTEM_DATA_SQLTYPES_SQLINT16 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt16 use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlInt16"
		end

	frozen concat (x: SYSTEM_DATA_SQLTYPES_SQLSTRING; y: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlString, System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"Concat"
		end

	frozen get_unicode_bytes: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Data.SqlTypes.SqlString"
		alias
			"GetUnicodeBytes"
		end

	frozen to_sql_byte: SYSTEM_DATA_SQLTYPES_SQLBYTE is
		external
			"IL signature (): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlByte"
		end

	frozen to_sql_boolean: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL signature (): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlBoolean"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlString"
		alias
			"ToString"
		end

	frozen equals_sql_string (x: SYSTEM_DATA_SQLTYPES_SQLSTRING; y: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlString, System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"Equals"
		end

	frozen get_non_unicode_bytes: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Data.SqlTypes.SqlString"
		alias
			"GetNonUnicodeBytes"
		end

	frozen to_sql_guid: SYSTEM_DATA_SQLTYPES_SQLGUID is
		external
			"IL signature (): System.Data.SqlTypes.SqlGuid use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlGuid"
		end

feature -- Binary Operators

	frozen infix ">=" (y: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"op_Equality"
		end

	frozen infix "|=" (y: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"op_Inequality"
		end

	frozen infix "+" (y: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Addition"
		end

	frozen infix "<" (y: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"op_LessThan"
		end

	frozen infix "<=" (y: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix ">" (y: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"op_GreaterThan"
		end

feature -- Specials

	frozen op_implicit (x: STRING): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_int64 (x: SYSTEM_DATA_SQLTYPES_SQLINT64): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt64): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_string (x: SYSTEM_DATA_SQLTYPES_SQLSTRING): STRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.String use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int16 (x: SYSTEM_DATA_SQLTYPES_SQLINT16): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt16): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_byte (x: SYSTEM_DATA_SQLTYPES_SQLBYTE): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_date_time (x: SYSTEM_DATA_SQLTYPES_SQLDATETIME): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit (x: SYSTEM_DATA_SQLTYPES_SQLDECIMAL): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_boolean (x: SYSTEM_DATA_SQLTYPES_SQLBOOLEAN): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_double (x: SYSTEM_DATA_SQLTYPES_SQLDOUBLE): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_single (x: SYSTEM_DATA_SQLTYPES_SQLSINGLE): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_money (x: SYSTEM_DATA_SQLTYPES_SQLMONEY): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int32 (x: SYSTEM_DATA_SQLTYPES_SQLINT32): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_guid (x: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_DATA_SQLTYPES_SQLSTRING
