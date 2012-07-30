note
	description: "[
		Base64 abstract implementation for encoding/decoding data to and from Base64.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BASE64_ENCODER [I -> ANY, G -> {TO_SPECIAL [I], BOUNDED [I]}]

feature -- Query

	require_buffer_count (a_data: READABLE_STRING_8): INTEGER
			-- Required number of slots in a buffer to decode a Base64 encoded string into.
			--
			-- `a_data': Encoded Base64 data.
			-- `Result':
		require
			a_data_attached: attached a_data
			a_data_is_valid_base64_data: is_valid_base64_data (a_data)
		do
			Result := (a_data.count // 4) * 3
		ensure
			result_positive: Result > 0
		end

feature {NONE} -- Query

	item_to_code (a_item: I): NATURAL_8
			-- Retrieves a 8-bit natural number from the supplied data, given an index
		require
			a_data_attached: attached a_item
		deferred
		end

	code_to_item (a_code: NATURAL_8): I
			-- Retrieves a 8-bit natural number from the supplied data, given an index
		deferred
		end

feature -- Status report

	is_valid_base64_data (a_data: READABLE_STRING_8): BOOLEAN
			-- Indicates if the a piece of encoded data is encoding using a Base64 encoding.
			--
			-- `a_data': Base64 encoding.
			-- `Result': True if the encoding is valid; False otherwise
		require
			a_data_attached: attached a_data
		local
			l_count, i: INTEGER
			c: CHARACTER
		do
			if not a_data.is_empty then
				l_count := a_data.count
				if (l_count \\ 4) = 0 then
						-- Basic checksum passed, now check character codes.
					Result := True
					l_count := l_count
					from i := 1 until i > l_count or not Result loop
						c := a_data[i]
						Result := c.is_alpha_numeric or else c = '+' or c = '/'
						i := i + 1
					end

					if not Result then
							-- Check for last padding characters.
						if i = l_count then
								-- Two chars from end.
							Result := (c = padding) and (a_data[i] = padding)
						elseif i > l_count then
								-- Last chars from end.
							Result := (c = padding)
						end
					end
				end
			end
		end

feature -- Conversion

	decode64 (a_data: READABLE_STRING_8; a_buffer: G)
			-- Decodes Base64 data to a supplied buffer.
			-- Note: Use `require_buffer_count' to determine how long the buffer needs to be.
			--
			-- `a_data': Base64 encoded data.
			-- `a_buffer': Buffer object to populate the decoded data into.
			-- `Result': A decode string.
		require
			a_data_attached: attached a_data
			not_a_data_is_empty: not a_data.is_empty
			a_data_is_valid_base64_data: is_valid_base64_data (a_data)
			a_buffer_attached: attached a_buffer
			a_buffer_big_enough: a_buffer.capacity >= require_buffer_count (a_data)
		local
			l_bits: NATURAL_32
			i_count, i, j: INTEGER
			l_table: like charset_table
			l_pads: INTEGER
		do
			l_table := charset_table
			from
				i := 1
				j := 1
				i_count := a_data.count - 4
			until
				i > i_count
			loop
				l_bits := (l_table [a_data[i]] |<< 18) |
					(l_table [a_data[i + 1]] |<< 12) |
					(l_table [a_data[i + 2]] |<< 6) |
					(l_table [a_data[i + 3]])

				a_buffer[j] := code_to_item (((l_bits |>> 16) & 0xFF).as_natural_8)
				a_buffer[j + 1] := code_to_item (((l_bits |>> 8) & 0xFF).as_natural_8)
				a_buffer[j + 2] := code_to_item ((l_bits & 0xFF).as_natural_8)

				i := i + 4
				j := j + 3
			end

				-- Handling padding characters.
			l_bits := (l_table [a_data[i]] |<< 18) |
				(l_table [a_data[i + 1]] |<< 12)
			if a_data[i + 2] /= padding then
				l_bits := l_bits | (l_table [a_data[i + 2]] |<< 6)
				if a_data[i + 3] /= padding then
					l_bits := l_bits | (l_table [a_data[i + 3]])
				else
					l_pads := 1
				end
			else
				l_pads := 2
			end
			a_buffer[j] := code_to_item (((l_bits |>> 16) & 0xFF).as_natural_8)
			if l_pads < 2 then
				a_buffer[j + 1] := code_to_item (((l_bits |>> 8) & 0xFF).as_natural_8)
				if l_pads = 0 then
					a_buffer[j + 2] := code_to_item ((l_bits & 0xFF).as_natural_8)
				end
			end
		end

	encode64 (a_data: G): STRING_8
			-- Encodes a string using Base64 encoding.
			--
			-- `a_string': String to encode using Base64.
			-- `Result': A Base64 encoded string.
		require
			a_data_attached: attached a_data
			not_a_data_is_empty: not a_data.is_empty
		local
			l_charset: SPECIAL[CHARACTER_8]
			l_bits: NATURAL_32
			l_max_count: INTEGER
			l_count, i: INTEGER
			l_last: INTEGER_8
		do
			l_charset := charset.area

			l_count := a_data.count
			l_max_count := l_count - (l_count \\ 3)
			create Result.make ((l_max_count + 1) * 4)
			from i := 1 until i > l_max_count loop
					-- Create 24 bit pattern
				l_bits := ((item_to_code (a_data[i]).as_integer_32 |<< 16)
					| (item_to_code (a_data [i + 1]).as_integer_32 |<< 8)
					| item_to_code (a_data [i + 2]).as_integer_32).as_natural_32

				Result.extend (l_charset[(l_bits |>> 18).as_integer_32 & 0x3F])
				Result.extend (l_charset[(l_bits |>> 12).as_integer_32 & 0x3F])
				Result.extend (l_charset[(l_bits |>> 6).as_integer_32 & 0x3F])
				Result.extend (l_charset[l_bits.as_integer_32 & 0x3F])

				i := i + 3
			end

			if l_count > l_max_count then
					-- Process remaining character and pad extra bytes with =

				l_bits := item_to_code (a_data[i]).as_natural_32 |<< 16
				if i < l_count then
					l_bits := l_bits | (item_to_code (a_data [i + 1]).as_natural_32 |<< 8)
				end

				Result.extend (l_charset[(l_bits |>> 18).as_integer_32 & 0x3F])
				Result.extend (l_charset[(l_bits |>> 12).as_integer_32 & 0x3F])
				if i < l_count then
						-- There were at least two characters extra in the buffer
					Result.extend (l_charset[(l_bits |>> 6).as_integer_32 & 0x3F])
					l_last := (l_bits.as_natural_32 & 0x3F).as_integer_8
				else
						-- Only one extra character, pad the second from last with a =
						-- The last paddding character will be processed during the next condition block.
					Result.extend (padding)
				end
				if l_last = 0 then
						-- Pad last character
					Result.extend (padding)
				else
						-- Append last character
					Result.extend (l_charset[l_last])
				end
			end
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
			result_is_valid_base64_data: is_valid_base64_data (Result)
		end

feature {NONE} -- Constants

	charset: STRING_8 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
			-- Base64 character set.

	padding: CHARACTER_8 = '='
			-- Base64/32/16 padding character.

	charset_table: HASH_TABLE [NATURAL_32, CHARACTER_8]
			-- Base64 character index table.
			-- Table allows for fast reverse indexing of `charset'.
		local
			l_charset: like charset
			i_count, i: INTEGER
		once
			l_charset := charset
			create Result.make (l_charset.count)
			from
				i := 1
				i_count := l_charset.count
			until
				i > i_count
			loop
				Result.put ((i - 1).as_natural_8, l_charset[i])
				i := i + 1
			end
		ensure
			result_attached: attached Result

		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
