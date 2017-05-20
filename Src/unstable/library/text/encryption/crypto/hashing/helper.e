note
	description: "Helper routines"
	date: "$Date$"
	revision: "$Revision$"

class
	HELPER

feature -- Helper

	rotate_left_32 (in: NATURAL_32; count: INTEGER_32): NATURAL_32
			-- Left rotate operation
		require
			count_too_small: count >= 0
			count_too_big: count <= 32
		do
			result := (in |<< count) | (in |>> (32 - count))
		ensure
			rotate_definition: Result = (in |<< count) | (in |>> (32 - count))
		end

	rotate_right_32 (in: NATURAL_32; count: INTEGER_32): NATURAL_32
		require
			count_too_small: count >= 0
			count_too_big: count <= 32
		do
			result := (in |>> count) | (in |<< (32 - count))
		ensure
			rotate_definition: result = (in |>> count) | (in |<< (32 - count))
		end

	as_natural_32_le (source: SPECIAL [NATURAL_8]; offset: INTEGER_32): NATURAL_32
			-- NATURAL_32 from bytes.
		require
			valid_start: source.valid_index (offset)
			valid_end: source.valid_index (offset + 3)
		do
			Result := source [offset].to_natural_32
			Result := Result | (source [offset + 1].to_natural_32 |<< 8)
			Result := Result | (source [offset + 2].to_natural_32 |<< 16)
			Result := Result | (source [offset + 3].to_natural_32 |<< 24)
		ensure
			byte_0: source [offset] = Result.to_natural_8
			byte_1: source [offset + 1] = (Result |>> 8).to_natural_8
			byte_2: source [offset + 2] = (Result |>> 16).to_natural_8
			byte_3: source [offset + 3] = (Result |>> 24).to_natural_8
		end

	as_natural_32_be (source: SPECIAL [NATURAL_8]; offset: INTEGER_32): NATURAL_32
		require
			valid_start: source.valid_index (offset)
			valid_end: source.valid_index (offset + 3)
		do
			Result := source [offset].to_natural_32 |<< 24
			Result := Result | (source [offset + 1].to_natural_32 |<< 16)
			Result := Result | (source [offset + 2].to_natural_32 |<< 8)
			Result := Result | source [offset + 3].to_natural_32
		ensure
			byte_0: source [offset] = (Result |>> 24).to_natural_8
			byte_1: source [offset + 1] = (Result |>> 16).to_natural_8
			byte_2: source [offset + 2] = (Result |>> 8).to_natural_8
			byte_3: source [offset + 3] = Result.to_natural_8
		end

	from_natural_32_le (source: NATURAL_32; target: SPECIAL [NATURAL_8]; offset: INTEGER_32)
			-- Put `source' into `target'.
		require
			valid_start: target.valid_index (offset)
			valid_end: target.valid_index (offset + 3)
		do
			target [offset] := source.to_natural_8
			target [offset + 1] := (source |>> 8).to_natural_8
			target [offset + 2] := (source |>> 16).to_natural_8
			target [offset + 3] := (source |>> 24).to_natural_8
		ensure
			byte_0: target [offset] = source.to_natural_8
			byte_1: target [offset + 1] = (source |>> 8).to_natural_8
			byte_2: target [offset + 2] = (source |>> 16).to_natural_8
			byte_3: target [offset + 3] = (source |>> 24).to_natural_8
		end

	from_natural_32_be (source: NATURAL_32; target: SPECIAL [NATURAL_8]; offset: INTEGER_32)
		require
			valid_start: target.valid_index (offset)
			valid_end: target.valid_index (offset + 3)
		do
			target [offset] := (source |>> 24).to_natural_8
			target [offset + 1] := (source |>> 16).to_natural_8
			target [offset + 2] := (source |>> 8).to_natural_8
			target [offset + 3] := source.to_natural_8
		ensure
			byte_0: target [offset] = (source |>> 24).to_natural_8
			byte_1: target [offset + 1] = (source |>> 16).to_natural_8
			byte_2: target [offset + 2] = (source |>> 8).to_natural_8
			byte_3: target [offset + 3] = source.to_natural_8
		end

	ch (u: NATURAL_32; v: NATURAL_32; w: NATURAL_32): NATURAL_32
		do
			result := (u & v) | (u.bit_not & w)
		end

	maj (u: NATURAL_32 v: NATURAL_32; w: NATURAL_32): NATURAL_32
		do
			result := (u & v) | (u & w) | (v & w)
		end

	parity (u: NATURAL_32; v: NATURAL_32; w: NATURAL_32): NATURAL_32
		do
			result := u.bit_xor (v).bit_xor (w)
		end

feature -- Bytes operations

	bit_xor_value (a_left, a_right: SPECIAL [NATURAL_8]): SPECIAL [NATURAL_8]
		local
			i, j, u: INTEGER
		do
			create Result.make_empty (a_left.count)
			Result.copy_data (a_left, a_left.lower, Result.lower, a_left.count)
			from
				i := Result.lower
				j := a_right.lower
				u := Result.upper
			until
				i > u
			loop
				Result [i] := (Result [i]).bit_xor (a_right [j])
				i := i + 1
				j := j + 1
			end
		end

	as_fixed_width_byte_array (k: SPECIAL [NATURAL_8]; a_block_size: INTEGER): SPECIAL [NATURAL_8]
		local
			i, j, u: INTEGER
		do
			create Result.make_filled (0, a_block_size)
			from
				i := k.lower
				j := Result.lower
				u := k.upper
			until
				i > u
			loop
				Result [j] := k [i]
				i := i + 1
				j := j + 1
			end
		end

feature -- Conversion

	bytes_from_ascii_string (s: READABLE_STRING_8): SPECIAL [NATURAL_8]
			-- Bytes converted from ASCII text `s'
		local
			i, n: INTEGER
		do
			n := s.count
			create Result.make_filled (0, n)
			if n > 0 then
				from
					i := 1
				until
					i > n
				loop
					Result [i - 1] := s [i].code.to_natural_8
					i := i + 1
				end
			end
		end

	is_hexadecimal_string (s: READABLE_STRING_8): BOOLEAN
			-- Is `s' an hexadecimal string?
		do
			Result := s.count \\ 2 = 0 and across s as c all c.item.is_hexa_digit end
		end

	bytes_from_hexadecimal_string (s: READABLE_STRING_8): SPECIAL [NATURAL_8]
			-- Bytes converted from Hexadecimal string
		require
			s_is_hexadecimal_string: is_hexadecimal_string (s)
		local
			i, j, n: INTEGER
		do
			n := s.count // 2
			create Result.make_filled (0, n)
			if n > 0 then
				from
					i := 1
					j := 1
				until
					i > n
				loop
					Result [i - 1] := hexadecimal_to_natural_8 (s [j]) |<< 4
					if s.valid_index (j + 1) then
						Result [i - 1] := Result [i - 1] + hexadecimal_to_natural_8 (s [j + 1])
					end
					j := j + 2
					i := i + 1
				end
			end
		end

	hexadecimal_to_natural_8 (c: CHARACTER): NATURAL_8
			-- Byte related to hexadecimal character `c'.
		require
			is_hexa_digit: c.is_hexa_digit
		do
			inspect c
			when '0' then
				Result := 0
			when '1' then
				Result := 1
			when '2' then
				Result := 2
			when '3' then
				Result := 3
			when '4' then
				Result := 4
			when '5' then
				Result := 5
			when '6' then
				Result := 6
			when '7' then
				Result := 7
			when '8' then
				Result := 8
			when '9' then
				Result := 9
			when 'a', 'A' then
				Result := 10
			when 'b', 'B' then
				Result := 11
			when 'c', 'C' then
				Result := 12
			when 'd', 'D' then
				Result := 13
			when 'e', 'E' then
				Result := 14
			when 'f', 'F' then
				Result := 15
			else
				check
					is_valid_hexadecimal_character: False
				end
				Result := 0
			end
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
