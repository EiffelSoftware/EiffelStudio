indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Single"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	REAL

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end
	ICOMPARABLE
	IFORMATTABLE

	REAL_REF
		redefine
			get_hash_code,
			equals,
			to_string
		end
	
create {NONE}

feature -- Access

	frozen min_value: REAL is -3.402823E+38

	frozen epsilon: REAL is 1.401298E-45

	frozen max_value: REAL is 3.402823E+38

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Single"
		alias
			"ToString"
		end

	frozen get_type_code: TYPE_CODE is
		external
			"IL signature (): System.TypeCode use System.Single"
		alias
			"GetTypeCode"
		end

	frozen is_negative_infinity (f: REAL): BOOLEAN is
		external
			"IL static signature (System.Single): System.Boolean use System.Single"
		alias
			"IsNegativeInfinity"
		end

	frozen parse_string_iformat_provider (s: SYSTEM_STRING; provider: IFORMAT_PROVIDER): REAL is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Single use System.Single"
		alias
			"Parse"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Single"
		alias
			"GetHashCode"
		end

	frozen is_infinity (f: REAL): BOOLEAN is
		external
			"IL static signature (System.Single): System.Boolean use System.Single"
		alias
			"IsInfinity"
		end

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.Single"
		alias
			"ToString"
		end

	frozen is_na_n (f: REAL): BOOLEAN is
		external
			"IL static signature (System.Single): System.Boolean use System.Single"
		alias
			"IsNaN"
		end

	frozen parse_string_number_styles (s: SYSTEM_STRING; style: NUMBER_STYLES): REAL is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Single use System.Single"
		alias
			"Parse"
		end

	frozen to_string_string2 (format: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Single"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Single"
		alias
			"Equals"
		end

	frozen parse_string_number_styles_iformat_provider (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER): REAL is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Single use System.Single"
		alias
			"Parse"
		end

	frozen is_positive_infinity (f: REAL): BOOLEAN is
		external
			"IL static signature (System.Single): System.Boolean use System.Single"
		alias
			"IsPositiveInfinity"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Single"
		alias
			"CompareTo"
		end

	frozen parse (s: SYSTEM_STRING): REAL is
		external
			"IL static signature (System.String): System.Single use System.Single"
		alias
			"Parse"
		end

	frozen to_string_string (format: SYSTEM_STRING; provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Single"
		alias
			"ToString"
		end

end -- class REAL
