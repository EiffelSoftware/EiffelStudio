indexing
	description: "Set of static routines belonging to System.Char"
	date: "$Date$"
	revision: "$Revision$"

frozen external class
	DOTNET_INTEGER

create {NONE}

feature -- Statics

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

end -- class DOTNET_INTEGER
