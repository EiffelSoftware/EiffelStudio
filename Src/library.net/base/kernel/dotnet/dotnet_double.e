indexing
	description: "Set of static routines belonging to System.Double"
	date: "$Date$"
	revision: "$Revision$"

frozen external class
	DOTNET_DOUBLE

create {NONE}

feature -- Statics

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

end -- class DOTNET_DOUBLE
