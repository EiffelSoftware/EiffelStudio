indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Int16"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	INTEGER_16

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end
	ICOMPARABLE
	IFORMATTABLE

	INTEGER_16_REF
		redefine
			get_hash_code,
			equals,
			to_string
		end

create {NONE}

feature -- Access

	frozen min_value: INTEGER_16 is 0x8000

	frozen max_value: INTEGER_16 is 0x7fff

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Int16"
		alias
			"ToString"
		end

	frozen get_type_code: TYPE_CODE is
		external
			"IL signature (): System.TypeCode use System.Int16"
		alias
			"GetTypeCode"
		end

	frozen parse_string_iformat_provider (s: SYSTEM_STRING; provider: IFORMAT_PROVIDER): INTEGER_16 is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Int16 use System.Int16"
		alias
			"Parse"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Int16"
		alias
			"GetHashCode"
		end

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.Int16"
		alias
			"ToString"
		end

	frozen parse_string_number_styles (s: SYSTEM_STRING; style: NUMBER_STYLES): INTEGER_16 is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Int16 use System.Int16"
		alias
			"Parse"
		end

	frozen to_string_string2 (format: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Int16"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Int16"
		alias
			"Equals"
		end

	frozen parse_string_number_styles_iformat_provider (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER): INTEGER_16 is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Int16 use System.Int16"
		alias
			"Parse"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Int16"
		alias
			"CompareTo"
		end

	frozen parse (s: SYSTEM_STRING): INTEGER_16 is
		external
			"IL static signature (System.String): System.Int16 use System.Int16"
		alias
			"Parse"
		end

	frozen to_string_string (format: SYSTEM_STRING; provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Int16"
		alias
			"ToString"
		end
	
end -- class INTEGER_16
