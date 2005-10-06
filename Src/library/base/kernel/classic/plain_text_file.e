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
			is_plain_text
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
			
	overflowed: BOOLEAN
			-- Is last integer/natural read overflowed according to its type?

	too_small: BOOLEAN
			-- Is last integer/natural read overflowed because
			-- number is too small?	
	
	too_large: BOOLEAN
			-- Is last integer/natural read overflowed because
			-- number is too large?	
				
	expected_number_found: BOOLEAN
			-- Has number been found?
			-- Check this after read_integer_x or read_natural_x.			

feature -- Output

	put_integer, putint, put_integer_32 (i: INTEGER) is
			-- Write ASCII value of `i' at current position.
		do
			file_pi (file_pointer, i)
		end
		
	put_integer_64 (i: INTEGER_64) is
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end

	put_integer_16 (i: INTEGER_16) is
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end	
		
	put_integer_8 (i: INTEGER_8) is
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end
		
	put_natural_64 (i: NATURAL_64) is
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end
		
	put_natural, put_natural_32 (i: NATURAL_32) is
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end
				
	put_natural_16 (i: NATURAL_16) is
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end	
		
	put_natural_8 (i: NATURAL_8) is
			-- Write ASCII value of `i' at current position.
		do
			put_string (i.out)
		end			

	put_boolean, putbool (b: BOOLEAN) is
			-- Write ASCII value of `b' at current position.
		local
			ext_bool_str: ANY
		do
			if b then
				ext_bool_str := true_string.to_c
				file_ps (file_pointer, $ext_bool_str, true_string.count)
			else
				ext_bool_str := false_string.to_c
				file_ps (file_pointer, $ext_bool_str, false_string.count)
			end
		end

	put_real, putreal (r: REAL) is
			-- Write ASCII value of `r' at current position.
		do
			file_pr (file_pointer, r)
		end

	put_double, putdouble (d: DOUBLE) is
			-- Write ASCII value `d' at current position.
		do
			file_pd (file_pointer, d)
		end

feature -- Input

--	read_integer, readint, read_integer_32 is
--			-- Read the ASCII representation of a new integer
--			-- from file. Make result available in `last_integer'.
--		do
--			last_integer := file_gi (file_pointer)
--		end
		
	read_integer_64 is
			-- 
		local
			str: STRING
		do
			str := read_integer_with_no_type
			expected_number_found := not str.is_empty
			if expected_number_found then
				last_integer_64 := str.to_integer_64
				overflowed := str.overflowed
				too_large := str.too_large
				too_small := str.too_small
			end
		end
		
	read_integer, readint, read_integer_32 is
			-- 
		local
			str: STRING
		do
			str := read_integer_with_no_type
			expected_number_found := not str.is_empty
			if expected_number_found then
				last_integer := str.to_integer_32
				overflowed := str.overflowed
				too_large := str.too_large
				too_small := str.too_small				
			end
		end
		
	read_integer_16 is
			-- 
		local
			str: STRING
		do
			str := read_integer_with_no_type
			expected_number_found := not str.is_empty
			if expected_number_found then
				last_integer_16 := str.to_integer_16
				overflowed := str.overflowed
				too_large := str.too_large
				too_small := str.too_small				
			end
		end
		
	read_integer_8 is
			-- 
		local
			str: STRING
		do
			str := read_integer_with_no_type
			expected_number_found := not str.is_empty
			if expected_number_found then
				last_integer_8 := str.to_integer_8
				overflowed := str.overflowed
				too_large := str.too_large
				too_small := str.too_small				
			end
		end	
		
	read_natural_64 is
			-- 
		local
			str: STRING
		do
			str := read_integer_with_no_type
			expected_number_found := not str.is_empty
			if expected_number_found then
				last_natural_64 := str.to_natural_64
				overflowed := str.overflowed
				too_large := str.too_large
				too_small := str.too_small
			end
		end
		
	read_natural, read_natural_32 is
			-- 
		local
			str: STRING
		do
			str := read_integer_with_no_type
			expected_number_found := not str.is_empty
			if expected_number_found then
				last_natural := str.to_natural_32
				overflowed := str.overflowed
				too_large := str.too_large
				too_small := str.too_small				
			end
		end
		
	read_natural_16 is
			-- 
		local
			str: STRING
		do
			str := read_integer_with_no_type
			expected_number_found := not str.is_empty
			if expected_number_found then
				last_natural_16 := str.to_natural_16
				overflowed := str.overflowed
				too_large := str.too_large
				too_small := str.too_small				
			end
		end
		
	read_natural_8 is
			-- 
		local
			str: STRING
		do
			str := read_integer_with_no_type
			expected_number_found := not str.is_empty
			if expected_number_found then
				last_natural_8 := str.to_natural_8
				overflowed := str.overflowed
				too_large := str.too_large
				too_small := str.too_small				
			end
		end						

	read_real, readreal is
			-- Read the ASCII representation of a new real
			-- from file. Make result available in `last_real'.
		do
			last_real := file_gr (file_pointer)
		end

	read_double, readdouble is
			-- Read the ASCII representation of a new double
			-- from file. Make result available in `last_double'.
		do
			last_double := file_gd (file_pointer)
		end

feature {NONE} -- Implementation

	ctoi_state_machine: STRING_TO_INTEGER_STATE_MACHINE is
			-- State machine used to parse string to integer or natural
		once
			create Result.make
		end

	platform_indicator: PLATFORM is
			-- Platform indicator
		once
			create Result
		end
		
	read_integer_with_no_type: STRING is
			-- Read a number string start from current position.
		local
			l_is_integer: BOOLEAN
			l_count: INTEGER
			read_count: INTEGER			
		do
			create Result.make (128)
			ctoi_state_machine.reset ({INTEGER_NATURAL_INFORMATION}.type_no_limitation)
					-- We don't allow trailing white spaces be part of a string.
			ctoi_state_machine.set_trailing_white_spaces_acceptable (False)
			from			
				l_is_integer := True
				l_count := 0
			until
				end_of_file or else not l_is_integer
			loop
				read_character
				if not end_of_file then
					read_count := l_count + 1
					Result.extend (last_character)
					ctoi_state_machine.parse (Result, l_count, l_count)
					l_is_integer := ctoi_state_machine.is_part_of_integer
				end
			end

			if not l_is_integer then
					-- We reached a character that can not be parsed as part of an integer.
					l_count := l_count - 1
				if last_character = '%N' then
					if l_count > 0 and then Result.item (l_count).is_digit then
							-- If string before '%N' is an integer or natural
							-- swallow  '%N' character.
						Result.keep_head (l_count)
					elseif l_count = 0 then
							-- If we read nothing before '%N',
							-- swallow '%N'.
						Result.clear_all
					else		
							-- If we read something which can be a valid start part
							-- (but not an integral one) of an integer or natural, 
							-- we move file pointer back to its orginal position.
						Result.clear_all
						file_move (file_pointer, -l_count-1)
						if platform_indicator.is_windows then
							back
						end
					end
				else
					back
					Result.keep_head (l_count)
					if not Result.is_empty and then not Result.item (l_count).is_digit then
						file_move (file_pointer, -l_count)
						Result.clear_all
					end					
				end
			elseif end_of_file then
					-- We reached end of file and the string read so far is a part of an integer.
				if not ctoi_state_machine.is_integral_integer then
					file_move (file_pointer, -Result.count)
					Result.clear_all
				end				
			end
		end

	read_to_string (a_string: STRING; pos, nb: INTEGER): INTEGER is
			-- Fill `a_string', starting at position `pos' with at
			-- most `nb' characters read from current file.
			-- Return the number of characters actually read.
		do
			Result := file_gss (file_pointer, a_string.area.item_address (pos - 1), nb)
		end

	file_gi (file: POINTER): INTEGER is
			-- Get an integer from `file'
		external
			"C (FILE *): EIF_INTEGER | %"eif_file.h%""
		end

	file_gr (file: POINTER): REAL is
			-- Read a real from `file'
		external
			"C (FILE *): EIF_REAL | %"eif_file.h%""
		end

	file_gd (file: POINTER): DOUBLE is
			-- Read a double from `file'
		external
			"C (FILE *): EIF_DOUBLE | %"eif_file.h%""
		end

	file_pi (file: POINTER; n: INTEGER) is
			-- Put `n' to end of `file'.
		external
			"C (FILE *, EIF_INTEGER) | %"eif_file.h%""
		end

	file_pr (file: POINTER; r: REAL) is
			-- Put `r' to end of `file'.
		external
			"C (FILE *, EIF_REAL) | %"eif_file.h%""
		end

	file_pd (file: POINTER; d: DOUBLE) is
			-- Put `d' to end of `file'.
		external
			"C (FILE *, EIF_DOUBLE) | %"eif_file.h%""
		end

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



