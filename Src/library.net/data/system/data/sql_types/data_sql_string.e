indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlTypes.SqlString"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DATA_SQL_STRING

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

	frozen make_data_sql_string_4 (data: SYSTEM_STRING; lcid: INTEGER; compare_options: DATA_SQL_COMPARE_OPTIONS) is
		external
			"IL creator signature (System.String, System.Int32, System.Data.SqlTypes.SqlCompareOptions) use System.Data.SqlTypes.SqlString"
		end

	frozen make_data_sql_string (lcid: INTEGER; compare_options: DATA_SQL_COMPARE_OPTIONS; data: NATIVE_ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER; f_unicode: BOOLEAN) is
		external
			"IL creator signature (System.Int32, System.Data.SqlTypes.SqlCompareOptions, System.Byte[], System.Int32, System.Int32, System.Boolean) use System.Data.SqlTypes.SqlString"
		end

	frozen make_data_sql_string_3 (lcid: INTEGER; compare_options: DATA_SQL_COMPARE_OPTIONS; data: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Int32, System.Data.SqlTypes.SqlCompareOptions, System.Byte[]) use System.Data.SqlTypes.SqlString"
		end

	frozen make_data_sql_string_2 (lcid: INTEGER; compare_options: DATA_SQL_COMPARE_OPTIONS; data: NATIVE_ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Data.SqlTypes.SqlCompareOptions, System.Byte[], System.Int32, System.Int32) use System.Data.SqlTypes.SqlString"
		end

	frozen make_data_sql_string_1 (lcid: INTEGER; compare_options: DATA_SQL_COMPARE_OPTIONS; data: NATIVE_ARRAY [INTEGER_8]; f_unicode: BOOLEAN) is
		external
			"IL creator signature (System.Int32, System.Data.SqlTypes.SqlCompareOptions, System.Byte[], System.Boolean) use System.Data.SqlTypes.SqlString"
		end

	frozen make_data_sql_string_6 (data: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.SqlTypes.SqlString"
		end

	frozen make_data_sql_string_5 (data: SYSTEM_STRING; lcid: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Data.SqlTypes.SqlString"
		end

feature -- Access

	frozen get_sql_compare_options: DATA_SQL_COMPARE_OPTIONS is
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

	frozen get_compare_info: COMPARE_INFO is
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

	frozen get_culture_info: CULTURE_INFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Data.SqlTypes.SqlString"
		alias
			"get_CultureInfo"
		end

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlString"
		alias
			"get_Value"
		end

	frozen null: DATA_SQL_STRING is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"Null"
		end

feature -- Basic Operations

	frozen compare_options_from_sql_compare_options (compare_options: DATA_SQL_COMPARE_OPTIONS): COMPARE_OPTIONS is
		external
			"IL static signature (System.Data.SqlTypes.SqlCompareOptions): System.Globalization.CompareOptions use System.Data.SqlTypes.SqlString"
		alias
			"CompareOptionsFromSqlCompareOptions"
		end

	frozen less_than (x: DATA_SQL_STRING; y: DATA_SQL_STRING): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlString, System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"LessThan"
		end

	frozen to_sql_double: DATA_SQL_DOUBLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlDouble"
		end

	frozen greater_than (x: DATA_SQL_STRING; y: DATA_SQL_STRING): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlString, System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"GreaterThan"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlString"
		alias
			"Equals"
		end

	frozen concat (x: DATA_SQL_STRING; y: DATA_SQL_STRING): DATA_SQL_STRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlString, System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"Concat"
		end

	frozen to_sql_single: DATA_SQL_SINGLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlSingle"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlString"
		alias
			"GetHashCode"
		end

	frozen to_sql_date_time: DATA_SQL_DATE_TIME is
		external
			"IL signature (): System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlDateTime"
		end

	frozen less_than_or_equal (x: DATA_SQL_STRING; y: DATA_SQL_STRING): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlString, System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"LessThanOrEqual"
		end

	frozen to_sql_int64: DATA_SQL_INT64 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt64 use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlInt64"
		end

	frozen not_equals (x: DATA_SQL_STRING; y: DATA_SQL_STRING): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlString, System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"NotEquals"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlString"
		alias
			"CompareTo"
		end

	frozen greater_than_or_equal (x: DATA_SQL_STRING; y: DATA_SQL_STRING): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlString, System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"GreaterThanOrEqual"
		end

	frozen to_sql_int32: DATA_SQL_INT32 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlInt32"
		end

	frozen to_sql_money: DATA_SQL_MONEY is
		external
			"IL signature (): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlMoney"
		end

	frozen clone_: DATA_SQL_STRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"Clone"
		end

	frozen to_sql_decimal: DATA_SQL_DECIMAL is
		external
			"IL signature (): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlDecimal"
		end

	frozen to_sql_int16: DATA_SQL_INT16 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt16 use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlInt16"
		end

	frozen get_unicode_bytes: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Data.SqlTypes.SqlString"
		alias
			"GetUnicodeBytes"
		end

	frozen to_sql_byte: DATA_SQL_BYTE is
		external
			"IL signature (): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlByte"
		end

	frozen to_sql_boolean: DATA_SQL_BOOLEAN is
		external
			"IL signature (): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlBoolean"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlString"
		alias
			"ToString"
		end

	frozen equals_sql_string (x: DATA_SQL_STRING; y: DATA_SQL_STRING): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlString, System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"Equals"
		end

	frozen get_non_unicode_bytes: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Data.SqlTypes.SqlString"
		alias
			"GetNonUnicodeBytes"
		end

	frozen to_sql_guid: DATA_SQL_GUID is
		external
			"IL signature (): System.Data.SqlTypes.SqlGuid use System.Data.SqlTypes.SqlString"
		alias
			"ToSqlGuid"
		end

feature -- Binary Operators

	frozen infix ">=" (y: DATA_SQL_STRING): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: DATA_SQL_STRING): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"op_Equality"
		end

	frozen infix "|=" (y: DATA_SQL_STRING): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"op_Inequality"
		end

	frozen infix "+" (y: DATA_SQL_STRING): DATA_SQL_STRING is
		external
			"IL operator signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Addition"
		end

	frozen infix "<" (y: DATA_SQL_STRING): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"op_LessThan"
		end

	frozen infix "<=" (y: DATA_SQL_STRING): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix ">" (y: DATA_SQL_STRING): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlString"
		alias
			"op_GreaterThan"
		end

feature -- Specials

	frozen op_implicit (x: SYSTEM_STRING): DATA_SQL_STRING is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_int64 (x: DATA_SQL_INT64): DATA_SQL_STRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt64): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_string (x: DATA_SQL_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.String use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int16 (x: DATA_SQL_INT16): DATA_SQL_STRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt16): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_byte (x: DATA_SQL_BYTE): DATA_SQL_STRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_date_time (x: DATA_SQL_DATE_TIME): DATA_SQL_STRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit (x: DATA_SQL_DECIMAL): DATA_SQL_STRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_boolean (x: DATA_SQL_BOOLEAN): DATA_SQL_STRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_double (x: DATA_SQL_DOUBLE): DATA_SQL_STRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_single (x: DATA_SQL_SINGLE): DATA_SQL_STRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_money (x: DATA_SQL_MONEY): DATA_SQL_STRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_int32 (x: DATA_SQL_INT32): DATA_SQL_STRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_guid (x: DATA_SQL_GUID): DATA_SQL_STRING is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlString"
		alias
			"op_Explicit"
		end

end -- class DATA_SQL_STRING
