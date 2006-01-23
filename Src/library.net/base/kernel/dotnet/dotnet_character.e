indexing
	description: "Set of static routines belonging to System.Char"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen external class
	DOTNET_CHARACTER

create {NONE}

feature -- Statics

	frozen numeric_value (c: CHARACTER): DOUBLE is
			-- (Static)
			-- Converts the specified numeric Unicode character to a
			-- double-precision floating point number.  
			--
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			--   The numeric value of c if that character represents
			--   a number; otherwise, -1.0.
		external
			"IL static signature (System.Char): System.Double use System.Char"
		alias
			"GetNumericValue"
		end

	frozen numeric_value_from_string (s: SYSTEM_STRING; index: INTEGER): DOUBLE is
			-- Converts the numeric Unicode character at the specified
			-- position in a specified string to a double-precision
			-- floating point number.  
			--
			-- Parameters:
			--   s: A System.String.
			--   index: The character position in s.
			--
			-- Returns:
			--   The numeric value of the character at position index in
			--   s if that character represents a number; otherwise, -1.  
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentOutOfRangeException: index is less than
			--     zero or greater than the last position in s.
		external
			"IL static signature (System.String, System.Int32): System.Double use System.Char"
		alias
			"GetNumericValue"
		end

	frozen unicode_category (c: CHARACTER): UNICODE_CATEGORY is
			-- Categorizes a specified Unicode character into a group
			-- identified by one of the System.Globalization.UnicodeCategory
			-- values.  
			--
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			--   A System.Globalization.UnicodeCategory value that identifies
			--   the group that contains c.
		external
			"IL static signature (System.Char): System.Globalization.UnicodeCategory use System.Char"
		alias
			"GetUnicodeCategory"
		end

	frozen unicode_category_from_string (s: SYSTEM_STRING; index: INTEGER): UNICODE_CATEGORY is
			-- Categorizes the character at the specified position in a
			-- specified string into a group identified by one of the
			-- System.Globalization.UnicodeCategory values.
			--
			-- Parameters:
			--   s: A System.String.
			--   index: The character position in s.
			--
			-- Returns:
			--   A System.Globalization.UnicodeCategory enumerated constant
			--   that identifies the group that contains the character at
			--   position index in s.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentOutOfRangeException: index is less than zero
			--     or greater than the last position in s.
		external
			"IL static signature (System.String, System.Int32): System.Globalization.UnicodeCategory use System.Char"
		alias
			"GetUnicodeCategory"
		end

	frozen is_lower (c: CHARACTER): BOOLEAN is
			-- (Static)
			-- Indicates whether the specified Unicode character is
			-- categorized as a lowercase letter.
			--
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			--   true if c is a lowercase letter; otherwise, false.   
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsLower"
		end

	frozen is_lower_in_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
			-- (Static)
			-- Indicates whether the character at the specified position
			-- in a specified string is categorized as a lowercase letter.
			--
			-- Parameters:
			--   s: A string.
			--   index: The character position in s.
			--
			-- Returns:
			--   true if the character at position index in s is a lowercase
			--   letter; otherwise, false.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentOutOfRangeException: index is less than zero
			--     or greater than the last position in s.
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsLower"
		end

	frozen is_upper (c: CHARACTER): BOOLEAN is
			-- (Static)
			-- Indicates whether the specified Unicode character is
			-- categorized as an uppercase letter.  
			--
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			-- true if c is an uppercase letter; otherwise, false.  
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsUpper"
		end

	frozen is_upper_in_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
			-- (Static)
			-- Indicates whether the character at the specified position
			-- in a specified string is categorized as an uppercase letter.
			--
			-- Parameters:
			--   s: A string.
			--   index: The character position in s.
			--
			-- Returns:
			--   true if the character at position index in s is an uppercase
			--   letter; otherwise, false.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentOutOfRangeException: index is less than zero
			--     or greater than the last position in s.
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsUpper"
		end

	frozen is_white_space (c: CHARACTER): BOOLEAN is
			-- (Static)
			-- Indicates whether the specified Unicode character is categorized
			-- as white space.
			--
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			--   true if c is white space; otherwise, false.   
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsWhiteSpace"
		end

	frozen is_white_space_in_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
			-- (Static)
			-- Indicates whether the character at the specified position in a
			-- specified string is categorized as white space.
			--
			-- Parameters:
			--   s: A string.
			--   index: The character position in s.
			--
			-- Returns:
			--   true if the character at position index in s is white space;
			--   otherwise, false.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentOutOfRangeException: index is less than zero or
			--     greater than the last position in s.
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsWhiteSpace"
		end

	frozen is_symbol (c: CHARACTER): BOOLEAN is
			-- (Static)
			-- Indicates whether the specified Unicode character is categorized
			-- as a symbol character.
			--
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			--   true if c is a symbol character; otherwise, false.  
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsSymbol"
		end


	frozen is_symbol_in_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
			-- (Static)
			-- Indicates whether the character at the specified position in a
			-- specified string is categorized as a symbol character.
			--
			-- Parameters:
			--   s: A string.
			--   index: The character position in s.
			--
			-- Returns:
			--   true if the character at position index in s is a symbol
			--   character; otherwise, false.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentOutOfRangeException: index is less than zero
			--   or greater than the last position in s.
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsSymbol"
		end

	frozen is_digit (c: CHARACTER): BOOLEAN is
			-- (Static)
			-- Indicates whether the specified Unicode character is
			-- categorized as a decimal digit.
			--
			-- Parameters:
			--   c: A Unicode character. 
			--
			-- Returns:
			--   true if c is a decimal digit; otherwise, false. 
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsDigit"
		end

	frozen is_digit_in_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
			-- (Static)
			-- Indicates whether the character at the specified position in a
			-- specified string is categorized as a decimal digit.
			--
			-- Parameters:
			--   s: A System.String.
			--   index: The character position in s.
			--
			-- Returns:
			--   true if the character at position index in s is a decimal
			--   digit; otherwise, false.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentOutOfRangeException: index is less than zero
			--     or greater than the last position in s.
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsDigit"
		end

	frozen is_separator (c: CHARACTER): BOOLEAN is
			-- (Static)
			-- Indicates whether the specified Unicode character is
			-- categorized as a separator character.
			--
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			--   true if c is a separator character; otherwise, false.   
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsSeparator"
		end

	frozen is_separator_in_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
			-- (Static)
			-- Indicates whether the character at the specified position in
			-- a specified string is categorized as a separator character.
			--
			-- Parameters:
			--   s: A string.
			--   index: The character position in s.
			--
			-- Returns:
			--   true if the character at position index in s is a separator
			--   character; otherwise, false.   
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentOutOfRangeException: index is less than zero
			--     or greater than the last position in s.
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsSeparator"
		end

	frozen is_letter (c: CHARACTER): BOOLEAN is
			-- (Static)
			-- Indicates whether the specified Unicode character is
			-- categorized as an alphabetic letter.
			--
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			--   true if c is an alphabetic letter; otherwise, false.   
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsLetter"
		end

	frozen is_letter_in_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
			-- (Static)
			-- Indicates whether the character at the specified position in
			-- a specified string is categorized as an alphabetic character.
			--
			-- Parameters:
			--   s: A string.
			--   index: The character position in s.
			--
			-- Returns:
			--   true if the character at position index in s is an
			--   alphabetic character; otherwise, false.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentOutOfRangeException: index is less than zero
			--     or greater than the last position in s.
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsLetter"
		end

	frozen is_punctuation (c: CHARACTER): BOOLEAN is
			-- (Static)
			-- Indicates whether the specified Unicode character is
			-- categorized as a punctuation mark.
			--
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			--   true if c is a punctuation mark; otherwise, false.   
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsPunctuation"
		end

	frozen is_punctuation_in_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
			-- (Static)
			-- Indicates whether the character at the specified position in
			-- a specified string is categorized as a punctuation mark.
			--
			-- Parameters:
			--   s: A string.
			--   index: The character position in s.
			--
			-- Returns:
			--   true if the character at position index in s is a
			--   punctuation mark; otherwise, false.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentOutOfRangeException: index is less than zero
			--     or greater than the last position in s.
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsPunctuation"
		end

	frozen is_surrogate (c: CHARACTER): BOOLEAN is
			-- (Static)
			-- Indicates whether the specified Unicode character is
			-- categorized as a surrogate character.
			--
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			--   true if c is a surrogate character; otherwise, false.   
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsSurrogate"
		end

	frozen is_surrogate_in_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
			-- (Static)
			-- Indicates whether the character at the specified position
			-- in a specified string is categorized as a surrogate character.
			--
			-- Parameters:
			--   s: A string.
			--   index: The character position in s.
			--
			-- Returns:
			--   true if the character at position index in s is a surrogate
			--   character; otherwise, false.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentOutOfRangeException: index is less than zero
			--     or greater than the last position in s.
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsSurrogate"
		end

	frozen is_number (c: CHARACTER): BOOLEAN is
			-- (Static)
			-- Indicates whether the specified Unicode character is
			-- categorized as a number.
			--
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			--   true if c  is a number; otherwise, false.
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsNumber"
		end

	frozen is_number_in_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
			-- (Static)
			-- Indicates whether the character at the specified position
			-- in a specified string is categorized as a number.
			--
			-- Parameters:
			--   s: A string.
			--   index: The character position in s.
			--
			-- Returns:
			--   true if the character at position index in s  is a
			--   number; otherwise, false.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentOutOfRangeException: index is less than zero
			--     or greater than the last position in s.
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsNumber"
		end

	frozen is_letter_or_digit (c: CHARACTER): BOOLEAN is
			-- (Static)
			-- Indicates whether the specified Unicode character is categorized
			-- as an alphabetic letter or a decimal digit.
			--
			-- Parameters:
			--   c: A Unicode character. 
			--
			-- Returns:
			--   true if c is an alphabetic letter or a decimal digit;
			--   otherwise, false.   
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsLetterOrDigit"
		end

	frozen is_letter_or_digit_in_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
			-- (Static)
			-- Indicates whether the character at the specified position
			-- in a specified string is categorized as an alphabetic
			-- character or a decimal digit.
			--
			-- Parameters:
			--   s: A string.
			--   index: The character position in s.
			--
			-- Returns:
			--   true if the character at position index in s is an
			--   alphabetic character or a decimal digit; otherwise, false. 
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentOutOfRangeException: index is less than zero
			--     or greater than the last position in s.
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsLetterOrDigit"
		end

	frozen is_control (c: CHARACTER): BOOLEAN is
			-- (Static)
			-- Indicates whether the specified Unicode character
			-- is categorized as a control character.
			--
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			--   true if c is a control character; otherwise, false.
		external
			"IL static signature (System.Char): System.Boolean use System.Char"
		alias
			"IsControl"
		end

	frozen is_control_in_string (s: SYSTEM_STRING; index: INTEGER): BOOLEAN is
			-- (Static)
			-- Indicates whether the character at the specified position
			-- in a specified string is categorized as a control character.
			--
			-- Parameters:
			--   s: A string.
			--   index: The character position in s.
			--
			-- Returns:
			--   true if the character at position index in s is a control
			--   character; otherwise, false.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.ArgumentOutOfRangeException: index is less than zero
			--     or greater than the last position in s.
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Char"
		alias
			"IsControl"
		end

	frozen from_string (s: SYSTEM_STRING): CHARACTER is
			-- (Static)
			-- Converts the value of the specified string to its equivalent
			-- Unicode character.
			--
			-- Parameters:
			--   s: A string containing a single character or null.
			--
			-- Returns:
			--   A Unicode character equivalent to the sole character in s.
			--
			-- Exceptions:
			--   System.ArgumentNullException: s is null.
			--   System.FormatException: The length of s is not 1.
		external
			"IL static signature (System.String): System.Char use System.Char"
		alias
			"Parse"
		end

	frozen static_to_string (c: CHARACTER): SYSTEM_STRING is
			-- (Static)
			-- Converts the specified Unicode character to its equivalent
			-- string representation.
			--
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			--   The string representation of the value of c.
		external
			"IL static signature (System.Char): System.String use System.Char"
		alias
			"ToString"
		end

	frozen to_upper (c: CHARACTER): CHARACTER is
			-- (Static)
			-- Converts the value of a Unicode character to its uppercase
			-- equivalent.  
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			--   The uppercase equivalent of c -or- the unchanged value
			--   of c, if c is already uppercase or not alphabetic.
		external
			"IL static signature (System.Char): System.Char use System.Char"
		alias
			"ToUpper"
		end

	frozen to_upper_with_culture (c: CHARACTER; culture: CULTURE_INFO): CHARACTER is
			-- (Static)
			-- Converts the value of a specified Unicode character to
			-- its uppercase equivalent using specified culture-specific
			-- formatting information.
			--
			-- Parameters:
			--   c: A Unicode character.
			--   culture: A System.Globalization.CultureInfo object that
			--     supplies culture-specific casing rules, or null.
			--
			-- Returns:
			--   The uppercase equivalent of c, modified according to
			--   culture -or- the unchanged value of c, if c is already 
			--   uppercase or not alphabetic.
			--
			-- Exceptions:
			--   System.ArgumentNullException: culture is null.
		external
			"IL static signature (System.Char, System.Globalization.CultureInfo): System.Char use System.Char"
		alias
			"ToUpper"
		end

	frozen to_lower (c: CHARACTER): CHARACTER is
			-- (Static)
			-- Converts the value of a Unicode character to its
			-- lowercase equivalent.
			--
			-- Parameters:
			--   c: A Unicode character.
			--
			-- Returns:
			--   The lowercase equivalent of c -or- The unchanged value
			--   of c, if c is already lowercase or not alphabetic.  
		external
			"IL static signature (System.Char): System.Char use System.Char"
		alias
			"ToLower"
		end

	frozen to_lower_with_culture (c: CHARACTER; culture: CULTURE_INFO): CHARACTER is
			-- (Static)
			-- Converts the value of a specified Unicode character to
			-- its lowercase equivalent using specified culture-specific
			-- formatting information.
			--
			-- Parameters:
			--   c: A Unicode character.
			--   culture: A System.Globalization.CultureInfo object that
			--     supplies culture-specific casing rules, or null.
			--
			-- Returns:
			--   The lowercase equivalent of c, modified according to
			--   culture -or- the unchanged value of c, if c is already
			--   lowercase or not alphabetic.
			--
			-- Exceptions:
			--   System.ArgumentNullException: culture is null.
		external
			"IL static signature (System.Char, System.Globalization.CultureInfo): System.Char use System.Char"
		alias
			"ToLower"
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


end -- class DOTNET_CHARACTER
