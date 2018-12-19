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

	bytes_encoded_string (a_bytes: READABLE_INDEXABLE [NATURAL_8]): STRING_8
			-- base32 encoded value of byte array `a_bytes'.
		local
			i,n: INTEGER
			i1,i2,i3,i4,i5: INTEGER
			l_map: READABLE_STRING_8
		do
			has_error := False
			l_map := character_map
			n := 8 * ((a_bytes.upper - a_bytes.lower + 1 + 4) // 5)

			from
				i := a_bytes.lower
				create Result.make (n)
				n := a_bytes.upper
			until
				i > n
			loop
				i1 := a_bytes.item (i).as_integer_32
				if i < n then
					i := i + 1
					i2 := a_bytes.item (i).as_integer_32
					if i < n then
						i := i + 1
						i3 := a_bytes.item (i).as_integer_32
						if i < n then
							i := i + 1
							i4 := a_bytes.item (i).as_integer_32
							if i < n then
								i := i + 1
								i5 := a_bytes.item (i).as_integer_32
							else
								i5 := -1
							end
						else
							i4 := -1
						end
					else
						i3 := -1
					end
				else
					i2 := -1
				end
				append_quintuple_encoded_to (i1, i2, i3, i4, i5, l_map, Result)
				i := i + 1
			end
		end

	encoded_string (s: READABLE_STRING_8): STRING_8
			-- base32 encoded value of `s'.
		local
			i,n: INTEGER
			i1,i2,i3,i4,i5: INTEGER
			l_map: READABLE_STRING_8
		do
			has_error := False
			l_map := character_map
			n := 8 * ((s.count + 4) // 5)

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
						if i < n then
							i := i + 1
							i4 := s.code (i).as_integer_32
							if i < n then
								i := i + 1
								i5 := s.code (i).as_integer_32
							else
								i5 := -1
							end
						else
							i4 := -1
						end
					else
						i3 := -1
					end
				else
					i2 := -1
				end
				append_quintuple_encoded_to (i1, i2, i3, i4, i5, l_map, Result)
				i := i + 1
			end
		end

feature -- Decoder

	decoded_string (v: READABLE_STRING_8): STRING
			-- base32 decoded value of `s'.	
		do
			create Result.make (v.count)
			decode_string_to_buffer (v, Result)
		end

	decode_string_to_buffer (v: READABLE_STRING_8; a_buffer: STRING)
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
					i > nb_bytes or has_error or pos >= n
				loop
					pos := next_encoded_character_position (v, pos)
					if pos <= n then
						c := v [pos]
						if c = '=' then
							bytes [i] := 0
						else
							bytes [i] := character_to_value (c)
							byte_count := byte_count + 1
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

	append_quintuple_encoded_to (i1,i2,i3,i4,i5: INTEGER; a_map: READABLE_STRING_8; a_output: STRING)
		do
			--| [ 'f'  ][ 'o'  ][ 'o'  ][      ][      ]
			--| [ 102  ][ 111  ][ 111  ][   0  ][   0  ]
			--| 0110011001101111011011110000000000000000
			--| [ 12][ 25][ 23][ 11][ 30][ 0 ][ 0 ][ 0 ]
			--| [ M ][ Z ][ X ][ W ][ 6 ][ = ][ = ][ = ]
			a_output.extend (a_map.item (1 + i1 |>> 3))
			if i2 >= 0 then
				a_output.extend (a_map.item (1 + (i1 |<< 2 & 0b11111) + (i2 |>> 6 & 0b11111) ))
				a_output.extend (a_map.item (1 + i2 |>> 1 & 0b11111) )
				if i3 >= 0 then
					a_output.extend (a_map.item (1 + (i2 |<< 4 & 0b11111) + (i3 |>> 4 & 0b11111) ))
					if i4 >= 0 then
						a_output.extend (a_map.item (1 + (i3 |<< 1 & 0b11111) + (i4 |>> 7 & 0b11111 )) )
						a_output.extend (a_map.item (1 + (i4 |>> 2 & 0b11111)) )
						if i5 >= 0 then
							a_output.extend (a_map.item (1 + (i4 |<< 3 & 0b11111) + (i5 |>> 5 & 0b11111 )) )
							a_output.extend (a_map.item (1 + i5 & 0b11111 ))
						else
							a_output.extend (a_map.item (1 + (i4 |<< 3 & 0b11111) ) )
							a_output.append_character ('=')
						end
					else
						a_output.extend (a_map.item (1 + (i3 |<< 1 & 0b11111) ))
						a_output.append_character ('=')
						a_output.append_character ('=')
						a_output.append_character ('=')
					end
				else
					a_output.extend (a_map.item (1 + (i2 |<< 4 & 0b11111) ))
					a_output.append_character ('=')
					a_output.append_character ('=')
					a_output.append_character ('=')
					a_output.append_character ('=')
				end
			else
				a_output.extend (a_map.item (1 + (i1 |<< 2) & 0b11111))
				a_output.append_character ('=')
				a_output.append_character ('=')
				a_output.append_character ('=')
				a_output.append_character ('=')
				a_output.append_character ('=')
				a_output.append_character ('=')
			end
		end

	next_encoded_character_position (v: READABLE_STRING_8; from_pos: INTEGER): INTEGER
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

	character_map: STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
			--|              01234567890123456789012345678901
			--|              0         1         2         3
			--| pad= '='

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
