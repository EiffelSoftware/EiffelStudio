indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.FormatterConverter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	FORMATTER_CONVERTER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.FormatterConverter"
		end

feature -- Basic Operations

	frozen to_int32 (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToInt32"
		end

	frozen to_boolean (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToBoolean"
		end

	frozen to_int16 (value: SYSTEM_OBJECT): INTEGER_16 is
		external
			"IL signature (System.Object): System.Int16 use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToInt16"
		end

	frozen convert_object_type_code (value: SYSTEM_OBJECT; type_code: TYPE_CODE): SYSTEM_OBJECT is
		external
			"IL signature (System.Object, System.TypeCode): System.Object use System.Runtime.Serialization.FormatterConverter"
		alias
			"Convert"
		end

	frozen to_double (value: SYSTEM_OBJECT): DOUBLE is
		external
			"IL signature (System.Object): System.Double use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToDouble"
		end

	frozen convert (value: SYSTEM_OBJECT; type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Object, System.Type): System.Object use System.Runtime.Serialization.FormatterConverter"
		alias
			"Convert"
		end

	frozen to_string_object (value: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.Object): System.String use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToString"
		end

	frozen to_date_time (value: SYSTEM_OBJECT): SYSTEM_DATE_TIME is
		external
			"IL signature (System.Object): System.DateTime use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToDateTime"
		end

	frozen to_byte (value: SYSTEM_OBJECT): INTEGER_8 is
		external
			"IL signature (System.Object): System.Byte use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToByte"
		end

	frozen to_char (value: SYSTEM_OBJECT): CHARACTER is
		external
			"IL signature (System.Object): System.Char use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToChar"
		end

	frozen to_int64 (value: SYSTEM_OBJECT): INTEGER_64 is
		external
			"IL signature (System.Object): System.Int64 use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToInt64"
		end

	frozen to_decimal (value: SYSTEM_OBJECT): DECIMAL is
		external
			"IL signature (System.Object): System.Decimal use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToDecimal"
		end

	frozen to_single (value: SYSTEM_OBJECT): REAL is
		external
			"IL signature (System.Object): System.Single use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToSingle"
		end

end -- class FORMATTER_CONVERTER
