indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Int32"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	INTEGER

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
		
	INTEGER_REF

create {NONE}

feature -- Access

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

feature -- Conversion

	frozen from_string (s: SYSTEM_STRING): INTEGER is
			-- (Static)
			-- Converts the string representation of a number to its 32-bit
			-- signed integer equivalent. 
			--
			-- Parameters:
			--   s: A string containing a number to convert.
			--
			-- Returns:
			--   A 32-bit signed integer equivalent to the number specified in s.  
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.FormatException: s is not in a format compliant with style.
			--   System.OverflowException: s represents a number less than
			--     System.Int32.MinValue or greater than System.Int32.MaxValue.
		external
			"IL static signature (System.String): System.Int32 use System.Int32"
		alias
			"Parse"
		end

	frozen from_string_with_style (s: SYSTEM_STRING; style: NUMBER_STYLES): INTEGER is
			-- (Static)
			-- Converts the string representation of a number in a specified style
			-- to its 32-bit signed integer equivalent.
			--
			-- Parameters:
			--   s: A string containing a number to convert.
			--   style: The combination of one or more
			--     System.Globalization.NumberStylesconstants that indicates the
			--     permitted format of s.
			--
			-- Returns:
			--   A 32-bit signed integer equivalent to the number specified in s.  
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentException: style is not a valid combination of
			--     System.Globalization.NumberStyles enumerated constants.
			--   System.FormatException: s is not in a format compliant with style.
			--   System.OverflowException: s represents a number less than
			--     System.Int32.MinValue or greater than System.Int32.MaxValue.
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Int32 use System.Int32"
		alias
			"Parse"
		end

	frozen from_string_with_format (s: SYSTEM_STRING; provider: IFORMAT_PROVIDER): INTEGER is
			-- (Static)
			-- Converts the string representation of a number in a specified 
			-- culture-specific format to its 32-bit signed integer equivalent.
			--
			-- Parameters:
			--   s: A string containing a number to convert.
			--   provider: An System.IFormatProvider that supplies culture-specific
			--     formatting information about s. 
			--
			-- Returns:
			--   A 32-bit signed integer equivalent to the number specified in s.  
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.OverflowException: s represents a number less than
			--     System.Int32.MinValue or greater than System.Int32.MaxValue.
		external
			"IL static signature (System.String, System.IFormatProvider): System.Int32 use System.Int32"
		alias
			"Parse"
		end

	frozen from_string_with_style_and_format (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER): INTEGER is
			-- (Static)
			-- Converts the string representation of a number in a specified style
			-- and culture-specific format to its 32-bit signed integer equivalent.
			--
			-- Parameters:
			--   s: A string containing a number to convert.
			--   style: The combination of one or more
			--     System.Globalization.NumberStylesconstants that indicates the
			--     permitted format of s.
			--   provider: An System.IFormatProvider that supplies culture-specific
			--     formatting information about s. 
			--
			-- Returns:
			--   A 32-bit signed integer equivalent to the number specified in s.  
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentException: style is not a valid combination of
			--     System.Globalization.NumberStyles enumerated constants.
			--   System.FormatException: s is not in a format compliant with style.
			--   System.OverflowException: s represents a number less than
			--     System.Int32.MinValue or greater than System.Int32.MaxValue.
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Int32 use System.Int32"
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
			--     specified by format.  
		external
			"IL signature (System.String): System.String use System.Int32"
		alias
			"ToString"
		end

	frozen to_string_with_format_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
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
			"IL signature (System.IFormatProvider): System.String use System.Int32"
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
			"IL signature (System.String, System.IFormatProvider): System.String use System.Int32"
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
			--   A signed number indicating the relative values of this instance and
			--   value:
			--     Less than zero if this instance is less than value.
			--     Zero This instance is equal to value.
			--     Greater than zero if this instance is greater than value -or- value is null.     
			--
			-- Exceptions:
			--   System.ArgumentException: value is not an System.Int32.
		external
			"IL signature (System.Object): System.Int32 use System.Int32"
		alias
			"CompareTo"
		end

feature -- Obsolete

	frozen get_type_code: TYPE_CODE is
		obsolete
			"Use `type_code' instead"
		external
			"IL signature (): System.TypeCode use System.Int32"
		alias
			"GetTypeCode"
		end

	frozen parse (s: SYSTEM_STRING): INTEGER is
		obsolete
			"Use `from_string' instead"
		external
			"IL static signature (System.String): System.Int32 use System.Int32"
		alias
			"Parse"
		end

	frozen parse_string_number_styles (s: SYSTEM_STRING; style: NUMBER_STYLES): INTEGER is
		obsolete
			"Use `from_string_with_style' instead"
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Int32 use System.Int32"
		alias
			"Parse"
		end

	frozen parse_string_iformat_provider (s: SYSTEM_STRING; style: NUMBER_STYLES): INTEGER is
		obsolete
			"Use `from_string_with_format' instead"
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Int32 use System.Int32"
		alias
			"Parse"
		end

	frozen parse_string_number_styles_iformat_provider (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER): INTEGER is
		obsolete
			"Use `from_string_with_style_and_format' instead"
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Int32 use System.Int32"
		alias
			"Parse"
		end

	frozen to_string_string2 (format: SYSTEM_STRING): SYSTEM_STRING is
		obsolete
			"Use `to_string_with_format' instead"
		external
			"IL signature (System.String): System.String use System.Int32"
		alias
			"ToString"
		end

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		obsolete
			"Use `to_string_with_format_provider' instead"
		external
			"IL signature (System.IFormatProvider): System.String use System.Int32"
		alias
			"ToString"
		end

	frozen to_string_string (format: SYSTEM_STRING; provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		obsolete
			"Use `to_string_with_format_and_format_provider' instead"
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Int32"
		alias
			"ToString"
		end

end -- class INTEGER
