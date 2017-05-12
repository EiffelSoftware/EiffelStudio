note
	description: "[
			Base64 is a group of similar binary-to-text encoding schemes that represent binary data in an ASCII string format by translating it into a radix-64 representation. The term Base64 originates from a specific MIME content transfer encoding.

			Each base64 digit needs exactly 6 bits of information to be represented

			see https://en.wikipedia.org/wiki/Base64
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BASE64

feature -- Status report

	has_error: BOOLEAN

feature -- base64 encoder

	encoded_string (s: READABLE_STRING_8): STRING_8
			-- base64 encoded value of `s'.
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
				i := (8 * n) \\ 6
				if i > 0 then
					create f.make_filled (False, 8 * n + (6 - i))
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
				create Result.make (n // 6)
			until
				i > n - 1
			loop
				c := 0
				if f[i + 0] then c := c + 0x20 end
				if f[i + 1] then c := c + 0x10 end
				if f[i + 2] then c := c + 0x8 end
				if f[i + 3] then c := c + 0x4 end
				if f[i + 4] then c := c + 0x2 end
				if f[i + 5] then c := c + 0x1 end
				Result.extend (l_map.item (c + 1))
				i := i + 6
			end

			i := s.count \\ 3
			if i > 0 then
				from until i > 2 loop
					Result.extend ('=')
					i := i + 1
				end
			end
		end

feature -- Decoder

	decoded_string (v: STRING): STRING
			-- base64 decoded value of `s'.	
		do
			create Result.make (v.count)
			decode_string_to_buffer (v, Result)
		end

	decode_string_to_buffer (v: STRING; a_buffer: STRING)
			-- Write base64 decoded value of `s' into `a_buffer'.
		local
			byte_count: INTEGER
			pos, n, i, nb_bytes: INTEGER
			bytes: ARRAY [INTEGER]
			tmp1, tmp2: INTEGER
			done: BOOLEAN
			l_map: STRING_8
			c: CHARACTER
		do
			has_error := False
			l_map := character_map
			n := v.count
			from
				nb_bytes := 4
				create bytes.make_filled (0, 1, nb_bytes)
				pos := 0
			invariant
				n = v.count
			until
				pos >= n or done
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
						if i < 3 or else c /= '=' then
							bytes[i] := l_map.index_of (c, 1) - 1
							byte_count := byte_count + 1
						end
					else
						has_error := True
					end
					i := i + 1
				end
				done := byte_count < nb_bytes

				if byte_count > 1 then
					tmp1 := bytes [1].bit_shift_left (2)  & 0b1111_1111
					tmp2 := bytes [2].bit_shift_right (4) & 0b0000_0011
					a_buffer.extend ((tmp1 | tmp2).to_character_8)
					if byte_count > 2 then
						tmp1 := bytes [2].bit_shift_left (4)  & 0b1111_1111
						tmp2 := bytes [3].bit_shift_right (2) & 0b0000_1111
						a_buffer.extend ((tmp1 | tmp2).to_character_8)
						if byte_count > 3 then
							tmp1 := bytes [4]
							tmp2 := bytes [3].bit_shift_left(6) & 0b1111_1111
							a_buffer.extend ((tmp1 | tmp2).to_character_8)
						end
					end
				end
			end
		end

feature {NONE} -- Constants

	next_encoded_character_position (v: STRING; from_pos: INTEGER): INTEGER
			-- Next encoded character position from `v' starting after `from_pos' index.
			-- Result over `v.count' denodes no remaining decodable position
			--| Mainly to handle base64 encoded text on multiple line
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
			when 'A' .. 'Z', 'a' .. 'z', '0'..'9', '+', '/', '=' then
				Result := True
			else
			end
		end

	character_map: STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="

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
