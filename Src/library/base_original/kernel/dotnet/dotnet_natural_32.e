indexing
	description: "Set of static routines belonging to System.UInt32"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	external_name: "System.UInt32"
	assembly: "mscorlib"

frozen expanded external class
	DOTNET_NATURAL_32

create {NONE}
	default_create

feature -- Statics

	frozen from_string (s: SYSTEM_STRING): NATURAL_32 is
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
			--     System.UInt32.MinValue or greater than System.UInt32.MaxValue.
		external
			"IL static signature (System.String): System.UInt32 use System.UInt32"
		alias
			"Parse"
		end

	frozen from_string_with_style (s: SYSTEM_STRING; style: NUMBER_STYLES): NATURAL_32 is
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
			--     System.UInt32.MinValue or greater than System.UInt32.MaxValue.
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.UInt32 use System.UInt32"
		alias
			"Parse"
		end

	frozen from_string_with_format (s: SYSTEM_STRING; provider: IFORMAT_PROVIDER): NATURAL_32 is
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
			--     System.UInt32.MinValue or greater than System.UInt32.MaxValue.
		external
			"IL static signature (System.String, System.IFormatProvider): System.UInt32 use System.UInt32"
		alias
			"Parse"
		end

	frozen from_string_with_style_and_format (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER): NATURAL_32 is
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
			--     System.UInt32.MinValue or greater than System.UInt32.MaxValue.
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.UInt32 use System.UInt32"
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


end -- class DOTNET_NATURAL_32
