indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.FormatterConverter"

external class
	SYSTEM_RUNTIME_SERIALIZATION_FORMATTERCONVERTER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.FormatterConverter"
		end

feature -- Basic Operations

	frozen to_int32 (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToInt32"
		end

	frozen to_boolean (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToBoolean"
		end

	frozen to_int16 (value: ANY): INTEGER_16 is
		external
			"IL signature (System.Object): System.Int16 use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToInt16"
		end

	frozen convert_object_type_code (value: ANY; type_code: SYSTEM_TYPECODE): ANY is
		external
			"IL signature (System.Object, System.TypeCode): System.Object use System.Runtime.Serialization.FormatterConverter"
		alias
			"Convert"
		end

	frozen to_double (value: ANY): DOUBLE is
		external
			"IL signature (System.Object): System.Double use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToDouble"
		end

	frozen convert (value: ANY; type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Object, System.Type): System.Object use System.Runtime.Serialization.FormatterConverter"
		alias
			"Convert"
		end

	frozen to_string_object (value: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToString"
		end

	frozen to_date_time (value: ANY): SYSTEM_DATETIME is
		external
			"IL signature (System.Object): System.DateTime use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToDateTime"
		end

	frozen to_byte (value: ANY): INTEGER_8 is
		external
			"IL signature (System.Object): System.Byte use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToByte"
		end

	frozen to_char (value: ANY): CHARACTER is
		external
			"IL signature (System.Object): System.Char use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToChar"
		end

	frozen to_int64 (value: ANY): INTEGER_64 is
		external
			"IL signature (System.Object): System.Int64 use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToInt64"
		end

	frozen to_decimal (value: ANY): SYSTEM_DECIMAL is
		external
			"IL signature (System.Object): System.Decimal use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToDecimal"
		end

	frozen to_single (value: ANY): REAL is
		external
			"IL signature (System.Object): System.Single use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToSingle"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_FORMATTERCONVERTER
