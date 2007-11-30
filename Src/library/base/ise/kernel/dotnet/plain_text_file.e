indexing

	description:
		"Files viewed as persistent sequences of ASCII characters"
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
			put_new_line, new_line, put_character, putchar
		end

create

	make, make_open_read, make_open_write, make_open_append,
	make_open_read_write, make_create_read_write,
	make_open_read_append

feature -- Status report

	is_plain_text: BOOLEAN is
			-- Is file reserved for text (character sequences)? (Yes)
		do
			Result := True
		end

	support_storable: BOOLEAN is False
			-- Can medium be used to store an Eiffel structure?

feature -- Output

	put_new_line, new_line is
		local
			i: INTEGER
			l_cnt: INTEGER
		do
			from 
				i := 1
				l_cnt := dotnet_newline.count
			until
				i > l_cnt
			loop
				internal_stream.write_byte (dotnet_newline.item (i).code.to_natural_8)				
				i := i + 1
			end
		end

	put_string (s: STRING) is
			-- Write `s' at current position.
		local
			l_str: STRING
		do
			if s.count /= 0 then
				create l_str.make_from_string (s)
				l_str.replace_substring_all (eiffel_newline, dotnet_newline)
				Precursor (l_str)
			end
		end
		
	putstring (s: STRING) is
			-- Write `s' at current position.
		do
			put_string (s)
		end		

	put_integer, putint, put_integer_32 (i: INTEGER) is
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end
		
	put_integer_8 (i: INTEGER_8) is
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end
		
	put_integer_16 (i: INTEGER_16) is
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end
		
	put_integeR_64 (i: INTEGER_64) is
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end
		
	put_natural_8 (i: NATURAL_8) is
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end
		
	put_natural_16 (i: NATURAL_16) is
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end
		
	put_natural, put_natural_32 (i: NATURAL_32) is
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end
		
	put_natural_64 (i: NATURAL_64) is
			-- Write ASCII value of `i' at current position. 
		do
			put_string (i.out)
		end

	put_boolean, putbool (b: BOOLEAN) is
			-- Write ASCII value of `b' at current position.
		do
			if b then
				put_string (true_string)
			else
				put_string (false_string)
			end
		end

	put_real, putreal (r: REAL) is
			-- Write ASCII value of `r' at current position.
		do
			put_string (r.out)
		end

	put_double, putdouble (d: DOUBLE) is
			-- Write ASCII value `d' at current position.
		do
			put_string (d.out)
		end

	put_character, putchar (c: CHARACTER) is
			-- Write `c' at current position.
		do
			if c = '%N' then
				put_new_line
			else
				internal_stream.write_byte (c.code.to_natural_8)
			end
		end

feature -- Input

	read_stream (nb_char: INTEGER) is
			-- Read a string of at most `nb_char' bound characters
			-- or until end of file.
			-- Make result available in `last_string'.
		do
			Precursor {FILE} (nb_char)
			last_string.replace_substring_all (dotnet_newline, eiffel_newline)
		end
		
	readstream (nb_char: INTEGER) is
			-- Read a string of at most `nb_char' bound characters
			-- or until end of file.
			-- Make result available in `last_string'.
		do
			read_stream (nb_char)
		end

	read_integer_64 is
			-- 
		do
			read_integer_with_no_type
			last_integer_64 := ctoi_convertor.parsed_integer_64
		end
		
	read_integer, readint, read_integer_32 is
			-- Read the ASCII representation of a new 32-bit integer
			-- from file. Make result available in `last_integer'.
		do
			read_integer_with_no_type
			last_integer := ctoi_convertor.parsed_integer_32		
		end
		
	read_integer_16 is
			-- Read the ASCII representation of a new 16-bit integer
			-- from file. Make result available in `last_integer_16'.
		do
			read_integer_with_no_type
			last_integer_16 := ctoi_convertor.parsed_integer_16
		end
		
	read_integer_8 is
			-- Read the ASCII representation of a new 8-bit integer
			-- from file. Make result available in `last_integer_8'. 
		do
			read_integer_with_no_type
			last_integer_8 := ctoi_convertor.parsed_integer_8
		end
		
	read_natural_64 is
			-- Read the ASCII representation of a new 64-bit natural
			-- from file. Make result available in `last_natural_64'.
		do
			read_integer_with_no_type
			last_natural_64 := ctoi_convertor.parsed_natural_64

		end
		
	read_natural, read_natural_32 is
			-- Read the ASCII representation of a new 32-bit natural
			-- from file. Make result available in `last_natural'.
		do
			read_integer_with_no_type
			last_natural := ctoi_convertor.parsed_natural_32
		end
		
	read_natural_16 is
			-- Read the ASCII representation of a new 16-bit natural
			-- from file. Make result available in `last_natural_16'.
		do
			read_integer_with_no_type
			last_natural_16 := ctoi_convertor.parsed_natural_16
		end
		
	read_natural_8 is
			-- Read the ASCII representation of a new 8-bit natural
			-- from file. Make result available in `last_natural_8'.
		do
			read_integer_with_no_type
			last_natural_8 := ctoi_convertor.parsed_natural_8
		end					

	read_real, readreal is
			-- Read the ASCII representation of a new real
			-- from file. Make result available in `last_real'.
		do
			read_double
			last_real := last_double.truncated_to_real
		end

	read_double, readdouble is
			-- Read the ASCII representation of a new double
			-- from file. Make result available in `last_double'.
		do
			read_number_sequence (ctor_convertor, {NUMERIC_INFORMATION}.type_double)
			last_double := ctor_convertor.parsed_double
			if not is_sequence_an_expected_numeric then		
				return_characters								
			end	
		end

	read_character, readchar is
			-- Read a new character.
			-- Make result available in `last_character'.
		local
			a_code: INTEGER
		do
			a_code := internal_stream.read_byte
			if a_code = - 1 then
				internal_end_of_file := True
			else
					-- If we read `%R', i.e. value 13, then let's
					-- check if next character is `%N'. If it is '%N'
					-- then we return '%N', else we return '%R'.
				if a_code = 13 and then peek = 10 then
					a_code := internal_stream.read_byte
				end
				last_character := a_code.to_character_8
			end
		end

feature {NONE} -- Implementation

	ctoi_convertor: STRING_TO_INTEGER_CONVERTOR is
			-- Convertor used to parse string to integer or natural
		once
			create Result.make
			Result.set_leading_separators (internal_leading_separators)
			Result.set_leading_separators_acceptable (True)
			Result.set_trailing_separators_acceptable (False)
		end
		
	ctor_convertor: STRING_TO_REAL_CONVERTOR is
			-- Convertor used to parse string to double or real
		once
			create Result.make
			Result.set_leading_separators (internal_leading_separators)
			Result.set_leading_separators_acceptable (True)	
			Result.set_trailing_separators_acceptable (False)					
		end		
					
	internal_leading_separators: STRING is " %N%R%T"
			-- Characters that are considered as leading separators
			
	is_sequence_an_expected_numeric: BOOLEAN
			-- Is last number sequence read by `read_number_sequence' an expected numeric?

	read_number_sequence (convertor: STRING_TO_NUMERIC_CONVERTOR; conversion_type: INTEGER) is
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
			
	read_integer_with_no_type is
			-- Read a ASCII representation of number of `type'
			-- at current position.
		do
			read_number_sequence (ctoi_convertor, {NUMERIC_INFORMATION}.type_no_limitation)	
			if not is_sequence_an_expected_numeric then
				return_characters	
			end
		end
		
	return_characters is
			-- Return character(s)
		do				
			if last_character = '%N' and platform_indicator.is_windows then
				back
			end
			back																
			internal_end_of_file := peek = -1			
		end		

	read_to_string (a_string: STRING; pos, nb: INTEGER): INTEGER is
			-- Fill `a_string', starting at position `pos' with at
			-- most `nb' characters read from current file.
			-- Return the number of characters actually read.
		local
			i, j: INTEGER
			str_area: NATIVE_ARRAY [NATURAL_8]
		do
			create str_area.make (nb)
			Result := internal_stream.read (str_area, 0, nb)
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

	c_open_modifier: INTEGER is 16384
			-- File should be opened in plain text mode.

invariant

	plain_text: is_plain_text

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



end -- class PLAIN_TEXT_FILE



