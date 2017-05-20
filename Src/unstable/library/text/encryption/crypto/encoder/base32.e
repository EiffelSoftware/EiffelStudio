note
	description: "[
			Base32 is one of several base 32 transfer encodings using a 32-character subset of the twenty-six letters A-Z and six digits 2-7.

			Primarily Base32 is used to encode binary data, but is able to encode binary text like ASCII.
			
			see https://en.wikipedia.org/wiki/Base32
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BASE32

feature -- Status report

	has_error: BOOLEAN

feature -- base32 encoder

	encoded_string (s: READABLE_STRING_8): STRING_8
			-- base32 encoded value of `s'.
		local
			i,n: INTEGER
			c: INTEGER
			f: SPECIAL [BOOLEAN]
			l_map: STRING_8
		do
			has_error := False
			l_map := character_map
			from
				n := s.count
				i := (8 * n) \\ 5
				if i > 0 then
					create f.make_filled (False, 8 * n + (5 - i))
				else
					create f.make_filled (False, 8 * n)
				end
				i := 0
			until
				i > n - 1
			loop
				c := s.item (i + 1).code
				f[8 * i + 0] := c.bit_test(7)
				f[8 * i + 1] := c.bit_test(6)
				f[8 * i + 2] := c.bit_test(5)
				f[8 * i + 3] := c.bit_test(4)
				f[8 * i + 4] := c.bit_test(3)
				f[8 * i + 5] := c.bit_test(2)
				f[8 * i + 6] := c.bit_test(1)
				f[8 * i + 7] := c.bit_test(0)
				i := i + 1
			end
			from
				i := 0
				n := f.count
				create Result.make (n // 5)
			until
				i > n - 1
			loop
				c := 0
				if f[i + 0] then c := c + 0x10 end
				if f[i + 1] then c := c + 0x8 end
				if f[i + 2] then c := c + 0x4 end
				if f[i + 3] then c := c + 0x2 end
				if f[i + 4] then c := c + 0x1 end
				Result.extend (l_map.item (c + 1))
				i := i + 5
			end

			i := Result.count \\ 8
			if i > 0 then
				from until i > 7 loop
					Result.extend ('=')
					i := i + 1
				end
			end
		end

feature -- Decoder

	decoded_string (v: STRING): STRING
			-- base32 decoded value of `s'.	
		do
			create Result.make (v.count)
			decode_string_to_buffer (v, Result)
		end

	decode_string_to_buffer (v: STRING; a_buffer: STRING)
			-- Write base32 decoded value of `s' into `a_buffer'
		local
			byte_count: INTEGER
			pos, n, i, nb_bytes: INTEGER
			tmp1, tmp2, tmp3: INTEGER
			bytes: ARRAY [INTEGER]
			done: BOOLEAN
			c: CHARACTER
		do
			has_error := False
			n := v.count
			from
				nb_bytes := 8
				create bytes.make_filled (0, 1, nb_bytes)
				pos := 0
			invariant
				n = v.count
			until
				(pos >= n) or done
			loop
				byte_count := 0
				from
					i := 1
				until
					i > nb_bytes or has_error
				loop
					pos := next_encoded_character_position (v, pos)
					if pos <= n then
						c := v [pos]
						if c /= '=' then
							bytes[i] := character_to_value (c)
							byte_count := byte_count + 1
						else
							bytes[i] := 0
						end
					else
						has_error := True
					end
					i := i + 1
				end
				done := byte_count < nb_bytes

				if byte_count > 1 then
					tmp1 := bytes[1].bit_shift_left (3)  & 0b1111_1111
					tmp2 := bytes[2].bit_shift_right (2) & 0b0000_0111
					a_buffer.extend ((tmp1 | tmp2).to_character_8)
					if byte_count > 3 then
						tmp1 := bytes[2].bit_shift_left (6) & 0b1111_1111
						tmp2 := bytes[3].bit_shift_left (1) & 0b1111_1111
						tmp3 := bytes[4].bit_shift_right (4) & 0b0000_0001
						a_buffer.extend ((tmp1 | tmp2 | tmp3).to_character_8)
						if byte_count > 4 then
							tmp1 := bytes[4].bit_shift_left (4) & 0b1111_1111
							tmp2 := bytes[5].bit_shift_right (1) & 0b0000_1111
							a_buffer.extend((tmp1 | tmp2).to_character_8)
							if byte_count > 6 then
								tmp1 := bytes[5].bit_shift_left (7) & 0b1111_1111
								tmp2 := bytes[6].bit_shift_left (2) & 0b1111_1111
								tmp3 := bytes[7].bit_shift_right (3) & 0b0000_0011
								a_buffer.extend((tmp1 | tmp2 | tmp3).to_character_8)
								if byte_count > 7 then
									tmp1 := bytes[7].bit_shift_left (5) & 0b1111_1111
									tmp2 := bytes[8]
									a_buffer.extend((tmp1 | tmp2).to_character_8)
								end
							end
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	next_encoded_character_position (v: STRING; from_pos: INTEGER): INTEGER
			-- Next encoded character position from `v' starting after `from_pos' index.
			-- Result over `v.count' denodes no remaining decodable position
			--| Mainly to handle base32 encoded text on multiple line
			--| thus we just skip %N, %R and eventually all blanks
		require
			v_attached: v /= Void
			valid_from_pos: v.valid_index (from_pos + 1)
		local
			n: INTEGER
		do
			from
				Result := from_pos + 1
				n := v.count
			until
				in_character_map (v[Result]) or Result > n
			loop
				Result := Result + 1
			end
		ensure
			result_after_from_pos: Result > from_pos
		end

	in_character_map (c: CHARACTER): BOOLEAN
			-- Is a character map element?
		do
			inspect c
			when 'A' .. 'Z', '2'..'7', '=' then
				Result := True
			else
			end
		end

	character_map: STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567="
			--|              012345678901234567890123456789012
			--|              0         1         2         3

	character_to_value (c: CHARACTER): INTEGER
		do
			inspect c
			when 'A'..'Z'  then
				Result := c.code - 65 --| 65 'A'
			when '2'..'7' then
				Result := 26 + c.code - 50 --| 50 '2'
			else
				Result := 0
			end
		ensure
			Result = character_map.index_of (c, 1) - 1
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
