indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Single"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	REAL

inherit
	VALUE_TYPE
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

	ICOMPARABLE
		undefine
			get_hash_code,
			equals,
			to_string
		end

	IFORMATTABLE
		undefine
			get_hash_code,
			equals,
			to_string
		end

	REAL_REF
	
create {NONE}

feature -- Access

	frozen min_value: REAL is -3.402823E+38

	frozen epsilon: REAL is 1.401298E-45

	frozen max_value: REAL is 3.402823E+38

	frozen type_code: TYPE_CODE is
			-- Returns the System.TypeCode for value type System.Int32.  
			--
			-- Returns:
			--   The enumerated constant, System.TypeCode.Int32.  
		external
			"IL signature (): System.TypeCode use System.Int32"
		alias
			"GetTypeCode"
		end

feature -- Status Report

	frozen is_infinity (f: REAL): BOOLEAN is
			-- (Static)
			-- Returns a value indicating whether the specified number
			-- evaluates to negative or positive infinity
			--
			-- Parameters:
			--   f: A single-precision floating point number.
			--
			-- Returns:
			--   true if f evaluates to System.Single.PositiveInfinity
			--   or System.Single.NegativeInfinity; otherwise, false.
		external
			"IL static signature (System.Single): System.Boolean use System.Single"
		alias
			"IsInfinity"
		end

	frozen is_positive_infinity (f: REAL): BOOLEAN is
			-- (Static)
			-- Returns a value indicating whether the specified number
			-- evaluates to positive infinity.
			--
			-- Parameters:
			--   f: A single-precision floating point number.
			--
			-- Returns:
			--   true if f evaluates to System.Single.PositiveInfinity;
			--   otherwise, false.
		external
			"IL static signature (System.Single): System.Boolean use System.Single"
		alias
			"IsPositiveInfinity"
		end

	frozen is_negative_infinity (f: REAL): BOOLEAN is
			-- (Static)
			-- Returns a value indicating whether the specified number
			-- evaluates to negative infinity.
			--
			-- Parameters:
			--   f: A single-precision floating point number.
			--
			-- Returns:
			--   true if f evaluates to System.Single.NegativeInfinity;
			--   otherwise, false.
		external
			"IL static signature (System.Single): System.Boolean use System.Single"
		alias
			"IsNegativeInfinity"
		end

	frozen is_nan (f: REAL): BOOLEAN is
			-- (Static)
			-- Returns a value indicating whether the specified number
			-- evaluates to not a number (System.Single.NaN).  
			--
			-- Parameters:
			--   f: A single-precision floating point number.
			--
			-- Returns:
			--   true if f evaluates to not a number (System.Single.NaN);
			--   otherwise, false.
		external
			"IL static signature (System.Single): System.Boolean use System.Single"
		alias
			"IsNaN"
		end

feature -- Conversion

	frozen from_string (s: SYSTEM_STRING): REAL is
			-- (Static)
			-- Converts the string representation of a number to its single-precision
			-- floating point number equivalent.
			--
			-- Parameters:
			--   s: A string representing a number to convert.
			--
			-- Returns:
			--   A single-precision floating point number equivalent to the numeric
			--   value or symbol specified in s.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.FormatException: s is not a number in a valid format.
			--   System.OverflowException: s represents a number less than
			--     System.Single.MinValue or greater than System.Single.MaxValue.
		external
			"IL static signature (System.String): System.Single use System.Single"
		alias
			"Parse"
		end

	frozen from_string_with_style (s: SYSTEM_STRING; style: NUMBER_STYLES): REAL is
			-- (Static)
			-- Converts the string representation of a number in a specified style to
			-- its single-precision floating point number equivalent.  
			--
			-- Parameters:
			--   s: A string representing a number to convert.
			--   style: The combination of one or more
			--     System.Globalization.NumberStylesconstants that indicate the
			--     permitted format of s.
			--
			-- Returns:
			--   A single-precision floating point number equivalent to the numeric
			--   value or symbol specified in s.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.FormatException: s is not a numeric value.
			--   System.ArgumentException: style is not a combination of bit flags
			--     from the System.Globalization.NumberStyles enumeration.
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Single use System.Single"
		alias
			"Parse"
		end

	frozen from_string_with_format (s: SYSTEM_STRING; provider: IFORMAT_PROVIDER): REAL is
			-- (Static)
			-- Converts the string representation of a number in a specified
			-- culture-specific format to its single-precision floating point
			-- number equivalent.
			--
			-- Parameters:
			--   s: A string representing a number to convert.
			--   provider: An System.IFormatProvider that supplies culture-specific
			--     formatting information about s.
			--
			-- Returns:
			--   A single-precision floating point number equivalent to the numeric
			--   value or symbol specified in s.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.FormatException: s is not a number in a valid format.
			--   System.OverflowException: s represents a number less than
			--     System.Single.MinValue or greater than System.Single.MaxValue.
		external
			"IL static signature (System.String, System.IFormatProvider): System.Single use System.Single"
		alias
			"Parse"
		end

	frozen from_string_with_style_and_format (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER): REAL is
			-- (Static)
			-- Converts the string representation of a number in a specified style
			-- and culture-specific format to its single-precision floating point
			-- number equivalent.  
			--
			-- Parameters:
			--   s: A string representing a number to convert.
			--   style: The combination of one or more
			--     System.Globalization.NumberStylesconstants that indicate the
			--     permitted format of s.
			--   provider: An System.IFormatProvider that supplies culture-specific
			--     formatting information about s. 
			--
			-- Returns:
			--   A single-precision floating point number equivalent to the numeric
			--   value or symbol specified in s.  
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.FormatException: s is not a numeric value.
			--   System.ArgumentException: style is not a combination of bit flags
			--     from the System.Globalization.NumberStyles enumeration.
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Single use System.Single"
		alias
			"Parse"
		end

	frozen to_string_with_format (format: SYSTEM_STRING): SYSTEM_STRING is
			-- Converts the numeric value of this instance to its equivalent string
			-- representation, using the specified format.  
			--
			-- Parameters:
			--   format: A format string.
			--
			-- Returns:
			--   The string representation of the value of this instance as
			--   specified by format.
			--
			-- Exceptions:
			--   System.FormatException: format is invalid.
		external
			"IL signature (System.String): System.String use System.Single"
		alias
			"ToString"
		end

	frozen to_string_with_format_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
			-- Converts the numeric value of this instance to its equivalent string
			-- representation using the specified culture-specific format information.
			--
			-- Parameters:
			--   provider: An System.IFormatProvider that supplies culture-specific
			--   formatting information.
			--
			-- Returns:
			--   The string representation of the value of this instance as specified
			--   by provider.
		external
			"IL signature (System.IFormatProvider): System.String use System.Single"
		alias
			"ToString"
		end

	frozen to_string_with_format_and_format_provider (format: SYSTEM_STRING; provider: IFORMAT_PROVIDER): SYSTEM_STRING is
			-- Converts the numeric value of this instance to its equivalent string
			-- representation using the specified format and culture-specific format
			-- information.
			--
			-- Parameters:
			--   format: A format specification.
			--   provider: An System.IFormatProvider that supplies culture-specific
			--     formatting information.
			--
			-- Returns:
			--   The string representation of the value of this instance as specified
			--   by format and provider.  
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Single"
		alias
			"ToString"
		end

feature -- Comparison

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
			-- Compares this instance to a specified object and returns an indication
			-- of their relative values.
			--
			-- Parameters:
			--   value: An object to compare, or null.
			--
			-- Returns:
			-- A signed number indicating the relative values of this instance and
			-- value:
			--   Less than zero if this instance is less than value -or- is not a number
			--     (System.Single.NaN ).
			--   Zero if this instance is equal to value -or- this instance and value are
			--     both not a number (System.Single.NaN), System.Single.PositiveInfinity,
			--     or System.Single.NegativeInfinity.
			--   Greater than zero if this instance is greater than value -or- is a number
			--     and value is not a number (System.Single.NaN) -or-  value is null.
			--
			-- Exceptions:
			--   System.ArgumentException: value is not a System.Single.
		external
			"IL signature (System.Object): System.Int32 use System.Single"
		alias
			"CompareTo"
		end

feature -- Obsolete

	frozen get_type_code: TYPE_CODE is
		obsolete
			"Use `type_code' instead"
		external
			"IL signature (): System.TypeCode use System.Single"
		alias
			"GetTypeCode"
		end

	frozen is_na_n (f: REAL): BOOLEAN is
		obsolete
			"Use `is_nan' instead"
		external
			"IL static signature (System.Single): System.Boolean use System.Single"
		alias
			"IsNaN"
		end

	frozen parse (s: SYSTEM_STRING): REAL is
		obsolete
			"Use `from_string' instead"
		external
			"IL static signature (System.String): System.Single use System.Single"
		alias
			"Parse"
		end

	frozen parse_string_number_styles (s: SYSTEM_STRING; style: NUMBER_STYLES): REAL is
		obsolete
			"Use `from_string_with_style' instead"
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Single use System.Single"
		alias
			"Parse"
		end

	frozen parse_string_iformat_provider (s: SYSTEM_STRING; provider: IFORMAT_PROVIDER): REAL is
		obsolete
			"Use `from_string_with_format' instead"
		external
			"IL static signature (System.String, System.IFormatProvider): System.Single use System.Single"
		alias
			"Parse"
		end

	frozen parse_string_number_styles_iformat_provider (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER): REAL is
		obsolete
			"Use `from_string_with_style_and_format' instead"
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Single use System.Single"
		alias
			"Parse"
		end

	frozen to_string_string2 (format: SYSTEM_STRING): SYSTEM_STRING is
		obsolete
			"Use `to_string_with_format' instead"
		external
			"IL signature (System.String): System.String use System.Single"
		alias
			"ToString"
		end

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		obsolete
			"Use `to_string_with_format' instead"
		external
			"IL signature (System.IFormatProvider): System.String use System.Single"
		alias
			"ToString"
		end

	frozen to_string_string (format: SYSTEM_STRING; provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		obsolete
			"Use `to_string_with_format_and_format_provider' instead"
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Single"
		alias
			"ToString"
		end

end -- class REAL
