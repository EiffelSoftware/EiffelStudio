indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Char"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	CHARACTER

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end
	ICOMPARABLE
		
	CHARACTER_REF
		redefine
			get_hash_code,
			equals,
			to_string
		end

create {NONE}

feature -- Access

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Char"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Char"
		alias
			"ToString"
		end

	frozen is_lower_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsLower"
		end

	frozen is_letter_or_digit_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsLetterOrDigit"
		end

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.Char"
		alias
			"ToString"
		end

	frozen is_symbol_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsSymbol"
		end

	frozen is_upper_char (c: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsUpper"
		end

	frozen to_upper (c: CHARACTER): CHARACTER is
		external
			"IL static signature (System.Char): System.Char use System.Char"
		alias
			"ToUpper"
		end

	frozen parse (s: SYSTEM_STRING): CHARACTER is
		external
			"IL static signature (System.String): System.Char use System.Char"
		alias
			"Parse"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Char"
		alias
			"Equals"
		end

	frozen is_separator_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsSeparator"
		end

	frozen is_white_space (c: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsWhiteSpace"
		end

	frozen is_punctuation_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsPunctuation"
		end

	frozen to_upper_char_culture_info (c: CHARACTER; culture: CULTURE_INFO): CHARACTER is
		external
			"IL static signature (System.Char, System.Globalization.CultureInfo): System.Char use System.Char"
		alias
			"ToUpper"
		end

	frozen is_symbol (c: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsSymbol"
		end

	frozen to_lower (c: CHARACTER): CHARACTER is
		external
			"IL static signature (System.Char): System.Char use System.Char"
		alias
			"ToLower"
		end

	frozen is_letter_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsLetter"
		end

	frozen is_digit_char (c: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsDigit"
		end

	frozen is_separator (c: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsSeparator"
		end

	frozen is_letter (c: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsLetter"
		end

	frozen is_upper_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsUpper"
		end

	frozen is_punctuation (c: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsPunctuation"
		end

	frozen is_white_space_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsWhiteSpace"
		end

	frozen get_numeric_value_string (s: SYSTEM_STRING; index: INTEGER): DOUBLE is
		external
			"IL static signature (System.String, System.Int32): System.Double use System.Char"
		alias
			"GetNumericValue"
		end

	frozen to_lower_char_culture_info (c: CHARACTER; culture: CULTURE_INFO): CHARACTER is
		external
			"IL static signature (System.Char, System.Globalization.CultureInfo): System.Char use System.Char"
		alias
			"ToLower"
		end

	frozen get_numeric_value (c: CHARACTER): DOUBLE is
		external
			"IL static signature (System.Char): System.Double use System.Char"
		alias
			"GetNumericValue"
		end

	frozen is_surrogate (c: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsSurrogate"
		end

	frozen get_unicode_category (c: CHARACTER): UNICODE_CATEGORY is
		external
			"IL static signature (System.Char): System.Globalization.UnicodeCategory use System.Char"
		alias
			"GetUnicodeCategory"
		end

	frozen is_number_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsNumber"
		end

	frozen get_type_code: TYPE_CODE is
		external
			"IL signature (): System.TypeCode use System.Char"
		alias
			"GetTypeCode"
		end

	frozen is_letter_or_digit (c: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsLetterOrDigit"
		end

	frozen to_string_char (c: CHARACTER): SYSTEM_STRING is
		external
			"IL static signature (System.Char): System.String use System.Char"
		alias
			"ToString"
		end

	frozen is_number (c: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsNumber"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Char"
		alias
			"CompareTo"
		end

	frozen get_unicode_category_string (s: SYSTEM_STRING; index: INTEGER): UNICODE_CATEGORY is
		external
			"IL static signature (System.String, System.Int32): System.Globalization.UnicodeCategory use System.Char"
		alias
			"GetUnicodeCategory"
		end

	frozen is_lower_char (c: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsLower"
		end

	frozen is_control_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsControl"
		end

	frozen is_surrogate_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsSurrogate"
		end

	frozen is_control (c: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsControl"
		end

	frozen is_digit_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsDigit"
		end

end -- class CHARACTER
