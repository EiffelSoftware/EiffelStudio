indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlConvert"

external class
	SYSTEM_XML_XMLCONVERT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.XmlConvert"
		end

feature -- Basic Operations

	frozen to_string_int32 (value: INTEGER): STRING is
		external
			"IL static signature (System.Int32): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen encode_nm_token (name: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.XmlConvert"
		alias
			"EncodeNmToken"
		end

	frozen to_double (s: STRING): DOUBLE is
		external
			"IL static signature (System.String): System.Double use System.Xml.XmlConvert"
		alias
			"ToDouble"
		end

	frozen to_date_time_string_array_string (s: STRING; formats: ARRAY [STRING]): SYSTEM_DATETIME is
		external
			"IL static signature (System.String, System.String[]): System.DateTime use System.Xml.XmlConvert"
		alias
			"ToDateTime"
		end

	frozen to_boolean (s: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Xml.XmlConvert"
		alias
			"ToBoolean"
		end

	frozen to_string_int64 (value: INTEGER_64): STRING is
		external
			"IL static signature (System.Int64): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_byte (s: STRING): INTEGER_8 is
		external
			"IL static signature (System.String): System.Byte use System.Xml.XmlConvert"
		alias
			"ToByte"
		end

	frozen to_int64 (s: STRING): INTEGER_64 is
		external
			"IL static signature (System.String): System.Int64 use System.Xml.XmlConvert"
		alias
			"ToInt64"
		end

	frozen encode_name (name: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.XmlConvert"
		alias
			"EncodeName"
		end

	frozen to_guid (s: STRING): SYSTEM_GUID is
		external
			"IL static signature (System.String): System.Guid use System.Xml.XmlConvert"
		alias
			"ToGuid"
		end

	frozen to_time_span (s: STRING): SYSTEM_TIMESPAN is
		external
			"IL static signature (System.String): System.TimeSpan use System.Xml.XmlConvert"
		alias
			"ToTimeSpan"
		end

	frozen to_single (s: STRING): REAL is
		external
			"IL static signature (System.String): System.Single use System.Xml.XmlConvert"
		alias
			"ToSingle"
		end

	frozen to_string_byte (value: INTEGER_8): STRING is
		external
			"IL static signature (System.Byte): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_string_double (value: DOUBLE): STRING is
		external
			"IL static signature (System.Double): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_string_date_time_string (value: SYSTEM_DATETIME; format: STRING): STRING is
		external
			"IL static signature (System.DateTime, System.String): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen decode_name (name: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.XmlConvert"
		alias
			"DecodeName"
		end

	frozen to_int32 (s: STRING): INTEGER is
		external
			"IL static signature (System.String): System.Int32 use System.Xml.XmlConvert"
		alias
			"ToInt32"
		end

	frozen to_string_date_time (value: SYSTEM_DATETIME): STRING is
		external
			"IL static signature (System.DateTime): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_string_single (value: REAL): STRING is
		external
			"IL static signature (System.Single): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_string_boolean (value: BOOLEAN): STRING is
		external
			"IL static signature (System.Boolean): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_decimal (s: STRING): SYSTEM_DECIMAL is
		external
			"IL static signature (System.String): System.Decimal use System.Xml.XmlConvert"
		alias
			"ToDecimal"
		end

	frozen to_date_time_string_string (s: STRING; format: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String, System.String): System.DateTime use System.Xml.XmlConvert"
		alias
			"ToDateTime"
		end

	frozen to_string_decimal (value: SYSTEM_DECIMAL): STRING is
		external
			"IL static signature (System.Decimal): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen encode_local_name (name: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.XmlConvert"
		alias
			"EncodeLocalName"
		end

	frozen to_string_time_span (value: SYSTEM_TIMESPAN): STRING is
		external
			"IL static signature (System.TimeSpan): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_date_time (s: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.Xml.XmlConvert"
		alias
			"ToDateTime"
		end

	frozen to_int16 (s: STRING): INTEGER_16 is
		external
			"IL static signature (System.String): System.Int16 use System.Xml.XmlConvert"
		alias
			"ToInt16"
		end

	frozen to_string_int16 (value: INTEGER_16): STRING is
		external
			"IL static signature (System.Int16): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_string_guid (value: SYSTEM_GUID): STRING is
		external
			"IL static signature (System.Guid): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_string_char (value: CHARACTER): STRING is
		external
			"IL static signature (System.Char): System.String use System.Xml.XmlConvert"
		alias
			"ToString"
		end

	frozen to_char (s: STRING): CHARACTER is
		external
			"IL static signature (System.String): System.Char use System.Xml.XmlConvert"
		alias
			"ToChar"
		end

end -- class SYSTEM_XML_XMLCONVERT
