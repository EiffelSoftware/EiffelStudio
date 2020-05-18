note

	description: "Files viewed as persistent sequences of ASCII characters."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PLAIN_TEXT_FILE

inherit
	FILE
		rename
			index as position
		redefine
			is_plain_text, put_string, putstring,
			read_character, readchar, read_stream, readstream,
			put_new_line, new_line, put_character, putchar,
			set_name, set_path
		end

create
	make, make_with_path,
	make_with_name, make_open_read, make_open_write, make_open_append,
	make_open_read_write, make_create_read_write,
	make_open_read_append,
	make_open_temporary, make_open_temporary_with_prefix

feature -- Initialization

	initialize_encoding
			-- Initialize the associated `encoding`.
		do
			encoding := {SYSTEM_ENCODINGS}.utf8
			create last_string_32.make_empty
		end

feature -- Status report

	is_plain_text: BOOLEAN
			-- Is file reserved for text (character sequences)? (Yes)
		do
			Result := True
		end

	support_storable: BOOLEAN = False
			-- Can medium be used to store an Eiffel structure?

feature -- Output

	put_new_line, new_line
		local
			i: INTEGER
			l_cnt: INTEGER
		do
			if attached internal_stream as l_stream then
				from
					i := 1
					l_cnt := dotnet_newline.count
				until
					i > l_cnt
				loop
					l_stream.write_byte (dotnet_newline.item (i).code.to_natural_8)
					i := i + 1
				end
			end
		end

	put_string (s: READABLE_STRING_8)
			-- Write `s' at current position.
		local
			l_str: STRING
		do
			if s.has ('%N') then
				create l_str.make_from_string (s)
				l_str.replace_substring_all (eiffel_newline, dotnet_newline)
				Precursor (l_str)
			else
				Precursor (s)
			end
		end

	putstring (s: READABLE_STRING_8)
			-- Write `s' at current position.
		do
			put_string (s)
		end

	put_string_32 (s: READABLE_STRING_32)
			-- Write Unicode string `s` at current position.
		require
			extendible: extendible
			non_void: s /= Void
		local
			str: STRING
			utf32, utf8: ENCODING
			l_encoding: like encoding
		do
			l_encoding := encoding
			utf32 := {SYSTEM_ENCODINGS}.utf32
			utf32.convert_to (l_encoding, s)
			if utf32.last_conversion_successful then
				str := utf32.last_converted_string_8
			else
					-- This is a hack, since some OSes don't support convertion from/to UTF-32 to `a_console_encoding'.
					-- We convert UTF-32 to UTF-8 first, then convert UTF-8 to `a_console_encoding'.
				utf8 := {SYSTEM_ENCODINGS}.utf8
				utf32.convert_to (utf8, s)
				if utf32.last_conversion_successful then
					str := utf32.last_converted_string_8
					if not utf8.same_as (l_encoding) then
						utf8.convert_to (l_encoding, str)
						if utf8.last_conversion_successful then
							str := utf8.last_converted_string_8
						end
					end
				elseif s.is_valid_as_string_8 then
					str := s.to_string_8
				else
						-- Fallback to UTF-8.
					str := {UTF_CONVERTER}.string_32_to_utf_8_string_8 (s)
				end
			end
			put_string (str)
		end

	put_integer, putint, put_integer_32 (i: INTEGER)
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end

	put_integer_8 (i: INTEGER_8)
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end

	put_integer_16 (i: INTEGER_16)
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end

	put_integeR_64 (i: INTEGER_64)
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end

	put_natural_8 (i: NATURAL_8)
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end

	put_natural_16 (i: NATURAL_16)
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end

	put_natural, put_natural_32 (i: NATURAL_32)
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end

	put_natural_64 (i: NATURAL_64)
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end

	put_boolean, putbool (b: BOOLEAN)
			-- Write ASCII value of `b' at current position.
		do
			put_string (if b then true_string else false_string end)
		end

	put_real, putreal, put_real_32 (r: REAL_32)
			-- Write ASCII value of `r' at current position.
		do
			put_string (r.out)
		end

	put_double, putdouble, put_real_64 (d: REAL_64)
			-- Write ASCII value `d' at current position.
		do
			put_string (d.out)
		end

	put_character, putchar (c: CHARACTER)
			-- Write `c' at current position.
		do
			if c = '%N' then
				put_new_line
			elseif attached internal_stream as l_stream then
				l_stream.write_byte (c.code.to_natural_8)
			end
		end

feature -- Input

	read_stream (nb_char: INTEGER)
			-- Read a string of at most `nb_char' bound characters
			-- or until end of file.
			-- Make result available in `last_string'.
		local
			l_last_string: like last_string
		do
			Precursor {FILE} (nb_char)
			l_last_string := last_string
			check l_last_string_attached: l_last_string /= Void end
			l_last_string.replace_substring_all (dotnet_newline, eiffel_newline)
		end

	readstream (nb_char: INTEGER)
			-- Read a string of at most `nb_char' bound characters
			-- or until end of file.
			-- Make result available in `last_string'.
		do
			read_stream (nb_char)
		end

	read_integer_64
			--
		do
			read_integer_with_no_type
			last_integer_64 := ctoi_convertor.parsed_integer_64
		end

	read_integer, readint, read_integer_32
			-- Read the ASCII representation of a new 32-bit integer
			-- from file. Make result available in `last_integer'.
		do
			read_integer_with_no_type
			last_integer := ctoi_convertor.parsed_integer_32
		end

	read_integer_16
			-- Read the ASCII representation of a new 16-bit integer
			-- from file. Make result available in `last_integer_16'.
		do
			read_integer_with_no_type
			last_integer_16 := ctoi_convertor.parsed_integer_16
		end

	read_integer_8
			-- Read the ASCII representation of a new 8-bit integer
			-- from file. Make result available in `last_integer_8'.
		do
			read_integer_with_no_type
			last_integer_8 := ctoi_convertor.parsed_integer_8
		end

	read_natural_64
			-- Read the ASCII representation of a new 64-bit natural
			-- from file. Make result available in `last_natural_64'.
		do
			read_integer_with_no_type
			last_natural_64 := ctoi_convertor.parsed_natural_64

		end

	read_natural, read_natural_32
			-- Read the ASCII representation of a new 32-bit natural
			-- from file. Make result available in `last_natural'.
		do
			read_integer_with_no_type
			last_natural := ctoi_convertor.parsed_natural_32
		end

	read_natural_16
			-- Read the ASCII representation of a new 16-bit natural
			-- from file. Make result available in `last_natural_16'.
		do
			read_integer_with_no_type
			last_natural_16 := ctoi_convertor.parsed_natural_16
		end

	read_natural_8
			-- Read the ASCII representation of a new 8-bit natural
			-- from file. Make result available in `last_natural_8'.
		do
			read_integer_with_no_type
			last_natural_8 := ctoi_convertor.parsed_natural_8
		end

	read_real, readreal, read_real_32
			-- Read the ASCII representation of a new real
			-- from file. Make result available in `last_real'.
		do
			read_double
			last_real := last_double.truncated_to_real
		end

	read_double, readdouble, read_real_64
			-- Read the ASCII representation of a new double
			-- from file. Make result available in `last_double'.
		do
			read_number_sequence (ctor_convertor, {NUMERIC_INFORMATION}.type_double)
			last_double := ctor_convertor.parsed_double
			if not is_sequence_an_expected_numeric then
				return_characters
			end
		end

	read_character, readchar
			-- Read a new character.
			-- Make result available in `last_character'.
		local
			a_code: INTEGER
		do
			if attached internal_stream as l_stream then
				a_code := l_stream.read_byte
				if a_code = - 1 then
					internal_end_of_file := True
				else
						-- If we read `%R', i.e. value 13, then let's
						-- check if next character is `%N'. If it is '%N'
						-- then we return '%N', else we return '%R'.
					if a_code = 13 and then peek = 10 then
						a_code := l_stream.read_byte
					end
					last_character := a_code.to_character_8
				end
			end
		end

	read_to_string (a_string: STRING; pos, nb: INTEGER): INTEGER
			-- Fill `a_string', starting at position `pos' with at
			-- most `nb' characters read from current file.
			-- Return the number of characters actually read.
		local
			i, j: INTEGER
			str_area: NATIVE_ARRAY [NATURAL_8]
		do
			create str_area.make (nb)
			if attached internal_stream as l_stream then
				Result := l_stream.read (str_area, 0, nb)
			end
			internal_end_of_file := peek = -1
			from
				i := 0
				j := pos
			until
				i >= Result
			loop
				a_string.put (str_area.item (i).to_character_8, j)
				i := i + 1
				j := j + 1
			end
		end

feature -- Unicode input

	last_string_32: STRING_32
			-- Last unicode string read.

	read_unicode_line
			-- Read a line as STRING_32.
		local
			utf32: ENCODING
		do
			read_line
			utf32 := {SYSTEM_ENCODINGS}.utf32
			encoding.convert_to (utf32, last_string)
			if encoding.last_conversion_successful then
				last_string_32.wipe_out
				last_string_32.append (encoding.last_converted_string_32)
			end
		end

feature -- Encoding

	encoding: ENCODING
			-- Associated encoding.

	set_encoding (enc: like encoding)
			-- Set associated `encoding` with `enc`.
		do
			encoding := enc
		end

	set_utf8_encoding
			-- Set `encoding` to UTF-8.
		do
			encoding := {SYSTEM_ENCODINGS}.utf8
		end

	detect_encoding
			-- Detect and update `encoding` according to BOM detection.
		require
			is_open_read
		local
			pos: like position
			c1,c2,c3,c4: CHARACTER
		do
				--| See https://en.wikipedia.org/wiki/Byte_order_mark
			pos := position
			start
			if readable then
				read_character
				c1 := last_character
				inspect c1
				when '%/0xEF/' then
					if readable then
						read_character
						c2 := last_character
						if c2 = '%/0xBB/' then
							if readable then
								read_character
								c3 := last_character
								if c3 = '%/0xBF/' then
										-- EF BB BF
									encoding := {SYSTEM_ENCODINGS}.utf8
								else
									back
								end
							end
						else
							back
						end
					end
				when '%/0xFF/' then
					if readable then
						read_character
						c2 := last_character
						if c2 = '%/0xFE/' then
							if readable then
								read_character
								c3 := last_character
								if readable then
									read_character
									c4 := last_character
								end
								if c3 = '%U' and c4 = '%U'then
										-- FF FE 00 00
									create encoding.make ({CODE_PAGE_CONSTANTS}.utf32_le)
								else
									-- FF FE
									create encoding.make ({CODE_PAGE_CONSTANTS}.utf16_le)
									back
									back
								end
							end
						else
							back
						end
					end
				when '%/0xFE/' then
					if readable then
						read_character
						c2 := last_character
						if c2 = '%/0xFF/' then
								-- FE FF
							create encoding.make ({CODE_PAGE_CONSTANTS}.utf16_be)
						else
							back
						end
					end
				when '%U' then
					if readable then
						read_character
						c2 := last_character
						if c2 = '%U' then
							if readable then
								read_character
								c3 := last_character
								if c3 = '%/0xFE/' then
									if readable then
										read_character
										c4 := last_character
										if c4 = '%/0xFF/' then
												-- 00 00 FE FF
											create encoding.make ({CODE_PAGE_CONSTANTS}.utf32_be)
										else
											back
										end
									end
								else
									back
								end
							end
						else
							back
						end
					end
				else
					back
				end
			end
			if pos /= 0 then
				go (pos)
			end
		end

	put_encoding_bom
			-- Put Byte Order Mark (BOM) related to `encoding`.
		require
			is_open_write: is_open_write
			at_beginning: position = 0
		local
			cp: READABLE_STRING_8
		do
			cp := encoding.code_page
			if cp.is_case_insensitive_equal_general ({CODE_PAGE_CONSTANTS}.utf8) then
				put_character ('%/0xEF/')
				put_character ('%/0xBB/')
				put_character ('%/0xBF/')
			elseif cp.is_case_insensitive_equal_general ({CODE_PAGE_CONSTANTS}.utf16_le) then
				put_character ('%/0xFF/')
				put_character ('%/0xFE/')
			elseif cp.is_case_insensitive_equal_general ({CODE_PAGE_CONSTANTS}.utf16_be) then
				put_character ('%/0xFE/')
				put_character ('%/0xFF/')
			elseif cp.is_case_insensitive_equal_general ({CODE_PAGE_CONSTANTS}.utf32_le) then
				put_character ('%/0xFF/')
				put_character ('%/0xFE/')
				put_character ('%U')
				put_character ('%U')
			elseif cp.is_case_insensitive_equal_general ({CODE_PAGE_CONSTANTS}.utf32_be) then
				put_character ('%U')
				put_character ('%U')
				put_character ('%/0xFE/')
				put_character ('%/0xFF/')
			end
		end

feature {NONE} -- Implementation

	ctoi_convertor: STRING_TO_INTEGER_CONVERTOR
			-- Convertor used to parse string to integer or natural
		once
			create Result.make
			Result.set_leading_separators (internal_leading_separators)
			Result.set_leading_separators_acceptable (True)
			Result.set_trailing_separators_acceptable (False)
		end

	ctor_convertor: STRING_TO_REAL_CONVERTOR
			-- Convertor used to parse string to double or real
		once
			create Result.make
			Result.set_leading_separators (internal_leading_separators)
			Result.set_leading_separators_acceptable (True)
			Result.set_trailing_separators_acceptable (False)
		end

	internal_leading_separators: STRING = " %N%R%T"
			-- Characters that are considered as leading separators

	is_sequence_an_expected_numeric: BOOLEAN
			-- Is last number sequence read by `read_number_sequence' an expected numeric?

	read_number_sequence (convertor: STRING_TO_NUMERIC_CONVERTOR; conversion_type: INTEGER)
			-- Read a number sequence from current position and parse this
			-- sequence using `convertor' to see if it is a valid numeric.
			-- Set `is_sequence_an_expected_numeric' with True if it is valid.
		do
			convertor.reset (conversion_type)
			from
				is_sequence_an_expected_numeric := True
			until
				end_of_file or else not is_sequence_an_expected_numeric
			loop
				read_character
				if not end_of_file then
					convertor.parse_character (last_character)
					is_sequence_an_expected_numeric := convertor.parse_successful
				end
			end
		end

	read_integer_with_no_type
			-- Read a ASCII representation of number of `type'
			-- at current position.
		do
			read_number_sequence (ctoi_convertor, {NUMERIC_INFORMATION}.type_no_limitation)
			if not is_sequence_an_expected_numeric then
				return_characters
			end
		end

	return_characters
			-- Return character(s)
		do
			if last_character = '%N' and {PLATFORM}.is_windows then
				back
			end
			back
			internal_end_of_file := peek = -1
		end

	c_open_modifier: INTEGER = 16384
			-- File should be opened in plain text mode.

feature {NONE} -- Implementation

	set_name (a_name: READABLE_STRING_GENERAL)
			-- Set `name' with `a_name'.
		do
			Precursor (a_name)
			initialize_encoding
		end

	set_path (a_path: PATH)
			-- Set `internal_name_pointer' with a content matching `a_path'.
		do
			Precursor (a_path)
			initialize_encoding
		end

invariant

	plain_text: is_plain_text

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
