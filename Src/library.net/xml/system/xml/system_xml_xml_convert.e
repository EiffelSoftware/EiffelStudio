indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlConvert"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_CONVERT

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.XmlConvert"
		end

feature -- Basic Operations

	frozen encode_nm_token (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.XmlConvert"
		alias
			"EncodeNmToken"
		end

	frozen to_double (s: SYSTEM_STRING): DOUBLE is
		external
			"IL static signature (System.String): System.Double use System.Xml.XmlConvert"
		alias
			"ToDouble"
		end

	frozen to_date_time_string_string (s: SYSTEM_STRING; format: SYSTEM_STRING): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.String, System.String): System.DateTime use System.Xml.XmlConvert"
		alias
			"ToDateTime"
		end

	frozen to_boolean (s: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Xml.XmlConvert"
		alias
			"ToBoolean"
		end

	frozen to_string_int64 (value: INTEGER_64): SYSTEM_STRING is
		external
			"IL static signature (System.Int64): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_byte (s: SYSTEM_STRING): INTEGER_8 is
		external
			"IL static signature (System.String): System.Byte use System.Xml.XmlConvert"
		alias
			"ToByte"
		end

	frozen to_int32 (s: SYSTEM_STRING): INTEGER is
		external
			"IL static signature (System.String): System.Int32 use System.Xml.XmlConvert"
		alias
			"ToInt32"
		end

	frozen to_int64 (s: SYSTEM_STRING): INTEGER_64 is
		external
			"IL static signature (System.String): System.Int64 use System.Xml.XmlConvert"
		alias
			"ToInt64"
		end

	frozen encode_name (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.XmlConvert"
		alias
			"EncodeName"
		end

	frozen to_guid (s: SYSTEM_STRING): GUID is
		external
			"IL static signature (System.String): System.Guid use System.Xml.XmlConvert"
		alias
			"ToGuid"
		end

	frozen to_date_time_string_array_string (s: SYSTEM_STRING; formats: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.String, System.String[]): System.DateTime use System.Xml.XmlConvert"
		alias
			"ToDateTime"
		end

	frozen to_time_span (s: SYSTEM_STRING): TIME_SPAN is
		external
			"IL static signature (System.String): System.TimeSpan use System.Xml.XmlConvert"
		alias
			"ToTimeSpan"
		end

	frozen to_single (s: SYSTEM_STRING): REAL is
		external
			"IL static signature (System.String): System.Single use System.Xml.XmlConvert"
		alias
			"ToSingle"
		end

	frozen to_string_byte (value: INTEGER_8): SYSTEM_STRING is
		external
			"IL static signature (System.Byte): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_string_double (value: DOUBLE): SYSTEM_STRING is
		external
			"IL static signature (System.Double): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_string_date_time_string (value: SYSTEM_DATE_TIME; format: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.DateTime, System.String): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen decode_name (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.XmlConvert"
		alias
			"DecodeName"
		end

	frozen verify_name (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.XmlConvert"
		alias
			"VerifyName"
		end

	frozen to_string_int32 (value: INTEGER): SYSTEM_STRING is
		external
			"IL static signature (System.Int32): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_string_single (value: REAL): SYSTEM_STRING is
		external
			"IL static signature (System.Single): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_string_boolean (value: BOOLEAN): SYSTEM_STRING is
		external
			"IL static signature (System.Boolean): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_decimal (s: SYSTEM_STRING): DECIMAL is
		external
			"IL static signature (System.String): System.Decimal use System.Xml.XmlConvert"
		alias
			"ToDecimal"
		end

	frozen to_string_date_time (value: SYSTEM_DATE_TIME): SYSTEM_STRING is
		external
			"IL static signature (System.DateTime): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_string_decimal (value: DECIMAL): SYSTEM_STRING is
		external
			"IL static signature (System.Decimal): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen encode_local_name (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.XmlConvert"
		alias
			"EncodeLocalName"
		end

	frozen to_string_time_span (value: TIME_SPAN): SYSTEM_STRING is
		external
			"IL static signature (System.TimeSpan): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_date_time (s: SYSTEM_STRING): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.String): System.DateTime use System.Xml.XmlConvert"
		alias
			"ToDateTime"
		end

	frozen to_int16 (s: SYSTEM_STRING): INTEGER_16 is
		external
			"IL static signature (System.String): System.Int16 use System.Xml.XmlConvert"
		alias
			"ToInt16"
		end

	frozen to_string_int16 (value: INTEGER_16): SYSTEM_STRING is
		external
			"IL static signature (System.Int16): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_string_guid (value: GUID): SYSTEM_STRING is
		external
			"IL static signature (System.Guid): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_string_char (value: CHARACTER): SYSTEM_STRING is
		external
			"IL static signature (System.Char): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen verify_ncname (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.XmlConvert"
		alias
			"VerifyNCName"
		end

	frozen to_char (s: SYSTEM_STRING): CHARACTER is
		external
			"IL static signature (System.String): System.Char use System.Xml.XmlConvert"
		alias
			"ToChar"
		end

end -- class SYSTEM_XML_XML_CONVERT
