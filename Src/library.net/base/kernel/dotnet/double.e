indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Double"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DOUBLE

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

	DOUBLE_REF

create {NONE}

feature -- Access

	frozen min_value: DOUBLE is -1.79769313486232E+308

	frozen max_value: DOUBLE is 1.79769313486232E+308

	frozen epsilon: DOUBLE is 4.94065645841247E-324

	frozen type_code: TYPE_CODE is
			-- Returns the System.TypeCode for value type System.Double.
			--
			-- Returns:
			--   The enumerated constant, System.TypeCode.Double.  
		external
			"IL signature (): System.TypeCode use System.Double"
		alias
			"GetTypeCode"
		end

feature -- Status Report

	frozen is_infinity (d: DOUBLE): BOOLEAN is
			-- (Static)
			-- Returns a value indicating whether the specified number evaluates
			-- to negative or positive infinity 
			--
			-- Parameters:
			--   d: A double-precision floating point number.
			--
			-- Returns:
			--   true if d evaluates to System.Double.PositiveInfinity or
			--   System.Double.NegativeInfinity; otherwise, false.
		external
			"IL static signature (System.Double): System.Boolean use System.Double"
		alias
			"IsInfinity"
		end

	frozen is_positive_infinity (d: DOUBLE): BOOLEAN is
			-- (Static)
			-- Returns a value indicating whether the specified number evaluates
			-- to positive infinity.
			--
			-- Parameters:
			--   d: A double-precision floating point number.
			--
			-- Returns:
			--   true if d evaluates to System.Double.PositiveInfinity; otherwise,
			--   false. 
		external
			"IL static signature (System.Double): System.Boolean use System.Double"
		alias
			"IsPositiveInfinity"
		end

	frozen is_negative_infinity (d: DOUBLE): BOOLEAN is
			-- (Static)
			-- Returns a value indicating whether the specified number evaluates
			-- to negative infinity.
			--
			-- Parameters:
			--   d: A double-precision floating point number.
			--
			-- Returns:
			--   true if d evaluates to System.Double.NegativeInfinity; otherwise,
			--   false. 
		external
			"IL static signature (System.Double): System.Boolean use System.Double"
		alias
			"IsNegativeInfinity"
		end

	frozen is_nan (d: DOUBLE): BOOLEAN is
			-- (Static)
			-- Returns a value indicating whether the specified number evaluates
			-- to a value that is not a number (System.Double.NaN).  
			-- Parameters:
			--   d: A double-precision floating point number.
			--
			-- Returns:
			--   true if d evaluates to System.Double.NaN; otherwise, false.
		external
			"IL static signature (System.Double): System.Boolean use System.Double"
		alias
			"IsNaN"
		end

feature -- Conversion

	frozen from_string_attempt (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER; result_: TYPED_POINTER [DOUBLE]): BOOLEAN is
			-- (Static)
			-- Converts the string representation of a number in a specified style
			-- and culture-specific format to its double-precision floating point
			-- number equivalent.
			--
			-- Parameters:
			--   s: A string containing a numberto convert.
			--   style: The combination of one or more
			--     System.Globalization.NumberStylesconstants that indicate the
			--     permitted format of s.
			--  provider: An System.IFormatProvider that supplies culture-specific
			--    formatting information about s. 
			--  result_: A double-precision floating-point number equivalent to the
			--    numeric value or symbol specified in s. If the return value is
			--    false, result_ is set to zero.
			--
			-- Returns:
			--   true if s is converted successfully; otherwise, false.
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider, System.Double&): System.Boolean use System.Double"
		alias
			"TryParse"
		end

	frozen from_string (s: SYSTEM_STRING): DOUBLE is
			-- (Static)
			-- Converts the string representation of a number to its double-precision
			-- floating point number equivalent.
			--
			-- Parameters:
			--   s: A string containing a number to convert.
			--
			-- Returns:
			--   A double-precision floating point number equivalent to the numeric
			--   value or symbol specified in s.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.FormatException: s is not a number in a valid format.
			--   System.OverflowException: s represents a number less than
			--     System.Double.MinValue or greater than System.Double.MaxValue.
		external
			"IL static signature (System.String): System.Double use System.Double"
		alias
			"Parse"
		end

	frozen from_string_with_style (s: SYSTEM_STRING; style: NUMBER_STYLES): DOUBLE is
			-- (Static)
			-- Converts the string representation of a number in a specified style
			-- to its double-precision floating point number equivalent.
			--
			-- Parameters:
			--   s: A string containing a number to convert. 
			--   style: The combination of one or more
			--     System.Globalization.NumberStyles constants that indicate the
			--     permitted format of s. 
			--
			-- Returns:
			--   A double-precision floating point number equivalent to the numeric
			--   value or symbol specified in s.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.FormatException: s is not a number in a valid format.
			--   System.OverflowException: s represents a number less than
			--     System.Double.MinValue or greater than System.Double.MaxValue.
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Double use System.Double"
		alias
			"Parse"
		end

	frozen from_string_with_format (s: SYSTEM_STRING; provider: IFORMAT_PROVIDER): DOUBLE is
			-- (Static)
			-- Converts the string representation of a number in a specified
			-- culture-specific format to its double-precision floating point
			-- number equivalent.  
			--
			-- Parameters:
			--   s: A string containing a number to convert.
			--   provider: An System.IFormatProvider that supplies
			--     culture-specific formatting information about s.
			--
			-- Returns:
			--   A double-precision floating point number equivalent to the
			--   numeric value or symbol specified in s.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.FormatException: s is not a number in a valid format.
			--   System.OverflowException: s represents a number less than
			--     System.Double.MinValue or greater than System.Double.MaxValue.
		external
			"IL static signature (System.String, System.IFormatProvider): System.Double use System.Double"
		alias
			"Parse"
		end

	frozen from_string_with_style_and_format (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER): DOUBLE is
			-- (Static)
			-- Converts the string representation of a number in a specified style
			-- and culture-specific format to its double-precision floating point
			-- number equivalent.
			--
			-- Parameters:
			--   s: A string containing a number to convert.
			--   style: The combination of one or more
			--     System.Globalization.NumberStyles constants that indicate the
			--     permitted format of s.
			--   provider: An System.IFormatProvider that supplies culture-specific
			--     formatting information about s.
			--
			-- Returns:
			--   A double-precision floating point number equivalent to the numeric
			--   value or symbol specified in s.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.FormatException: s is not a numeric value.
			--   System.ArgumentException: style is not a combination of bit flags
			--     from the System.Globalization.NumberStyles enumeration.
			--   System.OverflowException: s represents a number less than
			--     System.Double.MinValue or greater than System.Double.MaxValue.
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Double use System.Double"
		alias
			"Parse"
		end

	frozen to_string_with_format (format: SYSTEM_STRING): SYSTEM_STRING is
			-- Converts the numeric value of this instance to its equivalent
			-- string representation, using the specified format.  
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
			"IL signature (System.String): System.String use System.Double"
		alias
			"ToString"
		end

	frozen to_string_with_format_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
			-- Converts the numeric value of this instance to its equivalent
			-- string representation using the specified culture-specific
			-- format information.
			--
			-- Parameters:
			--   provider: An System.IFormatProvider that supplies
			--   culture-specific formatting information.
			--
			-- Returns:
			--   The string representation of the value of this instance as
			--   specified by provider.
		external
			"IL signature (System.IFormatProvider): System.String use System.Double"
		alias
			"ToString"
		end

	frozen to_string_with_format_and_format_provider (format: SYSTEM_STRING; provider: IFORMAT_PROVIDER): SYSTEM_STRING is
			-- Converts the numeric value of this instance to its equivalent
			-- string representation using the specified format and
			-- culture-specific format information.
			--
			-- Parameters:
			--   format: A format specification.
			--   provider: An System.IFormatProvider that supplies
			--     culture-specific formatting information.
			--
			-- Returns:
			--   The string representation of the value of this instance as
			--   specified by format and provider.
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Double"
		alias
			"ToString"
		end

feature -- Comparison

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
			-- Compares this instance to a specified object and returns an
			-- indication of their relative values.
			--
			-- Parameters:
			--   value: An object to compare, or null.
			--
			-- Returns:
			--   A signed number indicating the relative values of this
			--   instance and value:
			--     A negative integer if this instance is less than value
			--       -or- This instance is not a number (System.Double.NaN)
			--       and value is a number.
			--     Zero if this instance is equal to value -or- this instance
			--       and value are both Double.NaN,
			--       System.Double.PositiveInfinity, or System.Double.NegativeInfinity
			--     A positive integer if this instance is greater than value
			--       -or- This instance is a number and value is not a number
			--       (System.Double.NaN) -or- value is null.
			--
			-- Exceptions:
			--   System.ArgumentException: value is not a System.Double.
		external
			"IL signature (System.Object): System.Int32 use System.Double"
		alias
			"CompareTo"
		end

feature -- Obsolete

	frozen get_type_code: TYPE_CODE is
		obsolete
			"Use `type_code' instead"
		external
			"IL signature (): System.TypeCode use System.Double"
		alias
			"GetTypeCode"
		end

	frozen is_na_n (d: DOUBLE): BOOLEAN is
		obsolete
			"Use `is_nan' instead"
		external
			"IL static signature (System.Double): System.Boolean use System.Double"
		alias
			"IsNaN"
		end

	frozen try_parse (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER; result_: DOUBLE): BOOLEAN is
		obsolete
			"Use `from_string_attempt' instead"
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider, System.Double&): System.Boolean use System.Double"
		alias
			"TryParse"
		end

	frozen parse (s: SYSTEM_STRING): DOUBLE is
		obsolete
			"Use `from_string' instead"
		external
			"IL static signature (System.String): System.Double use System.Double"
		alias
			"Parse"
		end

	frozen parse_string_number_styles (s: SYSTEM_STRING; style: NUMBER_STYLES): DOUBLE is
		obsolete
			"Use `from_string_with_style' instead"
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Double use System.Double"
		alias
			"Parse"
		end

	frozen parse_string_iformat_provider (s: SYSTEM_STRING; provider: IFORMAT_PROVIDER): DOUBLE is
		obsolete
			"Use `from_string_with_format' instead"
		external
			"IL static signature (System.String, System.IFormatProvider): System.Double use System.Double"
		alias
			"Parse"
		end

	frozen parse_string_number_styles_iformat_provider (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER): DOUBLE is
		obsolete
			"Use `from_string_with_style_and_format' instead"
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Double use System.Double"
		alias
			"Parse"
		end

	frozen to_string_string2 (format: SYSTEM_STRING): SYSTEM_STRING is
		obsolete
			"Use `to_string_with_format' instead"
		external
			"IL signature (System.String): System.String use System.Double"
		alias
			"ToString"
		end

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		obsolete
			"Use `to_string_with_format_provider' instead"
		external
			"IL signature (System.IFormatProvider): System.String use System.Double"
		alias
			"ToString"
		end

	frozen to_string_string (format: SYSTEM_STRING; provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		obsolete
			"Use `to_string_with_format_and_format_provider' instead"
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Double"
		alias
			"ToString"
		end

end -- class DOUBLE
