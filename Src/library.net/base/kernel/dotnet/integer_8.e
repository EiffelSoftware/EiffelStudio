indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Byte"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	INTEGER_8

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end
	ICOMPARABLE
	IFORMATTABLE

	INTEGER_8_REF
		redefine
			get_hash_code,
			equals,
			to_string
		end

create {NONE}

feature -- Access

	frozen min_value: INTEGER_8 is 0x80

	frozen max_value: INTEGER_8 is 0x7f

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Byte"
		alias
			"ToString"
		end

	frozen get_type_code: TYPE_CODE is
		external
			"IL signature (): System.TypeCode use System.Byte"
		alias
			"GetTypeCode"
		end

	frozen to_string_string2 (format: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Byte"
		alias
			"ToString"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Byte"
		alias
			"GetHashCode"
		end

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.Byte"
		alias
			"ToString"
		end

	frozen parse_string_number_styles (s: SYSTEM_STRING; style: NUMBER_STYLES): INTEGER_8 is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Byte use System.Byte"
		alias
			"Parse"
		end

	frozen parse_string_iformat_provider (s: SYSTEM_STRING; provider: IFORMAT_PROVIDER): INTEGER_8 is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Byte use System.Byte"
		alias
			"Parse"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Byte"
		alias
			"Equals"
		end

	frozen parse_string_number_styles_iformat_provider (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER): INTEGER_8 is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Byte use System.Byte"
		alias
			"Parse"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Byte"
		alias
			"CompareTo"
		end

	frozen parse (s: SYSTEM_STRING): INTEGER_8 is
		external
			"IL static signature (System.String): System.Byte use System.Byte"
		alias
			"Parse"
		end

	frozen to_string_string (format: SYSTEM_STRING; provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Byte"
		alias
			"ToString"
		end

end -- class INTEGER_8
