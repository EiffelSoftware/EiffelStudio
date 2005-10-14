indexing

	description:
		"Files viewed as persistent sequences of ASCII characters"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class PLAIN_TEXT_FILE

inherit
	FILE
		rename
			index as position
		redefine
			is_plain_text, put_string, putstring,
			read_character, readchar, read_stream, readstream
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

	put_string, putstring (s: STRING) is
			-- Write `s' at current position.
		do
			if s.count /= 0 then			
				writer.write_string (s.to_cil.replace (eiffel_newline, dotnet_newline))					
			end
		end

	put_integer, putint, put_integer_32 (i: INTEGER) is
			-- Write ASCII value of `i' at current position.
		do
			writer.write_integer_32 (i)
		end
		
	put_integer_8 (i: INTEGER_8) is
			-- Write ASCII value of `i' at current position.
		do
			writer.write_string (i.out)
		end
		
	put_integer_16 (i: INTEGER_16) is
			-- Write ASCII value of `i' at current position.
		do
			writer.write_string (i.out)
		end
		
	put_integeR_64 (i: INTEGER_64) is
			-- Write ASCII value of `i' at current position.
		do
			writer.write_integer_64 (i)
		end
		
	put_natural_8 (i: NATURAL_8) is
			-- Write ASCII value of `i' at current position.
		do
			writer.write_string (i.out)
		end
		
	put_natural_16 (i: NATURAL_16) is
			-- Write ASCII value of `i' at current position.
		do
			writer.write_string (i.out)
		end
		
	put_natural, put_natural_32 (i: NATURAL_32) is
			-- Write ASCII value of `i' at current position.
		do
			writer.write_string (i.out)
		end
		
	put_natural_64 (i: NATURAL_64) is
			-- Write ASCII value of `i' at current position. 
		do
			writer.write_string (i.out)
		end

	put_boolean, putbool (b: BOOLEAN) is
			-- Write ASCII value of `b' at current position.
		do
			writer.write (b)
		end

	put_real, putreal (r: REAL) is
			-- Write ASCII value of `r' at current position.
		do
			writer.write_real (r)
		end

	put_double, putdouble (d: DOUBLE) is
			-- Write ASCII value `d' at current position.
		do
			writer.write_double (d)
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
			last_integer_64 := ctoi_state_machine.parsed_integer_64
		end
		
	read_integer, readint, read_integer_32 is
			-- Read the ASCII representation of a new 32-bit integer
			-- from file. Make result available in `last_integer'.
		do
			read_integer_with_no_type
			last_integer := ctoi_state_machine.parsed_integer_32		
		end
		
	read_integer_16 is
			-- Read the ASCII representation of a new 16-bit integer
			-- from file. Make result available in `last_integer_16'.
		do
			read_integer_with_no_type
			last_integer_16 := ctoi_state_machine.parsed_integer_16
		end
		
	read_integer_8 is
			-- Read the ASCII representation of a new 8-bit integer
			-- from file. Make result available in `last_integer_8'. 
		do
			read_integer_with_no_type
			last_integer_8 := ctoi_state_machine.parsed_integer_8
		end
		
	read_natural_64 is
			-- Read the ASCII representation of a new 64-bit natural
			-- from file. Make result available in `last_natural_64'.
		do
			read_integer_with_no_type
			last_natural_64 := ctoi_state_machine.parsed_natural_64

		end
		
	read_natural, read_natural_32 is
			-- Read the ASCII representation of a new 32-bit natural
			-- from file. Make result available in `last_natural'.
		do
			read_integer_with_no_type
			last_natural := ctoi_state_machine.parsed_natural_32
		end
		
	read_natural_16 is
			-- Read the ASCII representation of a new 16-bit natural
			-- from file. Make result available in `last_natural_16'.
		do
			read_integer_with_no_type
			last_natural_16 := ctoi_state_machine.parsed_natural_16
		end
		
	read_natural_8 is
			-- Read the ASCII representation of a new 8-bit natural
			-- from file. Make result available in `last_natural_8'.
		do
			read_integer_with_no_type
			last_natural_8 := ctoi_state_machine.parsed_natural_8
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
			-- Taken from the SmallEiffel distribution:
			--		Copyright (C) 1994-98 LORIA - UHP - CRIN - INRIA - FRANCE
			--		Dominique COLNET and Suzanne COLLIN - colnet@loria.fr
			--		http://SmallEiffel.loria.fr
		local
			state: INTEGER
			sign: BOOLEAN
			l_buf, blanks: STRING
		do
				-- state = 0 : waiting sign or first digit.
				-- state = 1 : sign read, waiting first digit.
				-- state = 2 : in the integral part.
				-- state = 3 : in the fractional part.
				-- state = 4 : end state.
				-- state = 5 : error state.

			from
				blanks := internal_separators
				create l_buf.make (20)
			until
				state >= 4
			loop
				read_character
				inspect
					state
				when 0 then
					if blanks.has (last_character) then
					elseif last_character.is_digit then
						l_buf.extend (last_character)
						state := 2
					elseif last_character = '-' then
						sign := True
						state := 1
					elseif last_character = '+' then
						state := 1
					elseif last_character = '.' then
						l_buf.extend (last_character)
						state := 3
					else
						state := 5
					end
				when 1 then
					if blanks.has (last_character) then
					elseif last_character.is_digit then
						l_buf.extend (last_character)
						state := 2
					else
						state := 5
					end
				when 2 then
					if last_character.is_digit then
						l_buf.extend (last_character)
					elseif last_character = '.' then
						l_buf.extend (last_character)
						state := 3
					else
						state := 4
					end
				else
					if last_character.is_digit then
						l_buf.extend (last_character)
					else
						state := 4
					end
				end
				if end_of_file then
					inspect
						state
					when 2 .. 4 then
						state := 4
					else
						state := 5
					end
				end
			end
			if not end_of_file then
				back
			end

			if state = 5 then
				-- FIXME: Generate an exception here
			end

			if l_buf.count > 0 then
				last_double := l_buf.to_double
			else
				last_double := 0; -- NaN
			end
			if sign then
				last_double := - last_double
			end
			state := internal_stream.read_byte
			if state = -1 then				
				internal_end_of_file := True
			else
				go (position - 1)
			end
		end

	read_character, readchar is
			-- Read a new character.
			-- Make result available in `last_character'.
		local
			a_code: INTEGER
			l_bytes: INTEGER
			l_buffer: NATIVE_ARRAY [NATURAL_8]
		do			
			create l_buffer.make (1)
			l_bytes := internal_stream.read (l_buffer, 0, 1)
			a_code := l_buffer.item (0)
			if a_code = 0 then
				internal_end_of_file := True
			else
					-- If we read `%R', i.e. value 13, then let's
					-- check if next character is `%N'. If it is '%N'
					-- then we return '%N', else we return '%R'.
				if a_code = 13 then
					l_bytes := internal_stream.read (l_buffer, 0, 1)
					a_code := l_buffer.item (0)
					if a_code /= 10 then						
						a_code := 13
						back
					end
				end
				last_character := a_code.to_character
			end
		end
	
feature {NONE} -- Implementation

	internal_state_machine: STRING_TO_INTEGER_STATE_MACHINE
			-- Internal state machine used to parse string to integer or natural

	ctoi_state_machine: STRING_TO_INTEGER_STATE_MACHINE is
			-- State machine used to parse string to integer or natural
		do
			if internal_state_machine = Void then
				create internal_state_machine.make
				internal_state_machine.set_leading_separators (internal_leading_separators)
			end
			Result := internal_state_machine
		end

	platform_indicator: PLATFORM is
			-- Platform indicator
		once
			create Result
		end
					
	internal_leading_separators: STRING is
			-- 
		do
			Result := " %N%T"
		end	
			
	read_integer_with_no_type is
			-- Read a ASCII representation of number of `type'
			-- at current position.
		local
			l_is_integer: BOOLEAN
			cnt: INTEGER
		do
			l_is_integer := True
			ctoi_state_machine.reset ({INTEGER_NATURAL_INFORMATION}.type_no_limitation)
			internal_state_machine.set_trailing_separators_acceptable (False)
			
			from			
				l_is_integer := True
				cnt := 0
			until
				end_of_file or else not l_is_integer
			loop
				read_character
				if not end_of_file then
					ctoi_state_machine.parse_character (last_character)
					l_is_integer := ctoi_state_machine.is_part_of_integer
				end
			end
			
			if not l_is_integer then		
				if last_character = '%N' and platform_indicator.is_windows then
					back
				end
				back								
			end				
		end
		
	read_to_string (a_string: STRING; pos, nb: INTEGER): INTEGER is
			-- Fill `a_string', starting at position `pos' with at
			-- most `nb' characters read from current file.
			-- Return the number of characters actually read.
		local		
			l_pos, i, j: INTEGER			
		do
			l_pos := position
			i := internal_stream.read_byte
			if i = -1 then				
				internal_end_of_file := True			
			end
			back
			from
				i := 0
				j := pos
			until
				i = nb or end_of_file
			loop
				read_character
				if not end_of_file then					
					a_string.replace_substring (last_character.out, j, j + 1)
				end				
				i := i + 1
				j := j + 1
			end
			go (l_pos)
		end

	c_open_modifier: INTEGER is 16384
			-- File should be opened in plain text mode.

	eiffel_newline: STRING is "%N"
			-- Representation of Eiffel `%N' character as a SYSTEM_STRING.
			
	dotnet_newline: STRING is "%R%N"
			-- Representation of a .NET newline as a SYSTEM_STRING.

invariant

	plain_text: is_plain_text

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class PLAIN_TEXT_FILE



