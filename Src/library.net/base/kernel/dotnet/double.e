indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Double"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DOUBLE

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end
	ICOMPARABLE
	IFORMATTABLE

	DOUBLE_REF
		redefine
			get_hash_code,
			equals,
			to_string
		end

create {NONE}

feature -- Access

	frozen min_value: DOUBLE is -1.79769313486232E+308

	frozen max_value: DOUBLE is 1.79769313486232E+308

	frozen epsilon: DOUBLE is 4.94065645841247E-324

feature -- Basic Operations

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Double"
		alias
			"Equals"
		end

	frozen parse_string_number_styles (s: SYSTEM_STRING; style: NUMBER_STYLES): DOUBLE is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Double use System.Double"
		alias
			"Parse"
		end

	frozen is_infinity (d: DOUBLE): BOOLEAN is
		external
			"IL static signature (System.Double): System.Boolean use System.Double"
		alias
			"IsInfinity"
		end

	frozen try_parse (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER; result_: DOUBLE): BOOLEAN is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider, System.Double&): System.Boolean use System.Double"
		alias
			"TryParse"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Double"
		alias
			"GetHashCode"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Double"
		alias
			"CompareTo"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Double"
		alias
			"ToString"
		end

	frozen is_na_n (d: DOUBLE): BOOLEAN is
		external
			"IL static signature (System.Double): System.Boolean use System.Double"
		alias
			"IsNaN"
		end

	frozen is_negative_infinity (d: DOUBLE): BOOLEAN is
		external
			"IL static signature (System.Double): System.Boolean use System.Double"
		alias
			"IsNegativeInfinity"
		end

	frozen to_string_string2 (format: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Double"
		alias
			"ToString"
		end

	frozen is_positive_infinity (d: DOUBLE): BOOLEAN is
		external
			"IL static signature (System.Double): System.Boolean use System.Double"
		alias
			"IsPositiveInfinity"
		end

	frozen get_type_code: TYPE_CODE is
		external
			"IL signature (): System.TypeCode use System.Double"
		alias
			"GetTypeCode"
		end

	frozen parse_string_iformat_provider (s: SYSTEM_STRING; provider: IFORMAT_PROVIDER): DOUBLE is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Double use System.Double"
		alias
			"Parse"
		end

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.Double"
		alias
			"ToString"
		end

	frozen to_string_string (format: SYSTEM_STRING; provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Double"
		alias
			"ToString"
		end

	frozen parse (s: SYSTEM_STRING): DOUBLE is
		external
			"IL static signature (System.String): System.Double use System.Double"
		alias
			"Parse"
		end

	frozen parse_string_number_styles_iformat_provider (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER): DOUBLE is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Double use System.Double"
		alias
			"Parse"
		end

end -- class DOUBLE
