note
	description: "Unicode description of a character code."
	date: "$Date$"
	revision: "$Revision$"

class
	UNICODE_CHARACTER_DATA

inherit
	ANY
		redefine
			out
		end

create
	make

feature {NONE} -- Initialization

	make (a_desc: STRING)
			-- Initialize Current using a line description that is made of fields separated by a semicolon, see below for descriptioon:
			-- Field 0: Code value, normative, Code value in 4-digit hexadecimal format.
			-- Field 1: Character name, normative, These names match exactly the names published in
			--			the Unicode Standard.
			-- Field 2: General Category, normative/informative, This is a useful breakdown
			--			into various "character types" which can be used as a default categorization
			--			in implementations. See below for a brief explanation.
			-- Field 3: Canonical Combining Classes, normative, The classes used for the Canonical
			--			Ordering Algorithm in the Unicode Standard. These classes are also printed
			--			in Chapter 4 of the Unicode Standard.
			-- Field 4: Bidirectional Category, normative, See the list below for an explanation of the
			--			abbreviations used in this field. These are the categories required by the
			--			Bidirectional Behavior Algorithm in the Unicode Standard. These categories are
			--			summarized in Chapter 3 of the Unicode Standard.
			-- Field 5: Character Decomposition Mapping, normative, In the Unicode Standard,
			--			not all of the mappings are full (maximal) decompositions. Recursive application of
			--			look-up for decompositions will, in all cases, lead to a maximal decomposition.
			--			The decomposition mappings match exactly the decomposition mappings published
			--			with the character names in the Unicode Standard.
			-- Field 6: Decimal digit value, normative, This is a numeric field. If the character
			--			has the decimal digit property, as specified in Chapter 4 of the Unicode Standard,
			--			the value of that digit is represented with an integer value in this field
			-- Field 7: Digit value, normative, This is a numeric field. If the character represents
			--			a digit, not necessarily a decimal digit, the value is here. This covers digits
			--			which do not form decimal radix forms, such as the compatibility superscript digits
			-- Field 8: Numeric value, normative, This is a numeric field. If the character has the numeric
			--			property, as specified in Chapter 4 of the Unicode Standard, the value of that character
			--			is represented with an integer or rational number in this field. This includes
			--			fractions as, e.g., "1/5" for U+2155 VULGAR FRACTION ONE FIFTH Also included are
			--			numerical values for compatibility characters such as circled numbers.
			-- Field 8: Mirrored, normative, If the character has been identified as a "mirrored" character
			--			in bidirectional text, this field has the value "Y"; otherwise "N". The list of
			--			mirrored characters is also printed in Chapter 4 of the Unicode Standard.
			-- Field 10: Unicode 1.0 Name, informative, This is the old name as published in Unicode 1.0.
			--			This name is only provided when it is significantly different from the Unicode
			--			name for the character.
			-- Field 11: 10646 comment field, informative, This is the ISO 10646 comment field.
			--			It is in parantheses in the 10646 names list.
			-- Field 12: Uppercase Mapping, informative, Upper case equivalent mapping. If a
			--			character is part of an alphabet with case distinctions, and has an upper case
			--			equivalent, then the upper case equivalent is in this field. See the explanation
			--			below on case distinctions. These mappings are always one-to-one, not
			--			one-to-many or many-to-one. This field is informative.
			-- Field 13: Lowercase Mapping, informative, Similar to Uppercase mapping
			-- Field 14: Titlecase Mapping, informative, Similar to Uppercase mapping
		local
			l_list: LIST [STRING]
		do
			l_list := a_desc.split (';')
			if l_list.count = 15 then
				code := to_natural (l_list.i_th (1))
				name := l_list.i_th (2)
				general_category := l_list.i_th (3)
				canonical_combining_class := from_decimal (l_list.i_th (4))
				bidirectional_category := l_list.i_th (5)
				character_decomposition_tag := void_if_empty (l_list.i_th (6))
				decimal_digit_value := void_if_empty (l_list.i_th (7))
				digit_value := void_if_empty (l_list.i_th (8))
				numeric_value := void_if_empty (l_list.i_th (9))
				is_mirrored := attached l_list.i_th (10) as l_char and then l_char.count = 1 and then l_char.item (1) = 'Y'
				v1_name := void_if_empty (l_list.i_th (11))
				iso_10646_comment := void_if_empty (l_list.i_th (12))
				upper_code := to_natural (l_list.i_th (13))
				lower_code := to_natural (l_list.i_th (14))
				title_code := to_natural (l_list.i_th (15))
					-- Let's setup our flags
				is_lower := general_category.same_string ("Ll")
				is_upper := general_category.same_string ("Lu")
				is_title := general_category.same_string ("Lt")
				is_digit := general_category.same_string ("Nd")
				if not is_digit and code.is_valid_character_8_code then
					inspect code.to_character_8
					when 'a' .. 'f', 'A' .. 'F' then
						is_hexa_digit := True
					else
						is_hexa_digit := False
					end
				end
				is_punctuation := not general_category.is_empty and then general_category.item (1) = 'P'
				is_control := general_category.same_string ("Cc")
				is_space := (not general_category.is_empty and then general_category.item (1) = 'Z') or
					bidirectional_category.same_string ("WS") or bidirectional_category.same_string ("B") or
					bidirectional_category.same_string ("S")
				category := category_mask [general_category]
			else
				code := 0
				name := ""
				general_category := ""
				canonical_combining_class := 0
				bidirectional_category := ""
				upper_code := 0
				lower_code := 0
				title_code := 0
			end

			is_valid := not name.is_empty and then not general_category.is_empty and then
				not bidirectional_category.is_empty
		end

feature -- Access

	code: NATURAL_32
			-- Value for current character code.

	hexadecimal_code: STRING_8
			-- Hexadecimal representation of `code`.
		do
			Result := hexadecimal_code_point (code)
		end

	name: STRING
			-- Name of the current character.

	v1_name: detachable STRING
			-- Name of the current character in the Unicode 1.0 standard.

	general_category: STRING
			-- Name of the general category of the current character.

	canonical_combining_class: NATURAL_32
			-- Class of the current character for the canonical ordering algorithm.

	bidirectional_category: STRING
			-- Category of the character with respect to the way characters are written
			-- For example in right-to-left languages, numbers will be displayed in left-to-right
			-- order.

	character_decomposition_tag: detachable STRING
			-- Decomposition mapping, and some time they have some tag formatting.
			-- For example some letters have 3 representations
			-- depending if the letter is at the beginning, middle or end of a word. It can be
			-- <font>, <initial>, <final>, ...

	decimal_digit_value: detachable STRING
			-- If current character represents a decimal digit, it is the value of that digit.

	digit_value: detachable STRING
			-- If current charachter represents a digit, it is the value of that digit.

	numeric_value: detachable STRING
			-- If current character has the numeric property then, it is the value of that character.
			-- For example, it could be "1/2", "1/3", "1", ...

	is_mirrored: BOOLEAN
			-- Is current character marked as mirrored for bidirectional text?

	iso_10646_comment: detachable STRING
			-- Comments for the ISO 10646 names.

	upper_code: NATURAL_32
	lower_code: NATURAL_32
	title_code: NATURAL_32
			-- Upper, lower and title case mapping. Mapping is always one to one.
			-- If `0' then it is the character itself.

feature {UNICODE_HELPER_GENERATOR} -- Element change

	set_lower_code (a_code: like lower_code)
			-- Set `lower_code' with `a_code'.
		require
			not_has_lower_code: not has_lower_code
		do
			lower_code := a_code
		ensure
			lower_code_set: lower_code = a_code
		end

	set_upper_code (a_code: like upper_code)
			-- Set `upper_code' with `a_code'.
		require
			not_has_upper_code: not has_upper_code
		do
			upper_code := a_code
		ensure
			upper_code_set: upper_code = a_code
		end

	set_title_code (a_code: like title_code)
			-- Set `title_code' with `a_code'.
		require
			not_has_title_code: not has_title_code
		do
			title_code := a_code
		ensure
			title_code_set: title_code = a_code
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Is Unicode data valid for Current?7

	is_lower: BOOLEAN
			-- Is current character an upper character?

	is_upper: BOOLEAN
			-- Is current character an upper character?

	is_title: BOOLEAN
			-- Is current character an upper character?

	is_digit: BOOLEAN
			-- Is current character a digit?

	is_hexa_digit: BOOLEAN
			-- Is current an hexadecimal digit?

	is_punctuation: BOOLEAN
			-- Is current character a punctuation?

	is_control: BOOLEAN
			-- Is current a control character?

	is_space: BOOLEAN
			-- Is current a space of some sort?

	has_property: BOOLEAN
			-- Does current have one property setup?
		require
			is_valid: is_valid
		do
			Result := is_upper or is_lower or is_title or is_digit or is_hexa_digit or
				is_punctuation or is_control or is_space
		end

	property_flags: NATURAL_32
		require
			is_valid: is_valid
		do
			if is_lower then
				Result := Result | is_lower_flag
			end
			if is_upper then
				Result := Result | is_upper_flag
			end
			if is_title then
				Result := Result | is_title_flag
			end
			if is_digit then
				Result := Result | is_digit_flag
			end
			if is_hexa_digit then
				Result := Result | is_hexa_digit_flag
			end
			if is_punctuation then
				Result := Result | is_punctuation_flag
			end
			if is_control then
				Result := Result | is_control_flag
			end
			if is_space then
				Result := Result | is_space_flag
			end
		end

	has_case: BOOLEAN
			-- Is current character a character with a case?
		require
			is_valid: is_valid
		do
			Result := has_lower_code or has_upper_code or has_title_code
		end

	has_lower_code: BOOLEAN
			-- Does current character have a corresponding lower character code associated with it?
		require
			is_valid: is_valid
		do
			Result := lower_code /= 0 and lower_code /= code
		end

	has_upper_code: BOOLEAN
			-- Does current character have a corresponding upper character code associated with it?
		require
			is_valid: is_valid
		do
			Result := upper_code /= 0 and upper_code /= code
		end

	has_title_code: BOOLEAN
			-- Does current character have a corresponding title character code associated with it?
		require
			is_valid: is_valid
		do
			Result := title_code /= 0 and title_code /= code
		end

feature {NONE} -- Implementation

	void_if_empty (a_string: STRING): detachable STRING
			-- If `a_string' is empty, a Void value, otherwise `a_string' itself
		do
			if not a_string.is_empty then
				Result := a_string
			else
				Result := Void
			end
		ensure
			same_string_if_not_empty: not a_string.is_empty implies Result = a_string
		end

	from_decimal (s: STRING): NATURAL_32
			-- Convert `s` in decimal notation to a NATURAL_32.
			-- If `s` is empty, then `0` as a signaling value that nothing was specified.
		do
			if s.is_empty then
				Result := 0
			else
				decimal_convertor.parse_string_with_type (s, {NUMERIC_INFORMATION}.type_natural_32)
				Result := decimal_convertor.parsed_natural_32
			end
		end

	to_natural (a_string: STRING): NATURAL_32
			-- Convert `a_string` in hexadecimal notation to a NATURAL_32.
			-- If `a_string' is empty, then 0 as a signaling value that nothing was specified.
		do
			if a_string.is_empty then
				Result := 0
			else
				ctoi_convertor.parse_string_with_type (a_string, {NUMERIC_INFORMATION}.type_natural_32)
				Result := ctoi_convertor.parsed_natural_32
			end
		end

	decimal_convertor: STRING_TO_INTEGER_CONVERTOR
			-- Convertor used to convert decimal string to integer or natural.
		once
			create Result.make
			Result.set_leading_separators (" ")
			Result.set_trailing_separators (" ")
			Result.set_leading_separators_acceptable (True)
			Result.set_trailing_separators_acceptable (True)
		ensure
			ctoi_convertor_not_void: Result /= Void
		end

	ctoi_convertor: HEXADECIMAL_STRING_TO_INTEGER_CONVERTER
			-- Convertor used to convert hexadecimal string to integer or natural
		once
			create Result.make
			Result.set_leading_separators (" ")
			Result.set_trailing_separators (" ")
			Result.set_leading_separators_acceptable (True)
			Result.set_trailing_separators_acceptable (True)
		ensure
			ctoi_convertor_not_void: Result /= Void
		end

	is_upper_flag: NATURAL_8 = 0x01
	is_lower_flag: NATURAL_8 = 0x02
	is_title_flag: NATURAL_8 = 0x4
	is_digit_flag: NATURAL_8 = 0x08
	is_punctuation_flag: NATURAL_8 = 0x10
	is_control_flag: NATURAL_8 = 0x20
	is_hexa_digit_flag: NATURAL_8 = 0x40
	is_space_flag: NATURAL_8 = 0x80
			-- Various flags

feature -- General category

	category: NATURAL_32
			-- A bit mask with the bit set for the specific category.

	category_letter_uppercase: NATURAL_32 = 0x0000_0001
	category_letter_lowercase: NATURAL_32 = 0x0000_0002
	category_letter_titlecase: NATURAL_32 = 0x0000_0004
	category_letter_modifier: NATURAL_32 = 0x0000_0008
	category_letter_other: NATURAL_32 = 0x0000_0010

	category_mark_nonspacing: NATURAL_32 = 0x0000_0020
	category_mark_spacing_combining: NATURAL_32 = 0x0000_0040
	category_mark_enclosing: NATURAL_32 = 0x0000_0080

	category_number_decimal_digit: NATURAL_32 = 0x0000_0100
	category_number_letter: NATURAL_32 = 0x0000_0200
	category_number_other: NATURAL_32 = 0x0000_0400

	category_punctuation_connector: NATURAL_32 = 0x0000_0800
	category_punctuation_dash: NATURAL_32 = 0x0000_1000
	category_punctuation_open: NATURAL_32 = 0x0000_2000
	category_punctuation_close: NATURAL_32 = 0x0000_4000
	category_punctuation_initial_quote: NATURAL_32 = 0x0000_8000
	category_punctuation_final_quote: NATURAL_32 = 0x0001_0000
	category_punctuation_other: NATURAL_32 = 0x0002_0000

	category_symbol_math: NATURAL_32 = 0x0004_0000
	category_symbol_currency: NATURAL_32 = 0x0008_0000
	category_symbol_modifier: NATURAL_32 = 0x0010_0000
	category_symbol_other: NATURAL_32 = 0x0020_0000

	category_separator_space: NATURAL_32 = 0x0040_0000
	category_separator_line: NATURAL_32 = 0x0080_0000
	category_separator_paragraph: NATURAL_32 = 0x0100_0000

	category_other_control: NATURAL_32 = 0x0200_0000
	category_other_format: NATURAL_32 = 0x0400_0000
	category_other_surrogate: NATURAL_32 = 0x0800_0000
	category_other_private_use: NATURAL_32 = 0x1000_0000
	category_other_not_assigned: NATURAL_32 = 0x0200_0000

	category_mask: STRING_TABLE [NATURAL_32]
			-- Category mask indexed by its code in the database.
		once
			create Result.make (32)

			Result ["Lu"] := category_letter_uppercase
			Result ["Ll"] := category_letter_lowercase
			Result ["Lt"] := category_letter_titlecase
			Result ["Lm"] := category_letter_modifier
			Result ["Lo"] := category_letter_other

			Result ["Mn"] := category_mark_nonspacing
			Result ["Mc"] := category_mark_spacing_combining
			Result ["Me"] := category_mark_enclosing

			Result ["Nd"] := category_number_decimal_digit
			Result ["Nl"] := category_number_letter
			Result ["No"] := category_number_other

			Result ["Pc"] := category_punctuation_connector
			Result ["Pd"] := category_punctuation_dash
			Result ["Ps"] := category_punctuation_open
			Result ["Pe"] := category_punctuation_close
			Result ["Pi"] := category_punctuation_initial_quote
			Result ["Pf"] := category_punctuation_final_quote
			Result ["Po"] := category_punctuation_other

			Result ["Sm"] := category_symbol_math
			Result ["Sc"] := category_symbol_currency
			Result ["Sk"] := category_symbol_modifier
			Result ["So"] := category_symbol_other

			Result ["Zs"] := category_separator_space
			Result ["Zl"] := category_separator_line
			Result ["Zp"] := category_separator_paragraph

			Result ["Cc"] := category_other_control
			Result ["Cf"] := category_other_format
			Result ["Cs"] := category_other_surrogate
			Result ["Co"] := category_other_private_use
			Result ["Cn"] := category_other_not_assigned
		ensure
			class
		end

feature -- Output

	out: like {ANY}.out
			-- <Precursor>
		do
			Result := hexadecimal_code
			Result.append_character (';')
			Result.append (name)
			Result.append_character (';')
			Result.append (general_category)
			Result.append_character (';')
			Result.append_natural_32 (canonical_combining_class)
			Result.append_character (';')
			Result.append (bidirectional_category)
			Result.append_character (';')
			if attached character_decomposition_tag as s then Result.append (s) end
			Result.append_character (';')
			if attached decimal_digit_value as s then Result.append (s) end
			Result.append_character (';')
			if attached digit_value as s then Result.append (s) end
			Result.append_character (';')
			if attached numeric_value as s then Result.append (s) end
			Result.append_character (';')
			Result.append_character (if is_mirrored then 'Y' else 'N' end)
			Result.append_character (';')
			if attached v1_name as s then Result.append (s) end
			Result.append_character (';')
			if attached iso_10646_comment as s then Result.append (s) end
			Result.append_character (';')
			if upper_code /= 0 then Result.append (hexadecimal_code_point (upper_code)) end
			Result.append_character (';')
			if lower_code /= 0 then Result.append (hexadecimal_code_point (lower_code)) end
			Result.append_character (';')
			if title_code /= 0 then Result.append (hexadecimal_code_point (title_code)) end
		end

	hexadecimal_code_point (n: like code): like code.to_hex_string
			-- Code point `n` as a string with 4 or more hexadecimal digits.
		do
			Result := n.to_hex_string
			Result.keep_tail
				(if n <= 0xFFFF then 4
				elseif n <= 0xF_FFFF then 5
				elseif n <= 0xFF_FFFF then 6
				elseif n <= 0xFFF_FFFF then 7
				else 8
				end)
		ensure
			class
		end

end
