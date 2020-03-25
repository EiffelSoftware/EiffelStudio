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

	has_incorrect_padding: BOOLEAN
			-- Decoding reported incorrect padding.

feature -- base64 encoder

	bytes_encoded_string (a_bytes: READABLE_INDEXABLE [NATURAL_8]): STRING_8
			-- base64 encoded value of `a_bytes'.
		local
			i,n: INTEGER
			i1,i2,i3: INTEGER
			l_map: READABLE_STRING_8
		do
			has_error := False
			l_map := character_map
			n := 4 * ((a_bytes.upper - a_bytes.lower + 1 + 2) // 3)

			from
				i := a_bytes.lower
				create Result.make (n)
				n := a_bytes.upper
			until
				i > n
			loop
				i1 := a_bytes[i].as_integer_32
				if i < n then
					i := i + 1
					i2 := a_bytes[i].as_integer_32
					if i < n then
						i := i + 1
						i3 := a_bytes[i].as_integer_32
					else
						i3 := -1
					end
				else
					i2 := -1
				end

				append_triple_encoded_to (i1, i2, i3, l_map, Result)
				i := i + 1
			end
		end

	encoded_string (s: READABLE_STRING_8): STRING_8
			-- base64 encoded value of `s'.
		local
			i,n: INTEGER
			i1,i2,i3: INTEGER
			l_map: READABLE_STRING_8
		do
			has_error := False
			l_map := character_map
			n := 4 * ((s.count + 2) // 3)

			from
				i := 1
				create Result.make (n)
				n := s.count
			until
				i > n
			loop
				i1 := s.code (i).as_integer_32
				if i < n then
					i := i + 1
					i2 := s.code (i).as_integer_32
					if i < n then
						i := i + 1
						i3 := s.code (i).as_integer_32
					else
						i3 := -1
					end
				else
					i2 := -1
				end
				append_triple_encoded_to (i1, i2, i3, l_map, Result)
				i := i + 1
			end
		end

feature -- Decoder

	decoded_string (v: READABLE_STRING_8): STRING
			-- base64 decoded value of `s'.	
		do
			create Result.make (v.count)
			decode_string_to_buffer (v, Result)
		end

	decode_string_to_buffer (v: READABLE_STRING_8; a_buffer: STRING)
			-- Write base64 decoded value of `s' into `a_buffer'.
		local
			byte_count: INTEGER
			pos, n, i, nb_bytes: INTEGER
			bytes: ARRAY [INTEGER]
			tmp1, tmp2: INTEGER
			done: BOOLEAN
			c: CHARACTER
		do
			has_error := False
			has_incorrect_padding := False

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
					i := byte_count + 1
				until
					i > nb_bytes or has_error or pos >= n
				loop
					if pos < n then
						pos := next_encoded_character_position (v, pos)
						if pos <= n then
							c := v [pos]
							if c /= '=' then
								bytes[i] := character_to_value (c)
								byte_count := byte_count + 1
							end
						else
							has_error := True
						end
					else
							-- Consider as missing padding '='
						has_incorrect_padding := True
						bytes[i] := character_to_value (c)
						byte_count := byte_count + 1
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

feature {NONE} -- Implementation

	append_triple_encoded_to (i1,i2,i3: INTEGER; a_map: READABLE_STRING_8; a_output: STRING)
		do
			--| [ 'f'  ][ 'o'  ][ 'o'  ]
			--| [ 102  ][ 111  ][ 111  ]
			--| 011001100110111101101111
			--| 011001100110111101101111
			--| [ 25 ][ 38 ][ 61 ][ 47 ]
			--| [  Z ][  m ][  9 ][  v ]
			a_output.extend (a_map.item (1 + i1 |>> 2))
			if i2 >= 0 then
				a_output.extend (a_map.item (1 + (i1 |<< 4 & 0b111111) + (i2 |>> 4 & 0b111111) ))
				if i3 >= 0 then
					a_output.extend (a_map.item (1 + (i2 |<< 2 & 0b111111) + (i3 |>> 6 & 0b111111) ))
					a_output.extend (a_map.item (1 + (i3 & 0b111111) ))
				else
					a_output.extend (a_map.item (1 + (i2 |<< 2 & 0b111111) ))
					a_output.append_character ('=')
				end
			else
				a_output.extend (a_map.item (1 + (i1 |<< 4) & 0b111111))
				a_output.append_character ('=')
				a_output.append_character ('=')
			end
		end

	next_encoded_character_position (v: READABLE_STRING_8; from_pos: INTEGER): INTEGER
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

	character_map: STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
			--|              0123456789012345678901234567890123456789012345678901234567890123
			--|              0         1         2         3         4         5         6
			--| pad= '='

	character_to_value (c: CHARACTER): INTEGER
		do
			inspect c
			when 'A'..'Z'  then
				Result := c.code - 65 --| 65 'A'
			when 'a'..'z'  then
				Result := 26 + c.code - 97 --| 97 'a'
			when '0'..'9' then
				Result := 52 + c.code - 48 --| 48 '0'
			when '+' then
				Result := 62
			when '/' then
				Result := 63
			else
				Result := 0
			end
		ensure
			Result = character_map.index_of (c, 1) - 1
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
