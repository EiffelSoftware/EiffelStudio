indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Convert"

frozen external class
	SYSTEM_CONVERT

create {NONE}

feature -- Access

	frozen db_null: ANY is
		external
			"IL static_field signature :System.Object use System.Convert"
		alias
			"DBNull"
		end

feature -- Basic Operations

	frozen any_to_byte_with_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): INTEGER_8 is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen int16_to_date_time (value: INTEGER_16): SYSTEM_DATETIME is
		external
			"IL static signature (System.Int16): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen string_to_byte_from_base (value: STRING; fromBase: INTEGER): INTEGER_8 is
		external
			"IL static signature (System.String, System.Int32): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen boolean_to_string (value: BOOLEAN): STRING is
		external
			"IL static signature (System.Boolean): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen string_to_date_time (value: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen byte_to_boolean (value: INTEGER_8): BOOLEAN is
		external
			"IL static signature (System.Byte): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen date_time_to_byte (value: SYSTEM_DATETIME): INTEGER_8 is
		external
			"IL static signature (System.DateTime): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen decimal_to_date_time (value: SYSTEM_DECIMAL): SYSTEM_DATETIME is
		external
			"IL static signature (System.Decimal): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen any_to_int16_with_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): INTEGER_16 is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen int16_to_string_to_base (value: INTEGER_16; toBase: INTEGER): STRING is
		external
			"IL static signature (System.Int16, System.Int32): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen integer_to_character (value: INTEGER): CHARACTER is
		external
			"IL static signature (System.Int32): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen double_to_decimal (value: DOUBLE): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Double): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen byte_to_int16 (value: INTEGER_8): INTEGER_16 is
		external
			"IL static signature (System.Byte): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen decimal_to_byte (value: SYSTEM_DECIMAL): INTEGER_8 is
		external
			"IL static signature (System.Decimal): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen integer_to_int64 (value: INTEGER): INTEGER_64 is
		external
			"IL static signature (System.Int32): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen date_time_to_int64 (value: SYSTEM_DATETIME): INTEGER_64 is
		external
			"IL static signature (System.DateTime): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen string_to_integer_from_base (value: STRING; fromBase: INTEGER): INTEGER is
		external
			"IL static signature (System.String, System.Int32): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen int64_to_string_with_provider (value: INTEGER_64; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Int64, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen decimal_to_string_with_provider (value: SYSTEM_DECIMAL; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Decimal, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen date_time_to_character (value: SYSTEM_DATETIME): CHARACTER is
		external
			"IL static signature (System.DateTime): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen integer_to_date_time (value: INTEGER): SYSTEM_DATETIME is
		external
			"IL static signature (System.Int32): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen byte_to_string_with_provider (value: INTEGER_8; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Byte, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen int16_to_double (value: INTEGER_16): DOUBLE is
		external
			"IL static signature (System.Int16): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen any_to_character_with_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): CHARACTER is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen byte_to_decimal (value: INTEGER_8): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Byte): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen int64_to_int16 (value: INTEGER_64): INTEGER_16 is
		external
			"IL static signature (System.Int64): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen get_type_code (value: ANY): INTEGER is
		external
			"IL static signature (System.Object): enum System.TypeCode use System.Convert"
		alias
			"GetTypeCode"
		ensure
			valid_type_code: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 8 or Result = 9 or Result = 10 or Result = 11 or Result = 12 or Result = 13 or Result = 14 or Result = 15 or Result = 16 or Result = 18
		end

	frozen string_to_int64_with_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): INTEGER_64 is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen string_to_decimal (value: STRING): SYSTEM_DECIMAL is
		external
			"IL static signature (System.String): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen boolean_to_int16 (value: BOOLEAN): INTEGER_16 is
		external
			"IL static signature (System.Boolean): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen double_to_character (value: DOUBLE): CHARACTER is
		external
			"IL static signature (System.Double): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen date_time_to_decimal (value: SYSTEM_DATETIME): SYSTEM_DECIMAL is
		external
			"IL static signature (System.DateTime): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen integer_to_decimal (value: INTEGER): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Int32): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen string_to_int64 (value: STRING): INTEGER_64 is
		external
			"IL static signature (System.String): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen boolean_to_double (value: BOOLEAN): DOUBLE is
		external
			"IL static signature (System.Boolean): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen integer_to_double (value: INTEGER): DOUBLE is
		external
			"IL static signature (System.Int32): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen real_to_int16 (value: REAL): INTEGER_16 is
		external
			"IL static signature (System.Single): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen change_type_to_with_provider (value: ANY; conversionType: SYSTEM_TYPE; provider: SYSTEM_IFORMATPROVIDER): ANY is
		external
			"IL static signature (System.Object, System.Type, System.IFormatProvider): System.Object use System.Convert"
		alias
			"ChangeType"
		end

	frozen any_to_byte (value: ANY): INTEGER_8 is
		external
			"IL static signature (System.Object): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen decimal_to_integer (value: SYSTEM_DECIMAL): INTEGER is
		external
			"IL static signature (System.Decimal): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen date_time_to_string_with_provider (value: SYSTEM_DATETIME; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.DateTime, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen character_to_single (value: CHARACTER): REAL is
		external
			"IL static signature (System.Char): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen charcter_to_boolean (value: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen integer_to_byte (value: INTEGER): INTEGER_8 is
		external
			"IL static signature (System.Int32): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen decimal_to_character (value: SYSTEM_DECIMAL): CHARACTER is
		external
			"IL static signature (System.Decimal): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen character_to_int64 (value: CHARACTER): INTEGER_64 is
		external
			"IL static signature (System.Char): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen boolean_to_byte (value: BOOLEAN): INTEGER_8 is
		external
			"IL static signature (System.Boolean): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen int64_to_boolean (value: INTEGER_64): BOOLEAN is
		external
			"IL static signature (System.Int64): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen character_to_string_with_provider (value: CHARACTER; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Char, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen byte_to_real (value: INTEGER_8): REAL is
		external
			"IL static signature (System.Byte): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen any_to_date_time (value: ANY): SYSTEM_DATETIME is
		external
			"IL static signature (System.Object): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen real_to_string (value: REAL): STRING is
		external
			"IL static signature (System.Single): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen any_to_decimal_with_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen character_to_date_time (value: CHARACTER): SYSTEM_DATETIME is
		external
			"IL static signature (System.Char): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen int16_to_decimal (value: INTEGER_16): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Int16): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen date_time_to_int16 (value: SYSTEM_DATETIME): INTEGER_16 is
		external
			"IL static signature (System.DateTime): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen byte_to_date_time (value: INTEGER_8): SYSTEM_DATETIME is
		external
			"IL static signature (System.Byte): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen character_to_byte (value: CHARACTER): INTEGER_8 is
		external
			"IL static signature (System.Char): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen any_to_boolean (value: ANY): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen any_to_boolean_with_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): BOOLEAN is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen double_to_byte (value: DOUBLE): INTEGER_8 is
		external
			"IL static signature (System.Double): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen string_to_int16 (value: STRING): INTEGER_16 is
		external
			"IL static signature (System.String): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen string_to_decimal_with_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): SYSTEM_DECIMAL is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen int64_to_integer (value: INTEGER_64): INTEGER is
		external
			"IL static signature (System.Int64): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen from_base_64_char_array (inArray: ARRAY [CHARACTER]; offset: INTEGER; length: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Char[], System.Int32, System.Int32): System.Byte[] use System.Convert"
		alias
			"FromBase64CharArray"
		end

	frozen string_to_double (value: STRING): DOUBLE is
		external
			"IL static signature (System.String): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen change_type (value: ANY; conversionType: SYSTEM_TYPE): ANY is
		external
			"IL static signature (System.Object, System.Type): System.Object use System.Convert"
		alias
			"ChangeType"
		end

	frozen any_to_double (value: ANY): DOUBLE is
		external
			"IL static signature (System.Object): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen string_to_byte_with_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): INTEGER_8 is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen real_to_double (value: REAL): DOUBLE is
		external
			"IL static signature (System.Single): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen int16_to_byte (value: INTEGER_16): INTEGER_8 is
		external
			"IL static signature (System.Int16): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen real_to_string_with_provider (value: REAL; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Single, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen boolean_to_real (value: BOOLEAN): REAL is
		external
			"IL static signature (System.Boolean): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen string_to_real (value: STRING): REAL is
		external
			"IL static signature (System.String): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen any_to_string_with_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen string_to_byte (value: STRING): INTEGER_8 is
		external
			"IL static signature (System.String): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen any_to_string (value: ANY): STRING is
		external
			"IL static signature (System.Object): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen is_db_null (value: ANY): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Convert"
		alias
			"IsDBNull"
		end

	frozen string_to_real_with_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): REAL is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen byte_to_string_to_base (value: INTEGER_8; toBase: INTEGER): STRING is
		external
			"IL static signature (System.Byte, System.Int32): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_base_64_string (inArray: ARRAY [INTEGER_8]): STRING is
		external
			"IL static signature (System.Byte[]): System.String use System.Convert"
		alias
			"ToBase64String"
		end

	frozen int16_to_string (value: INTEGER_16): STRING is
		external
			"IL static signature (System.Int16): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen change_type_with_code (value: ANY; type_code: INTEGER): ANY is
			-- Valid values for `type_code' are:
			-- Empty = 0
			-- Object = 1
			-- DBNull = 2
			-- Boolean = 3
			-- Char = 4
			-- SByte = 5
			-- Byte = 6
			-- Int16 = 7
			-- UInt16 = 8
			-- Int32 = 9
			-- UInt32 = 10
			-- Int64 = 11
			-- UInt64 = 12
			-- Single = 13
			-- Double = 14
			-- Decimal = 15
			-- DateTime = 16
			-- String = 18
		require
			valid_type_code: type_code = 0 or type_code = 1 or type_code = 2 or type_code = 3 or type_code = 4 or type_code = 5 or type_code = 6 or type_code = 7 or type_code = 8 or type_code = 9 or type_code = 10 or type_code = 11 or type_code = 12 or type_code = 13 or type_code = 14 or type_code = 15 or type_code = 16 or type_code = 18
		external
			"IL static signature (System.Object, enum System.TypeCode): System.Object use System.Convert"
		alias
			"ChangeType"
		end

	frozen double_to_integer (value: DOUBLE): INTEGER is
		external
			"IL static signature (System.Double): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen any_to_integer (value: ANY): INTEGER is
		external
			"IL static signature (System.Object): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen date_time_to_string (value: SYSTEM_DATETIME): STRING is
		external
			"IL static signature (System.DateTime): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen byte_to_double (value: INTEGER_8): DOUBLE is
		external
			"IL static signature (System.Byte): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen decimal_to_boolean (value: SYSTEM_DECIMAL): BOOLEAN is
		external
			"IL static signature (System.Decimal): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen real_to_character (value: REAL): CHARACTER is
		external
			"IL static signature (System.Single): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen string_to_character_with_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): CHARACTER is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen date_time_to_boolean (value: SYSTEM_DATETIME): BOOLEAN is
		external
			"IL static signature (System.DateTime): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen integer_to_string_with_provider (value: INTEGER; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Int32, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen real_to_decimal (value: REAL): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Single): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen any_to_int64 (value: ANY): INTEGER_64 is
		external
			"IL static signature (System.Object): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen decimal_to_int16 (value: SYSTEM_DECIMAL): INTEGER_16 is
		external
			"IL static signature (System.Decimal): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen double_to_int64 (value: DOUBLE): INTEGER_64 is
		external
			"IL static signature (System.Double): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen decimal_to_double (value: SYSTEM_DECIMAL): DOUBLE is
		external
			"IL static signature (System.Decimal): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen double_to_string_with_provider (value: DOUBLE; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Double, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen string_to_string (value: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen byte_to_integer (value: INTEGER_8): INTEGER is
		external
			"IL static signature (System.Byte): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen int64_to_double (value: INTEGER_64): DOUBLE is
		external
			"IL static signature (System.Int64): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen byte_to_int64 (value: INTEGER_8): INTEGER_64 is
		external
			"IL static signature (System.Byte): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen int16_to_boolean (value: INTEGER_16): BOOLEAN is
		external
			"IL static signature (System.Int16): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen real_to_date_time (value: REAL): SYSTEM_DATETIME is
		external
			"IL static signature (System.Single): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen character_to_decimal (value: CHARACTER): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Char): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen integer_to_string (value: INTEGER): STRING is
		external
			"IL static signature (System.Int32): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen any_to_int64_with_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): INTEGER_64 is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen double_to_date_time (value: DOUBLE): SYSTEM_DATETIME is
		external
			"IL static signature (System.Double): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen int16_to_int64 (value: INTEGER_16): INTEGER_64 is
		external
			"IL static signature (System.Int16): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen double_to_int16 (value: DOUBLE): INTEGER_16 is
		external
			"IL static signature (System.Double): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen int16_to_string_with_provider (value: INTEGER_16; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Int16, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen decimal_to_decimal (value: SYSTEM_DECIMAL): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Decimal): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen int64_to_real (value: INTEGER_64): REAL is
		external
			"IL static signature (System.Int64): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen byte_to_character (value: INTEGER_8): CHARACTER is
		external
			"IL static signature (System.Byte): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen character_to_int16 (value: CHARACTER): INTEGER_16 is
		external
			"IL static signature (System.Char): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_base_64_char_array (inArray: ARRAY [INTEGER_8]; offsetIn: INTEGER; length: INTEGER; outArray: ARRAY [CHARACTER]; offsetOut: INTEGER): INTEGER is
		external
			"IL static signature (System.Byte[], System.Int32, System.Int32, System.Char[], System.Int32): System.Int32 use System.Convert"
		alias
			"ToBase64CharArray"
		end

	frozen real_to_real (value: REAL): REAL is
		external
			"IL static signature (System.Single): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen string_to_character (value: STRING): CHARACTER is
		external
			"IL static signature (System.String): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_base_64_string_part (in_array: ARRAY [INTEGER_8]; offset: INTEGER; length: INTEGER): STRING is
		external
			"IL static signature (System.Byte[], System.Int32, System.Int32): System.String use System.Convert"
		alias
			"ToBase64String"
		end

	frozen byte_to_string (value: INTEGER_8): STRING is
		external
			"IL static signature (System.Byte): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen integer_to_integer (value: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen integer_to_real (value: INTEGER): REAL is
		external
			"IL static signature (System.Int32): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen int64_to_date_time (value: INTEGER_64): SYSTEM_DATETIME is
		external
			"IL static signature (System.Int64): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen real_to_integer (value: REAL): INTEGER is
		external
			"IL static signature (System.Single): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen from_base_64_string (s: STRING): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Convert"
		alias
			"FromBase64String"
		end

	frozen boolean_to_integer (value: BOOLEAN): INTEGER is
		external
			"IL static signature (System.Boolean): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen integer_to_string_to_base (value: INTEGER; toBase: INTEGER): STRING is
		external
			"IL static signature (System.Int32, System.Int32): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen byte_to_byte (value: INTEGER_8): INTEGER_8 is
		external
			"IL static signature (System.Byte): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen int64_to_character (value: INTEGER_64): CHARACTER is
		external
			"IL static signature (System.Int64): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen boolean_to_decimal (value: BOOLEAN): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Boolean): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen character_to_double (value: CHARACTER): DOUBLE is
		external
			"IL static signature (System.Char): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen decimal_to_int64 (value: SYSTEM_DECIMAL): INTEGER_64 is
		external
			"IL static signature (System.Decimal): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen double_to_double (value: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen boolean_to_string_with_provider (value: BOOLEAN; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Boolean, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen character_to_integer (value: CHARACTER): INTEGER is
		external
			"IL static signature (System.Char): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen character_to_character (value: CHARACTER): CHARACTER is
		external
			"IL static signature (System.Char): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen any_to_real (value: ANY): REAL is
		external
			"IL static signature (System.Object): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen string_to_double_with_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): DOUBLE is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen int16_to_integer (value: INTEGER_16): INTEGER is
		external
			"IL static signature (System.Int16): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen int64_to_decimal (value: INTEGER_64): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Int64): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen int16_to_real (value: INTEGER_16): REAL is
		external
			"IL static signature (System.Int16): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen string_to_boolean (value: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen boolean_to_date_time (value: BOOLEAN): SYSTEM_DATETIME is
		external
			"IL static signature (System.Boolean): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen any_to_int16 (value: ANY): INTEGER_16 is
		external
			"IL static signature (System.Object): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen date_time_to_date_time (value: SYSTEM_DATETIME): SYSTEM_DATETIME is
		external
			"IL static signature (System.DateTime): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen any_to_single_with_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): REAL is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen date_time_to_real (value: SYSTEM_DATETIME): REAL is
		external
			"IL static signature (System.DateTime): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen double_to_string (value: DOUBLE): STRING is
		external
			"IL static signature (System.Double): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen date_time_to_integer (value: SYSTEM_DATETIME): INTEGER is
		external
			"IL static signature (System.DateTime): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen any_to_character (value: ANY): CHARACTER is
		external
			"IL static signature (System.Object): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen boolean_to_int64 (value: BOOLEAN): INTEGER_64 is
		external
			"IL static signature (System.Boolean): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen date_time_to_double (value: SYSTEM_DATETIME): DOUBLE is
		external
			"IL static signature (System.DateTime): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen int16_to_int16 (value: INTEGER_16): INTEGER_16 is
		external
			"IL static signature (System.Int16): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen real_to_int64 (value: REAL): INTEGER_64 is
		external
			"IL static signature (System.Single): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen any_to_decimal (value: ANY): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Object): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen any_to_double_with_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): DOUBLE is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen string_to_date_time_with_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): SYSTEM_DATETIME is
		external
			"IL static signature (System.String, System.IFormatProvider): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen integer_to_boolean (value: INTEGER): BOOLEAN is
		external
			"IL static signature (System.Int32): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen real_to_byte (value: REAL): INTEGER_8 is
		external
			"IL static signature (System.Single): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen double_to_real (value: DOUBLE): REAL is
		external
			"IL static signature (System.Double): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen int64_to_int64 (value: INTEGER_64): INTEGER_64 is
		external
			"IL static signature (System.Int64): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen int64_to_string (value: INTEGER_64): STRING is
		external
			"IL static signature (System.Int64): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen decimal_to_string (value: SYSTEM_DECIMAL): STRING is
		external
			"IL static signature (System.Decimal): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen change_type_with_code_and_provider (value: ANY; type_code: INTEGER; provider: SYSTEM_IFORMATPROVIDER): ANY is
			-- Valid values for `type_code' are:
			-- Empty = 0
			-- Object = 1
			-- DBNull = 2
			-- Boolean = 3
			-- Char = 4
			-- SByte = 5
			-- Byte = 6
			-- Int16 = 7
			-- UInt16 = 8
			-- Int32 = 9
			-- UInt32 = 10
			-- Int64 = 11
			-- UInt64 = 12
			-- Single = 13
			-- Double = 14
			-- Decimal = 15
			-- DateTime = 16
			-- String = 18
		require
			valid_type_code: type_code = 0 or type_code = 1 or type_code = 2 or type_code = 3 or type_code = 4 or type_code = 5 or type_code = 6 or type_code = 7 or type_code = 8 or type_code = 9 or type_code = 10 or type_code = 11 or type_code = 12 or type_code = 13 or type_code = 14 or type_code = 15 or type_code = 16 or type_code = 18
		external
			"IL static signature (System.Object, enum System.TypeCode, System.IFormatProvider): System.Object use System.Convert"
		alias
			"ChangeType"
		end

	frozen int16_to_character (value: INTEGER_16): CHARACTER is
		external
			"IL static signature (System.Int16): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen any_to_integer_with_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): INTEGER is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen string_to_integer_with_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): INTEGER is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen string_to_int64_from_base (value: STRING; fromBase: INTEGER): INTEGER_64 is
		external
			"IL static signature (System.String, System.Int32): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen character_to_string (value: CHARACTER): STRING is
		external
			"IL static signature (System.Char): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen string_to_boolean_with_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): BOOLEAN is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen real_to_boolean (value: REAL): BOOLEAN is
		external
			"IL static signature (System.Single): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen string_to_int16_with_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): INTEGER_16 is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen string_to_integer (value: STRING): INTEGER is
		external
			"IL static signature (System.String): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen string_to_int16_from_base (value: STRING; fromBase: INTEGER): INTEGER_16 is
		external
			"IL static signature (System.String, System.Int32): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen integer_to_int16 (value: INTEGER): INTEGER_16 is
		external
			"IL static signature (System.Int32): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen decimal_to_real (value: SYSTEM_DECIMAL): REAL is
		external
			"IL static signature (System.Decimal): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen double_to_boolean (value: DOUBLE): BOOLEAN is
		external
			"IL static signature (System.Double): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen any_to_date_time_with_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): SYSTEM_DATETIME is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen boolean_to_boolean (value: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Boolean): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen int64_to_byte (value: INTEGER_64): INTEGER_8 is
		external
			"IL static signature (System.Int64): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen int64_to_string_to_base (value: INTEGER_64; toBase: INTEGER): STRING is
		external
			"IL static signature (System.Int64, System.Int32): System.String use System.Convert"
		alias
			"ToString"
		end

end -- class SYSTEM_CONVERT
