indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Convert"

frozen external class
	SYSTEM_CONVERT

create {NONE}

feature -- Access

	frozen dbnull: ANY is
		external
			"IL static_field signature :System.Object use System.Convert"
		alias
			"DBNull"
		end

feature -- Basic Operations

	frozen to_boolean_string_iformat_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): BOOLEAN is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen to_int32_int32 (value: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen to_string_object (value: ANY): STRING is
		external
			"IL static signature (System.Object): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_int64_string (value: STRING): INTEGER_64 is
		external
			"IL static signature (System.String): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_char_char (value: CHARACTER): CHARACTER is
		external
			"IL static signature (System.Char): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_int16_single (value: REAL): INTEGER_16 is
		external
			"IL static signature (System.Single): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_decimal_decimal (value: SYSTEM_DECIMAL): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Decimal): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen to_boolean (value: REAL): BOOLEAN is
		external
			"IL static signature (System.Single): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen to_byte_decimal (value: SYSTEM_DECIMAL): INTEGER_8 is
		external
			"IL static signature (System.Decimal): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen from_base64_string (s: STRING): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Convert"
		alias
			"FromBase64String"
		end

	frozen to_int32_object_iformat_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): INTEGER is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen to_string_date_time (value: SYSTEM_DATETIME): STRING is
		external
			"IL static signature (System.DateTime): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_char_double (value: DOUBLE): CHARACTER is
		external
			"IL static signature (System.Double): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_int32_int64 (value: INTEGER_64): INTEGER is
		external
			"IL static signature (System.Int64): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen to_string_int16_int32 (value: INTEGER_16; to_base: INTEGER): STRING is
		external
			"IL static signature (System.Int16, System.Int32): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_double_int32 (value: INTEGER): DOUBLE is
		external
			"IL static signature (System.Int32): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen to_byte_boolean (value: BOOLEAN): INTEGER_8 is
		external
			"IL static signature (System.Boolean): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen to_int32_object (value: ANY): INTEGER is
		external
			"IL static signature (System.Object): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen to_int16_boolean (value: BOOLEAN): INTEGER_16 is
		external
			"IL static signature (System.Boolean): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_single_int32 (value: INTEGER): REAL is
		external
			"IL static signature (System.Int32): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen to_single_single (value: REAL): REAL is
		external
			"IL static signature (System.Single): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen to_int32_date_time (value: SYSTEM_DATETIME): INTEGER is
		external
			"IL static signature (System.DateTime): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen to_byte_date_time (value: SYSTEM_DATETIME): INTEGER_8 is
		external
			"IL static signature (System.DateTime): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen to_char_date_time (value: SYSTEM_DATETIME): CHARACTER is
		external
			"IL static signature (System.DateTime): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_int64_int32 (value: INTEGER): INTEGER_64 is
		external
			"IL static signature (System.Int32): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_boolean_object_iformat_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): BOOLEAN is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen change_type_object_type_code (value: ANY; type_code: SYSTEM_TYPECODE): ANY is
		external
			"IL static signature (System.Object, System.TypeCode): System.Object use System.Convert"
		alias
			"ChangeType"
		end

	frozen to_string_double (value: DOUBLE): STRING is
		external
			"IL static signature (System.Double): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_int64 (value: DOUBLE): INTEGER_64 is
		external
			"IL static signature (System.Double): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_int16_string_int32 (value: STRING; from_base: INTEGER): INTEGER_16 is
		external
			"IL static signature (System.String, System.Int32): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_char_string_iformat_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): CHARACTER is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_byte_object_iformat_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): INTEGER_8 is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen to_int32_string_iformat_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): INTEGER is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen to_string_byte (value: INTEGER_8): STRING is
		external
			"IL static signature (System.Byte): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_string_int32_iformat_provider (value: INTEGER; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Int32, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_double_int16 (value: INTEGER_16): DOUBLE is
		external
			"IL static signature (System.Int16): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen to_int32 (value: DOUBLE): INTEGER is
		external
			"IL static signature (System.Double): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen to_byte_int64 (value: INTEGER_64): INTEGER_8 is
		external
			"IL static signature (System.Int64): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen to_string_int64 (value: INTEGER_64): STRING is
		external
			"IL static signature (System.Int64): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_string_string (value: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_char_int32 (value: INTEGER): CHARACTER is
		external
			"IL static signature (System.Int32): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_int16_string (value: STRING): INTEGER_16 is
		external
			"IL static signature (System.String): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_string_object_iformat_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_char_boolean (value: BOOLEAN): CHARACTER is
		external
			"IL static signature (System.Boolean): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_int16_char (value: CHARACTER): INTEGER_16 is
		external
			"IL static signature (System.Char): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_string_char (value: CHARACTER): STRING is
		external
			"IL static signature (System.Char): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_string_decimal_iformat_provider (value: SYSTEM_DECIMAL; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Decimal, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_byte_char (value: CHARACTER): INTEGER_8 is
		external
			"IL static signature (System.Char): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen to_string_byte_int32 (value: INTEGER_8; to_base: INTEGER): STRING is
		external
			"IL static signature (System.Byte, System.Int32): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_byte_string_iformat_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): INTEGER_8 is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen to_single_double (value: DOUBLE): REAL is
		external
			"IL static signature (System.Double): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen to_decimal_date_time (value: SYSTEM_DATETIME): SYSTEM_DECIMAL is
		external
			"IL static signature (System.DateTime): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen to_date_time_date_time (value: SYSTEM_DATETIME): SYSTEM_DATETIME is
		external
			"IL static signature (System.DateTime): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen to_boolean_boolean (value: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Boolean): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen to_int16_int32 (value: INTEGER): INTEGER_16 is
		external
			"IL static signature (System.Int32): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_char_int16 (value: INTEGER_16): CHARACTER is
		external
			"IL static signature (System.Int16): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_char (value: REAL): CHARACTER is
		external
			"IL static signature (System.Single): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_double_char (value: CHARACTER): DOUBLE is
		external
			"IL static signature (System.Char): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen to_int32_single (value: REAL): INTEGER is
		external
			"IL static signature (System.Single): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen to_boolean_double (value: DOUBLE): BOOLEAN is
		external
			"IL static signature (System.Double): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen to_decimal_object_iformat_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen to_decimal (value: STRING): SYSTEM_DECIMAL is
		external
			"IL static signature (System.String): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen is_dbnull (value: ANY): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Convert"
		alias
			"IsDBNull"
		end

	frozen to_date_time_string (value: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen change_type_object_type_iformat_provider (value: ANY; conversion_type: SYSTEM_TYPE; provider: SYSTEM_IFORMATPROVIDER): ANY is
		external
			"IL static signature (System.Object, System.Type, System.IFormatProvider): System.Object use System.Convert"
		alias
			"ChangeType"
		end

	frozen to_string_string_iformat_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.String, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_byte_string (value: STRING): INTEGER_8 is
		external
			"IL static signature (System.String): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen to_int16_int64 (value: INTEGER_64): INTEGER_16 is
		external
			"IL static signature (System.Int64): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_int64_date_time (value: SYSTEM_DATETIME): INTEGER_64 is
		external
			"IL static signature (System.DateTime): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_int32_string (value: STRING): INTEGER is
		external
			"IL static signature (System.String): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen to_date_time_double (value: DOUBLE): SYSTEM_DATETIME is
		external
			"IL static signature (System.Double): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen to_int32_string_int32 (value: STRING; from_base: INTEGER): INTEGER is
		external
			"IL static signature (System.String, System.Int32): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen to_date_time_object_iformat_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): SYSTEM_DATETIME is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen to_string_int64_int32 (value: INTEGER_64; to_base: INTEGER): STRING is
		external
			"IL static signature (System.Int64, System.Int32): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_int16_decimal (value: SYSTEM_DECIMAL): INTEGER_16 is
		external
			"IL static signature (System.Decimal): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_decimal_char (value: CHARACTER): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Char): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen to_boolean_char (value: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen to_int16_int16 (value: INTEGER_16): INTEGER_16 is
		external
			"IL static signature (System.Int16): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_string_boolean_iformat_provider (value: BOOLEAN; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Boolean, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_single_char (value: CHARACTER): REAL is
		external
			"IL static signature (System.Char): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen to_double_object_iformat_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): DOUBLE is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen to_double_double (value: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen to_char_object_iformat_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): CHARACTER is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_byte_single (value: REAL): INTEGER_8 is
		external
			"IL static signature (System.Single): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen to_int64_decimal (value: SYSTEM_DECIMAL): INTEGER_64 is
		external
			"IL static signature (System.Decimal): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_int32_char (value: CHARACTER): INTEGER is
		external
			"IL static signature (System.Char): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen change_type (value: ANY; conversion_type: SYSTEM_TYPE): ANY is
		external
			"IL static signature (System.Object, System.Type): System.Object use System.Convert"
		alias
			"ChangeType"
		end

	frozen to_byte_object (value: ANY): INTEGER_8 is
		external
			"IL static signature (System.Object): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen to_date_time_int64 (value: INTEGER_64): SYSTEM_DATETIME is
		external
			"IL static signature (System.Int64): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen to_single_byte (value: INTEGER_8): REAL is
		external
			"IL static signature (System.Byte): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen to_date_time_char (value: CHARACTER): SYSTEM_DATETIME is
		external
			"IL static signature (System.Char): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen to_double_boolean (value: BOOLEAN): DOUBLE is
		external
			"IL static signature (System.Boolean): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen to_decimal_single (value: REAL): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Single): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen to_char_int64 (value: INTEGER_64): CHARACTER is
		external
			"IL static signature (System.Int64): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_base64_string_array_byte_int32 (in_array: ARRAY [INTEGER_8]; offset: INTEGER; length: INTEGER): STRING is
		external
			"IL static signature (System.Byte[], System.Int32, System.Int32): System.String use System.Convert"
		alias
			"ToBase64String"
		end

	frozen to_int32_byte (value: INTEGER_8): INTEGER is
		external
			"IL static signature (System.Byte): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen to_char_decimal (value: SYSTEM_DECIMAL): CHARACTER is
		external
			"IL static signature (System.Decimal): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_double_string (value: STRING): DOUBLE is
		external
			"IL static signature (System.String): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen to_int16_object (value: ANY): INTEGER_16 is
		external
			"IL static signature (System.Object): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_char_object (value: ANY): CHARACTER is
		external
			"IL static signature (System.Object): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_int64_int64 (value: INTEGER_64): INTEGER_64 is
		external
			"IL static signature (System.Int64): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_int64_byte (value: INTEGER_8): INTEGER_64 is
		external
			"IL static signature (System.Byte): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_decimal_int16 (value: INTEGER_16): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Int16): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen to_int64_string_int32 (value: STRING; from_base: INTEGER): INTEGER_64 is
		external
			"IL static signature (System.String, System.Int32): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_byte (value: DOUBLE): INTEGER_8 is
		external
			"IL static signature (System.Double): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen to_date_time_single (value: REAL): SYSTEM_DATETIME is
		external
			"IL static signature (System.Single): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen to_string_single_iformat_provider (value: REAL; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Single, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_decimal_double (value: DOUBLE): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Double): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen to_int64_single (value: REAL): INTEGER_64 is
		external
			"IL static signature (System.Single): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_string_int16_iformat_provider (value: INTEGER_16; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Int16, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_int64_int16 (value: INTEGER_16): INTEGER_64 is
		external
			"IL static signature (System.Int16): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_double_string_iformat_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): DOUBLE is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen to_string_int16 (value: INTEGER_16): STRING is
		external
			"IL static signature (System.Int16): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_int16_object_iformat_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): INTEGER_16 is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen from_base64_char_array (in_array: ARRAY [CHARACTER]; offset: INTEGER; length: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Char[], System.Int32, System.Int32): System.Byte[] use System.Convert"
		alias
			"FromBase64CharArray"
		end

	frozen to_single (value: SYSTEM_DECIMAL): REAL is
		external
			"IL static signature (System.Decimal): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen to_string_single (value: REAL): STRING is
		external
			"IL static signature (System.Single): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_int32_decimal (value: SYSTEM_DECIMAL): INTEGER is
		external
			"IL static signature (System.Decimal): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen to_string_decimal (value: SYSTEM_DECIMAL): STRING is
		external
			"IL static signature (System.Decimal): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_boolean_int32 (value: INTEGER): BOOLEAN is
		external
			"IL static signature (System.Int32): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen to_date_time_int16 (value: INTEGER_16): SYSTEM_DATETIME is
		external
			"IL static signature (System.Int16): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen to_double (value: SYSTEM_DECIMAL): DOUBLE is
		external
			"IL static signature (System.Decimal): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen to_int32_boolean (value: BOOLEAN): INTEGER is
		external
			"IL static signature (System.Boolean): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen to_decimal_int32 (value: INTEGER): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Int32): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen to_byte_string_int32 (value: STRING; from_base: INTEGER): INTEGER_8 is
		external
			"IL static signature (System.String, System.Int32): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen to_decimal_object (value: ANY): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Object): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen to_date_time_decimal (value: SYSTEM_DECIMAL): SYSTEM_DATETIME is
		external
			"IL static signature (System.Decimal): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen to_int16_date_time (value: SYSTEM_DATETIME): INTEGER_16 is
		external
			"IL static signature (System.DateTime): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_boolean_byte (value: INTEGER_8): BOOLEAN is
		external
			"IL static signature (System.Byte): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen to_single_object (value: ANY): REAL is
		external
			"IL static signature (System.Object): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen to_double_byte (value: INTEGER_8): DOUBLE is
		external
			"IL static signature (System.Byte): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen to_string_boolean (value: BOOLEAN): STRING is
		external
			"IL static signature (System.Boolean): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_decimal_boolean (value: BOOLEAN): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Boolean): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen to_string_int32_int32 (value: INTEGER; to_base: INTEGER): STRING is
		external
			"IL static signature (System.Int32, System.Int32): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_string_int32 (value: INTEGER): STRING is
		external
			"IL static signature (System.Int32): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_string_double_iformat_provider (value: DOUBLE; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Double, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_boolean_string (value: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen to_string_char_iformat_provider (value: CHARACTER; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Char, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_single_boolean (value: BOOLEAN): REAL is
		external
			"IL static signature (System.Boolean): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen to_char_byte (value: INTEGER_8): CHARACTER is
		external
			"IL static signature (System.Byte): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_string_byte_iformat_provider (value: INTEGER_8; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Byte, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_int64_string_iformat_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): INTEGER_64 is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_double_int64 (value: INTEGER_64): DOUBLE is
		external
			"IL static signature (System.Int64): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen to_boolean_int16 (value: INTEGER_16): BOOLEAN is
		external
			"IL static signature (System.Int16): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen to_byte_int16 (value: INTEGER_16): INTEGER_8 is
		external
			"IL static signature (System.Int16): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen to_single_date_time (value: SYSTEM_DATETIME): REAL is
		external
			"IL static signature (System.DateTime): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen to_base64_char_array (in_array: ARRAY [INTEGER_8]; offset_in: INTEGER; length: INTEGER; out_array: ARRAY [CHARACTER]; offset_out: INTEGER): INTEGER is
		external
			"IL static signature (System.Byte[], System.Int32, System.Int32, System.Char[], System.Int32): System.Int32 use System.Convert"
		alias
			"ToBase64CharArray"
		end

	frozen to_int64_object_iformat_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): INTEGER_64 is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_byte_byte (value: INTEGER_8): INTEGER_8 is
		external
			"IL static signature (System.Byte): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen to_int16_byte (value: INTEGER_8): INTEGER_16 is
		external
			"IL static signature (System.Byte): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_date_time_int32 (value: INTEGER): SYSTEM_DATETIME is
		external
			"IL static signature (System.Int32): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen to_double_date_time (value: SYSTEM_DATETIME): DOUBLE is
		external
			"IL static signature (System.DateTime): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen to_string_int64_iformat_provider (value: INTEGER_64; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.Int64, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen to_int64_char (value: CHARACTER): INTEGER_64 is
		external
			"IL static signature (System.Char): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_char_string (value: STRING): CHARACTER is
		external
			"IL static signature (System.String): System.Char use System.Convert"
		alias
			"ToChar"
		end

	frozen to_boolean_int64 (value: INTEGER_64): BOOLEAN is
		external
			"IL static signature (System.Int64): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen to_date_time_string_iformat_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): SYSTEM_DATETIME is
		external
			"IL static signature (System.String, System.IFormatProvider): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen to_int64_boolean (value: BOOLEAN): INTEGER_64 is
		external
			"IL static signature (System.Boolean): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_single_int64 (value: INTEGER_64): REAL is
		external
			"IL static signature (System.Int64): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen to_single_string_iformat_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): REAL is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen to_date_time (value: BOOLEAN): SYSTEM_DATETIME is
		external
			"IL static signature (System.Boolean): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen to_decimal_int64 (value: INTEGER_64): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Int64): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen to_decimal_byte (value: INTEGER_8): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Byte): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen to_byte_int32 (value: INTEGER): INTEGER_8 is
		external
			"IL static signature (System.Int32): System.Byte use System.Convert"
		alias
			"ToByte"
		end

	frozen to_int16_string_iformat_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): INTEGER_16 is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_int32_int16 (value: INTEGER_16): INTEGER is
		external
			"IL static signature (System.Int16): System.Int32 use System.Convert"
		alias
			"ToInt32"
		end

	frozen to_boolean_decimal (value: SYSTEM_DECIMAL): BOOLEAN is
		external
			"IL static signature (System.Decimal): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen to_int64_object (value: ANY): INTEGER_64 is
		external
			"IL static signature (System.Object): System.Int64 use System.Convert"
		alias
			"ToInt64"
		end

	frozen to_boolean_object (value: ANY): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen to_boolean_date_time (value: SYSTEM_DATETIME): BOOLEAN is
		external
			"IL static signature (System.DateTime): System.Boolean use System.Convert"
		alias
			"ToBoolean"
		end

	frozen to_double_object (value: ANY): DOUBLE is
		external
			"IL static signature (System.Object): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen to_single_string (value: STRING): REAL is
		external
			"IL static signature (System.String): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen to_date_time_byte (value: INTEGER_8): SYSTEM_DATETIME is
		external
			"IL static signature (System.Byte): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen to_date_time_object (value: ANY): SYSTEM_DATETIME is
		external
			"IL static signature (System.Object): System.DateTime use System.Convert"
		alias
			"ToDateTime"
		end

	frozen get_type_code (value: ANY): SYSTEM_TYPECODE is
		external
			"IL static signature (System.Object): System.TypeCode use System.Convert"
		alias
			"GetTypeCode"
		end

	frozen to_double_single (value: REAL): DOUBLE is
		external
			"IL static signature (System.Single): System.Double use System.Convert"
		alias
			"ToDouble"
		end

	frozen to_int16 (value: DOUBLE): INTEGER_16 is
		external
			"IL static signature (System.Double): System.Int16 use System.Convert"
		alias
			"ToInt16"
		end

	frozen to_decimal_string_iformat_provider (value: STRING; provider: SYSTEM_IFORMATPROVIDER): SYSTEM_DECIMAL is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Decimal use System.Convert"
		alias
			"ToDecimal"
		end

	frozen to_single_object_iformat_provider (value: ANY; provider: SYSTEM_IFORMATPROVIDER): REAL is
		external
			"IL static signature (System.Object, System.IFormatProvider): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen to_single_int16 (value: INTEGER_16): REAL is
		external
			"IL static signature (System.Int16): System.Single use System.Convert"
		alias
			"ToSingle"
		end

	frozen to_string_date_time_iformat_provider (value: SYSTEM_DATETIME; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL static signature (System.DateTime, System.IFormatProvider): System.String use System.Convert"
		alias
			"ToString"
		end

	frozen change_type_object_type_code_iformat_provider (value: ANY; type_code: SYSTEM_TYPECODE; provider: SYSTEM_IFORMATPROVIDER): ANY is
		external
			"IL static signature (System.Object, System.TypeCode, System.IFormatProvider): System.Object use System.Convert"
		alias
			"ChangeType"
		end

	frozen to_base64_string (in_array: ARRAY [INTEGER_8]): STRING is
		external
			"IL static signature (System.Byte[]): System.String use System.Convert"
		alias
			"ToBase64String"
		end

end -- class SYSTEM_CONVERT
