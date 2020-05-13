note
	description: "[
			Representation for byte array (item value between 0 and 255).
			Could be useful in protocol, encoding, ... computations.
			
			It provides useful representations as hex, bin, and also generic base N representation ...
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	BYTE_ARRAY_CONVERTER

inherit
	ITERABLE [NATURAL_8]

	READABLE_INDEXABLE [NATURAL_8]
		rename
			upper as count
		end

create
	make,
	make_from_string,
	make_from_hex_string,
	make_from_bin_string,
	make_from_base_n_string,
	make_from_natural_32,
	make_from_natural_64


convert
	to_natural_64: {NATURAL_64} ,
	to_natural_8_special: {SPECIAL [NATURAL_8]}

feature {NONE} -- Initialization

	make (nb: INTEGER)
			-- Create current byte array with a capacity of `nb' items.
		do
			create string.make (nb)
		end

	make_from_string (s: READABLE_STRING_8)
			-- Create current byte array from string, i.e an array of character 8 values, i.e from 0 to 255.
		do
			string := s.to_string_8
		end

	make_from_hex_string (hex: READABLE_STRING_8)
			-- Create Current byte array from hexadecimal representation of byte array `hex'.
			-- each item is represented by 2 hexadecimal characters, that represents a byte from 0 to 255
			-- i.e from 00 to FF.
		do
			make_from_base_n_string (hex, 16, 2)
		end

	make_from_bin_string (a_bin_string: READABLE_STRING_8)
			-- Create Current byte array from binary representation of byte array `a_bin_string'.
			-- each item is represented by 8 bin characters, for a value between 0 to 255
			-- i.e from 0000 0000 to 1111 1111.
		local
			i,j,n: INTEGER
			s: STRING
			f, v: NATURAL_8
		do
			n := a_bin_string.count
			create s.make (n // 8)
			string := s
			from
				i := n
			until
				i <= 0
			loop
				v := 0
				from
					j := 1
					f := 1
				until
					j > 8 or i < 1
				loop
					if a_bin_string [i] = '1' then
						v := v + f -- * 1
					end
					f := f * 2 -- base = 2
					j := j + 1
					i := i - 1
				end
				s.prepend_character (v.to_character_8)
			end
		end

	make_from_base_n_string (a_base_string: READABLE_STRING_8; a_base: NATURAL_8; a_char_len: INTEGER)
			-- Create Current byte array from base representation of byte array `a_base_string'.
			-- each item is represented by `a_char_len' characters, for a value between 0 to 255
		require
			char_len_big_enough: a_char_len >= number_of_characters_required_for_base_n_representation (255, a_base)
		local
			i,j,n: INTEGER
			s: STRING
			v: NATURAL_8
			f: NATURAL_8
		do
			n := a_base_string.count
			create s.make (n // a_char_len)
			string := s
			from
				i := n
			until
				i <= 0
			loop
				v := 0
				from
					j := 1
					f := 1
				until
					j > a_char_len or i < 1
				loop
					v := v + base_n_character_to_natural (a_base_string [i]) * f
					f := f * a_base
					j := j + 1
					i := i - 1
				end
				s.prepend_character (v.to_character_8)
			end
		end

	make_from_natural_32 (nb: INTEGER; a_natural: NATURAL_32)
			-- Create Current byte array representing `a_natural` on at least `nb` items.
		local
			v: NATURAL_32
			byte: NATURAL_8
		do
			make (0)
			from
				v := a_natural
			until
				v = 0
			loop
				byte := (v & 0b1111_1111).to_natural_8
				v := v.bit_shift_right (8)
				prepend (byte)
			end
			from
			until
				count >= nb
			loop
				prepend (0)
			end
		end

	make_from_natural_64 (nb: INTEGER; a_natural: NATURAL_64)
			-- Create Current byte array representing `a_natural` on at least `nb` items.
		local
			v: NATURAL_64
			byte: NATURAL_8
		do
			make (0)
			from
				v := a_natural
			until
				v = 0
			loop
				byte := (v & 0b1111_1111).to_natural_8
				v := v.bit_shift_right (8)
				prepend (byte)
			end
			from
			until
				count >= nb
			loop
				prepend (0)
			end
		end

feature -- Access

	lower: INTEGER = 1
			-- Lower index;

	count: INTEGER
			-- Count of items.
			-- (also knows as upper).
		do
			Result := string.count
		end

	natural_8_item, item alias "[]" (i: INTEGER): NATURAL_8
			-- Item at index `i' represented as natural value.		
		do
			Result := string.item_code (i).as_natural_8
		end

	string: STRING_8
			-- String representation of Current byte array.
			-- Each natural 8 item is represented by the associated character with same code.

feature -- Element change

	prepend (a_byte: NATURAL_8)
			-- Prepend `a_byte' to Current byte array.
		do
			string.prepend_character (a_byte.to_character_8)
		end

	extend (a_byte: NATURAL_8)
			-- Extend `a_byte' to Curren byte array.
		do
			string.append_character (a_byte.to_character_8)
		end

	insert_byte (a_byte: NATURAL_8; i: INTEGER)
			-- Insert `a_byte' at index `i', shifting bytes between ranks
			-- `i' and `count' rightwards.
		require
			valid_insertion_index: 1 <= i and i <= count + 1
		do
			string.insert_character (a_byte.to_character_8, i)
		end

	remove (i: INTEGER)
			-- Remove `i'-th byte.
		require
			valid_index: valid_index (i)
		do
			string.remove (i)
		end

	remove_sub_array (start_index, end_index: INTEGER)
			-- Remove all bytes from `start_index' to `end_index' inclusive.	
		require
			valid_start_index: 1 <= start_index
			valid_end_index: end_index <= count
			meaningful_interval: start_index <= end_index + 1
		do
			string.remove_substring (start_index, end_index)
		end

	append (a_byte_array: BYTE_ARRAY_CONVERTER)
		do
			append_bytes (a_byte_array)
		end

	append_bytes (a_bytes: ITERABLE [NATURAL_8])
		do
			across
				a_bytes as ic
			loop
				extend (ic.item)
			end
		end

	sub_array (start_index, end_index: INTEGER): like Current
		require
			valid_start_index: 1 <= start_index
			valid_end_index: end_index <= count
			meaningful_interval: start_index <= end_index + 1
		do
			create Result.make_from_string (string.substring (start_index, end_index))
		end

feature -- Access and item representations.

	integer_8_item (i: INTEGER): INTEGER_8
			-- Item at index `i' represented as integer value from -128 to 127.
		require
			valid_index: valid_index (i)
		local
			n8: like natural_8_item
		do
			n8 := natural_8_item (i)
			if n8 >= 128 then
                Result := (-256 + n8.as_integer_32).to_integer_8
            else
                Result := n8.to_integer_8
            end
		end

	base_n_item (i: INTEGER; a_base: NATURAL_8; a_char_len: INTEGER): STRING_8
			-- Item at index `i' represented with base `a_base' and using `a_char_len' characters.
			-- Support base from 2 to 10  (bin to decimal).
		require
			valid_index: valid_index (i)
			accepted_base: 2 <= a_base and then a_base <= 36
			char_len_big_enough: a_char_len >= number_of_characters_required_for_base_n_representation (255, a_base)
		local
			n8: NATURAL_8
			q8: NATURAL_8
		do
			n8 := natural_8_item (i)
			create Result.make (a_char_len)
			from
			until
				n8 = 0
			loop
				if n8 < a_base then
					prepend_based_natural_8_to (n8, a_base, Result)
					n8 := 0
				else
					q8 := n8 // a_base
					prepend_based_natural_8_to (n8 - q8 * a_base, a_base, Result)
					n8 := q8
				end
			end
			if Result.count < a_char_len then
				from
				until
					Result.count >= a_char_len
				loop
					Result.prepend_character ('0')
				end
			end
		end

	hex_item (i: INTEGER): STRING_8
			-- Item at index `i' represented as hexadecimal value.
		require
			valid_index: valid_index (i)
		do
			Result := item (i).to_hex_string
			if Result.count = 1 then
				Result.prepend_character ('0')
			end
		end

	oct_item (i: INTEGER): STRING_8
			-- Item at index `i' represented as octal value on 3 characters.	
		require
			valid_index: valid_index (i)
		do
			Result := base_n_item (i, 8, 3)
		end

	bin_item (i: INTEGER): STRING_8
			-- Item at index `i' represented as binary value on 8 characters.	
		require
			valid_index: valid_index (i)
		local
			n8: NATURAL_8
			j,v: INTEGER
		do
			n8 := natural_8_item (i)
			create Result.make_filled ('0', 8)
			from
				j := 8
				v := 128 -- 2 ^ 7
			until
				j = 0
			loop
				if n8 & v = v then
					Result [8 - j + 1] := '1'
				else
					Result [8 - j + 1] := '0'
				end
				v := v // 2
				j := j - 1
			end
		end

feature -- Status report

	valid_index (i: INTEGER): BOOLEAN
			-- Is `i' a valid index?
		do
			Result := 1 <= i and i <= count
		end

feature -- Conversion

	to_natural_64: NATURAL_64
			-- Natural 64 representation of Current.
		local
			nb: INTEGER
		do
			nb := 0
			across
				new_cursor.reversed as ic
			loop
				Result := Result | ic.item.as_natural_64.bit_shift_left (nb)
				nb := nb + 8
			end
		end

	to_natural_8_special: SPECIAL [NATURAL_8]
			-- SPECIAL 8 array representation of Current.
			-- following format of `natural_8_item'.
		local
			i,n: INTEGER
		do
			from
				i := 1
				n := count
				create Result.make_filled ({NATURAL_8} 0, n)
			until
				i > n
			loop
				Result.put (natural_8_item (i), i - 1)
				i := i + 1
			end
		end

	to_natural_8_array: ARRAY [NATURAL_8]
			-- Natural 8 array representation of Current.
			-- following format of `natural_8_item'.
		local
			i,n: INTEGER
		do
			from
				i := 1
				n := count
				create Result.make_filled ({NATURAL_8} 0, i, n)
			until
				i > n
			loop
				Result[i] := natural_8_item (i)
				i := i + 1
			end
		end

	to_integer_8_array: ARRAY [INTEGER_8]
			-- Integer 8 array representation of Current.
			-- following format of `integer_8_item'.
		local
			i,n: INTEGER
		do
			from
				i := 1
				n := count
				create Result.make_filled ({INTEGER_8} 0, i, n)
			until
				i > n
			loop
				Result[i] := integer_8_item (i)
				i := i + 1
			end
		end

feature -- Conversion settings

	is_lower_case: BOOLEAN
			-- Using lower case of string generation (default).
		do
			Result := not is_upper_case
		end

	is_upper_case: BOOLEAN
			-- Using upper case of string generation.

	string_output_item_separator: detachable READABLE_STRING_8
			-- Optional item separator in string output representations.

feature -- Conversion settings change

	use_lower_case
			-- String generation is using lowercase letters.
			-- relevant for encoding with base > 10.
			-- Default.
		do
			is_upper_case := False
		end

	use_upper_case
			-- String generation is using uppercase letters.	
			-- relevant for encoding with base > 10.
		do
			is_upper_case := True
		end

	set_string_output_item_separator (s: detachable READABLE_STRING_8)
			-- Set optional item separator in string output representations `string_output_item_separator' to `s'.
		do
			string_output_item_separator := s
		end

feature -- Conversion to string

	append_hex_string_to (a_string: STRING_GENERAL)
			-- Append to `a_string' the byte array representation with sequence of 2 hexadecimal characters.		
		local
			i,n: INTEGER
			s: like string_output_item_separator
		do
			s := string_output_item_separator
			from
				i := 1
				n := count
			until
				i > n
			loop
				if s /= Void and i > 1 then
					a_string.append (s)
				end
				a_string.append (hex_item (i))
				i := i + 1
			end
		end

	append_dec_string_to (a_string: STRING_GENERAL)
			-- Append to `a_string' the byte array representation with sequence of 3 decimal characters.		
		do
			append_base_n_string_to (a_string, 10, 3)
		end

	append_oct_string_to (a_string: STRING_GENERAL)
			-- Append to `a_string' the byte array representation with sequence of 3 octal characters.		
		do
			append_base_n_string_to (a_string, 8, 3)
		end

	append_bin_string_to (a_string: STRING_GENERAL)
			-- Append to `a_string' the byte array representation with sequence of 8 binary characters.		
		local
			i,n: INTEGER
			s: like string_output_item_separator
		do
			s := string_output_item_separator
			from
				i := 1
				n := count
			until
				i > n
			loop
				if s /= Void and i > 1 then
					a_string.append (s)
				end

				a_string.append (bin_item (i))
				i := i + 1
			end
		end

	append_base_n_string_to (a_string: STRING_GENERAL; a_base: NATURAL_8; a_char_len: INTEGER)
			-- Append to `a_string' the byte array representation with sequence of `a_char_len' characters formatted with base `a_base'.		
		require
			char_len_big_enough: a_char_len >= number_of_characters_required_for_base_n_representation (255, a_base)
			accepted_base: 2 <= a_base and then a_base <= 36
		local
			i,n: INTEGER
			s: like string_output_item_separator
		do
			s := string_output_item_separator
			from
				i := 1
				n := count
			until
				i > n
			loop
				if s /= Void and i > 1 then
					a_string.append (s)
				end
				a_string.append (base_n_item (i, a_base, a_char_len))
				i := i + 1
			end
		end

	to_hex_string: STRING_8
			-- Byte array representation with sequence of 2 hexadecimal characters.		
		do
			create Result.make (2 * count)
			append_hex_string_to (Result)
		end

	to_dec_string: STRING_8
			-- Byte array representation with sequence of 3 decimal characters.
		do
			Result := to_base_n_string (10, 3)
		end

	to_oct_string: STRING_8
			-- Byte array representation with sequence of 3 octal characters.			
		do
			Result := to_base_n_string (8, 3)
		end

	to_bin_string: STRING_8
			-- Byte array representation with sequence of 8 binary characters.
		do
			create Result.make (2 * count)
			append_bin_string_to (Result)
		ensure
			across Result as ic all ic.item = '0' or ic.item = '1' or (attached string_output_item_separator as s and then s.has (ic.item)) end
		end

	to_base_n_string (a_base: NATURAL_8; a_char_len: INTEGER): STRING_8
			-- Byte array representation with sequence of `a_char_len' characters formatted with base `a_base'.		
		require
			char_len_big_enough: a_char_len >= number_of_characters_required_for_base_n_representation (255, a_base)
			accepted_base: 2 <= a_base and then a_base <= 36
		do
			create Result.make (a_char_len * count)
			append_base_n_string_to (Result, a_base, a_char_len)
		end

	to_base_n_string_with_separator (a_base: NATURAL_8; a_char_len: INTEGER; sep: READABLE_STRING_8): STRING_8
			-- Byte array representation with sequence of `a_char_len' characters formatted with base `a_base'.		
		require
			char_len_big_enough: a_char_len >= number_of_characters_required_for_base_n_representation (255, a_base)
			accepted_base: 2 <= a_base and then a_base <= 36
		local
			l_old_sep: like string_output_item_separator
		do
			l_old_sep := string_output_item_separator
			set_string_output_item_separator (sep)
			Result := to_base_n_string (a_base, a_char_len)
			set_string_output_item_separator (l_old_sep)
		end

feature -- Helpers

	number_of_characters_required_for_base_n_representation (a_value: NATURAL_8; a_base: NATURAL_8): NATURAL_8
			-- Number of character needed to represent `a_value' using base N `a_base'.
		local
			v: NATURAL_8
		do
			from
				v := a_value
			until
				v = 0
			loop
				v := v // a_base
				Result := Result + 1
			end
		end

feature {NONE} -- Implementation		

	prepend_based_natural_8_to (a_value: NATURAL_8; a_base: NATURAL_8; a_string: STRING)
			-- Prepend `a_value' to a_string using `a_base' encoding.
		require
			valid_value: a_value < a_base
			accepted_base: 2 <= a_base and then a_base <= 36
		do
			if a_value < 10 or a_base <= 10 then
				a_string.prepend (a_value.out)
			elseif is_lower_case then
				a_string.prepend_character ('a' + a_value - 10)
			else
				check is_upper_case end
				a_string.prepend_character ('A' + a_value - 10)
			end
		end

	base_n_character_to_natural (c: CHARACTER_8): NATURAL_8
			-- Natural 8 value for base n encoded character `c'.
		do
			inspect c
			when '0' then
				Result := {NATURAL_8} 0
			when '1' then
				Result := {NATURAL_8} 1
			when '2' then
				Result := {NATURAL_8} 2
			when '3' then
				Result := {NATURAL_8} 3
			when '4' then
				Result := {NATURAL_8} 4
			when '5' then
				Result := {NATURAL_8} 5
			when '6' then
				Result := {NATURAL_8} 6
			when '7' then
				Result := {NATURAL_8} 7
			when '8' then
				Result := {NATURAL_8} 8
			when '9' then
				Result := {NATURAL_8} 9
			else
				if 'a' <= c and c <= 'z' then
					Result := ((c.code - ('a').code) + 10).as_natural_8
				elseif 'A' <= c and c <= 'Z' then
					Result := ((c.code - ('A').code) + 10).as_natural_8
				else
					check is_hexa: False end
				end
			end
		end


note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
