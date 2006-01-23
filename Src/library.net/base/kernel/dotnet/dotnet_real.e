indexing
	description: "Set of static routines belonging to System.Single"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen external class
	DOTNET_REAL

create {NONE}

feature -- Statics

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

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class DOTNET_REAL
