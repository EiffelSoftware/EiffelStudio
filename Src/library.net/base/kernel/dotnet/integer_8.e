indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Byte"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	INTEGER_8

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

	INTEGER_8_REF

create {NONE}

feature -- Access

	frozen type_code: TYPE_CODE is
			-- Returns the System.TypeCode for value type System.Byte.
			--
			-- Returns:
			--   The enumerated constant, System.TypeCode.Byte.
		external
			"IL signature (): System.TypeCode use System.Byte"
		alias
			"GetTypeCode"
		end

feature -- Conversion

	frozen from_string (s: SYSTEM_STRING): INTEGER_8 is
			-- (Static)
			-- Converts the string representation of a number to its
			-- System.Byte equivalent.
			--
			-- Parameters:
			--   s: A string containing a number to convert. The
			--     string is interpreted using the
			--     System.Globalization.NumberStyles.Integer style.
			--
			-- Returns:
			--   The System.Byte value equivalent to the number
			--   contained in s.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.FormatException: s is not of the correct format.
			--   System.OverflowException: s represents a number less
			--     than System.Byte.MinValue or greater than
			--     System.Byte.MaxValue.
		external
			"IL static signature (System.String): System.Byte use System.Byte"
		alias
			"Parse"
		end

	frozen from_string_with_style (s: SYSTEM_STRING; style: NUMBER_STYLES): INTEGER_8 is
			-- (Static)
			-- Converts the string representation of a number in a
			-- specified style to its System.Byte equivalent.
			--
			-- Parameters:
			--   s: A string containing a number to convert. The string
			--     is interpreted using the style specified by style.
			--   style: A bitwise combination of
			--     System.Globalization.NumberStyles values that indicate
			--     the permitted format of s. If style is null, the string
			--     is interpreted using the
			--     System.Globalization.NumberStyles.Integer style.
			--
			-- Returns:
			--   The System.Byte value equivalent to the number contained in s.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.FormatException: s is not of the correct format.
			--   System.OverflowException: s represents a number less than
			--     System.Byte.MinValue or greater than System.Byte.MaxValue.
			--   System.ArgumentException: style is not a valid bitwise
			--     combination of System.Globalization.NumberStyles values.

		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Byte use System.Byte"
		alias
			"Parse"
		end

	frozen from_string_with_format (s: SYSTEM_STRING; provider: IFORMAT_PROVIDER): INTEGER_8 is
			-- (Static)
			-- Converts the string representation of a number in a specified
			-- culture-specific format to its System.Byte equivalent.
			--
			-- Parameters:
			--   s: A string containing a number to convert. The string is
			--     interpretedusing the System.Globalization.NumberStyles.Integer
			--     style.
			--   provider: An System.IFormatProvider that supplies
			--     culture-specific formatting information about s. If provider
			--     is null, the current system culture is used.
			--
			-- Returns:
			--   The System.Byte value equivalent to the number contained in s.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.FormatException: s is not of the correct format.
			--   System.OverflowException: s represents a number less than
			--     System.Byte.MinValue or greater than System.Byte.MaxValue.
		external
			"IL static signature (System.String, System.IFormatProvider): System.Byte use System.Byte"
		alias
			"Parse"
		end

	frozen from_string_with_style_and_format (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER): INTEGER_8 is
			-- (Static)
			-- Converts the string representation of a number in a specified
			-- style and culture-specific format to its System.Byte equivalent.  
			--
			-- Parameters:
			--   s: A string containinga number to convert. The string is
			--     interpreted using the style specified by style.
			--   style: A bitwise combination of System.Globalization.NumberStyles
			--     values that indicate the permitted format of s. If style is null,
			--     the string is interpreted using the
			--     System.Globalization.NumberStyles.Integer style.
			--   provider: An System.IFormatProvider that supplies culture-specific
			--     formatting information about s. If provider is null, the current
			--     system culture is used.
			--
			-- Returns:
			--   The System.Byte value equivalent to the number contained in s.  
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.FormatException: s is not of the correct format.
			--   System.OverflowException: s represents a number less than
			--     System.Byte.MinValue or greater than System.Byte.MaxValue.
			--   System.ArgumentException: style is not a valid bitwise combination 
			--     of System.Globalization.NumberStyles values.
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Byte use System.Byte"
		alias
			"Parse"
		end

	frozen to_string_with_format (format: SYSTEM_STRING): SYSTEM_STRING is
			-- Converts the numeric value of this instance to its equivalent
			-- string using the specified format.  
			--
			-- Parameters:
			--   format: A string thatspecifies the return format.
			--     See System.Byte.ToString(System.String,System.IFormatProvider)
			--     for a list of valid values.
			--
			-- Returns:
			--   The value of this instance, formatted as specified by format.
		external
			"IL signature (System.String): System.String use System.Byte"
		alias
			"ToString"
		end

	frozen to_string_with_format_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
			-- Converts the numeric value of this instance to its equivalent
			-- string using the specified culture-specific format information.
			--
			-- Parameters:
			--   provider: An System.IFormatProvider that supplies
			--   culture-specific formatting information.
			--
			-- Returns:
			--   The value of this instance, formatted as specified by provider. 
		external
			"IL signature (System.IFormatProvider): System.String use System.Byte"
		alias
			"ToString"
		end

	frozen to_string_with_format_and_format_provider (format: SYSTEM_STRING; provider: IFORMAT_PROVIDER): SYSTEM_STRING is
			-- Converts the numeric value of this instance to its equivalent
			-- string using the specified format and culture-specific format
			-- information.
			--
			-- Parameters:
			--   format: A string thatspecifies the return format.
			--   provider: An System.IFormatProvider that supplies
			--     culture-specific formatting information.
			--
			-- Returns:
			--   The value of this instance, formatted as specified by
			--   format and provider.
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Byte"
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
			--   A signed integer that indicates the relative order of this
			--   instance and value:
			--     Less than zero if this instance is less than value.
			--     Zero if this instance is equal to value.
			--     Greater than zero if this instance is greater than value
			--       -or-  value is null.
			--
			-- Exceptions:
			--   System.ArgumentException: value is not a System.Byte.
		external
			"IL signature (System.Object): System.Int32 use System.Byte"
		alias
			"CompareTo"
		end

feature -- Obsolete

	frozen get_type_code: TYPE_CODE is
		obsolete
			"Use `type_code' instead"
		external
			"IL signature (): System.TypeCode use System.Byte"
		alias
			"GetTypeCode"
		end

	frozen parse (s: SYSTEM_STRING): INTEGER_8 is
		obsolete
			"Use `from_string' instead"
		external
			"IL static signature (System.String): System.Byte use System.Byte"
		alias
			"Parse"
		end

	frozen parse_string_number_styles (s: SYSTEM_STRING; style: NUMBER_STYLES): INTEGER_8 is
		obsolete
			"Use `from_string_with_style' instead"
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Byte use System.Byte"
		alias
			"Parse"
		end

	frozen parse_string_iformat_provider (s: SYSTEM_STRING; provider: IFORMAT_PROVIDER): INTEGER_8 is
		obsolete
			"Use `from_string_with_format' instead"
		external
			"IL static signature (System.String, System.IFormatProvider): System.Byte use System.Byte"
		alias
			"Parse"
		end

	frozen parse_string_number_styles_iformat_provider (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER): INTEGER_8 is
		obsolete
			"Use `from_string_with_style_and_format' instead"
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Byte use System.Byte"
		alias
			"Parse"
		end

	frozen to_string_string2 (format: SYSTEM_STRING): SYSTEM_STRING is
		obsolete
			"Use `to_string_with_format' instead"
		external
			"IL signature (System.String): System.String use System.Byte"
		alias
			"ToString"
		end

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		obsolete
			"Use `to_string_with_format_provider' instead"
		external
			"IL signature (System.IFormatProvider): System.String use System.Byte"
		alias
			"ToString"
		end

	frozen to_string_string (format: SYSTEM_STRING; provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		obsolete
			"Use `to_string_with_format_and_format_provider' instead"
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Byte"
		alias
			"ToString"
		end

end -- class INTEGER_8
