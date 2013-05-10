note
	description: "[
			Factory for creating SYSTEM_STRING instances. It uses the escape convention of UTF_CONVERTER to represent all
			possible wrong encoding on the SYSTEM_STRING side.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_STRING_FACTORY

feature -- Conversion

	from_string_to_system_string (a_str: READABLE_STRING_GENERAL): SYSTEM_STRING
			-- Convert `a_str' to an instance of SYSTEM_STRING. The input
			-- is escaped and will be decoded in the SYSTEM_STRING instance.
		require
			is_dotnet: {PLATFORM}.is_dotnet
			a_str_not_void: a_str /= Void
		local
			i, nb: INTEGER
			l_str: STRING_BUILDER
			c: NATURAL_32
			l_dummy: detachable STRING_BUILDER
			l_encoded_value: READABLE_STRING_GENERAL
			l_decoded: BOOLEAN
		do
				-- Perform a UTF-32 conversion to UTF-16.
				-- The code below uses `to_character_8' but don't be fooled
				-- it is actually a System.Char type which has a 2-byte length.
			nb := a_str.count
			create l_str.make (nb)
			from
				i := 1
			until
				i > nb
			loop
				c := a_str.code (i)
				if c = {UTF_CONVERTER}.escape_character.natural_32_code then
						-- We might be facing a character that was escaped.
					if i < nb then
						if a_str.item (i + 1) = {UTF_CONVERTER}.escape_character then
								-- The `escape_character' was escaped, it meant they really wanted an `escape_character'.
							i := i + 1
						elseif a_str.item (i + 1) = 'u' then
							if i + 4 < nb then
								l_encoded_value := a_str.substring (i + 2, i + 5)
								if is_hexa_decimal (l_encoded_value) then
									c := to_natural_32 (l_encoded_value)
									l_decoded := True
									i := i + 5
								else
										-- Not an hexadecimal value, it was not escaped.
								end
							else
									-- Not enough characters to make a 2-byte value, it was not escaped.
							end
						elseif i + 1 < nb then
								-- We have at least 2 characters to read, make sure they represent an hexadecimal
								-- value.
							l_encoded_value := a_str.substring (i + 1, i + 2)
							if is_hexa_decimal (l_encoded_value) then
								c := to_natural_32 (l_encoded_value)
								l_decoded := True
								i := i + 2
							else
									-- Not an hexadecimal value, it was not escaped.
							end
						else
							-- Not enough to read to make it valid, it was not escaped.
						end
					else
							-- Nothing more to read, clearly it was not encoded.
					end
				end

				if not l_decoded then
					if c <= 0xFFFF  then
							-- Codepoint from Basic Multilingual Plane: one 16-bit code unit.
						l_dummy := l_str.append_character (c.to_character_8)
					else
							-- Supplementary Planes: surrogate pair with lead and trail surrogates.
						l_dummy := l_str.append_character  ((0xD7C0 + (c |>> 10)).to_character_8)
						l_dummy := l_str.append_character  ((0xDC00 + (c & 0x3FF)).to_character_8)
					end
				else
					l_decoded := False
						-- Simply put decoded value directly in stream.
					l_dummy := l_str.append_character (c.to_character_8)
				end
				i := i + 1
			end
			check attached l_str.to_string as l_string then
				Result := l_string
			end
		ensure
			from_string_to_system_string_not_void: Result /= Void
		end

	read_system_string_into (a_str: SYSTEM_STRING; a_result: STRING_GENERAL)
			-- Fill `a_result' with `a_str' content using the escaping mechanism for badly formed
			-- UTF-16 encodings.
		require
			is_dotnet: {PLATFORM}.is_dotnet
			a_str_not_void: a_str /= Void
			a_result_not_void: a_result /= Void
			a_result_valid: a_result.count >= a_str.length + escape_count (a_str)
		do
			if attached {STRING_8} a_result as l_str then
				read_system_string_into_area_8 (a_str, l_str.area)
			elseif attached {STRING_32} a_result as l_str then
				read_system_string_into_area_32 (a_str, l_str.area)
			else
				check False end
			end
		end

	read_system_string_into_area_8 (a_str: SYSTEM_STRING; a_area: SPECIAL [CHARACTER_8])
			-- Fill `a_result' with `a_str' content. Note that most of the time values
			-- are truncated to fit `a_area'.
		require
			is_dotnet: {PLATFORM}.is_dotnet
			a_str_not_void: a_str /= Void
			a_area_not_void: a_area /= Void
			a_area_valid: a_area.count >= a_str.length
		local
			i, j, n: INTEGER
			c1, c2: NATURAL_32
		do
				-- Convert UTF-16 encoded `a_str' into `a_area' which is UTF-32. Note that
				-- in this particular case, we simply ignore the escaping.
			from
					-- Allocate Result with the same number of bytes as `p'.
				n := a_str.length
			until
				i >= n
			loop
				c1 := a_str.chars (i).natural_32_code
				if c1 < 0xD800 or else c1 >= 0xE000 then
						-- Codepoint from Basic Multilingual Plane: one 16-bit code unit.
					a_area.put (c1.as_natural_8.to_character_8, j)
				else
						-- Supplementary Planes: surrogate pair with lead and trail surrogates.
					if i < n then
						c2 := a_str.chars (i + 1).natural_32_code
						a_area.put (((c1 |<< 10) + c2 - 0x35FDC00).as_natural_8.to_character_8, j)
					end
					i := i + 1
				end
				j := j + 1
				i := i + 1
			end
		end

	read_system_string_into_area_32 (a_str: SYSTEM_STRING; a_area: SPECIAL [CHARACTER_32])
			-- Fill `a_area' with `a_str' content using the escaping mechanism for badly formed
			-- UTF-16 encodings.
		require
			is_dotnet: {PLATFORM}.is_dotnet
			a_str_not_void: a_str /= Void
			a_area_not_void: a_area /= Void
			a_area_valid: a_area.count >= a_str.length + escape_count (a_str)
		local
			i, j, n: INTEGER
			c1, c2: NATURAL_32
		do
				-- Convert UTF-16 encoded `a_str' into `a_area' which is UTF-32.
			from
					-- Allocate Result with the same number of bytes as `p'.
				n := a_str.length
			until
				i >= n
			loop
				c1 := a_str.chars (i).natural_32_code
				if c1 < 0xD800 or else c1 >= 0xE000 then
						-- Codepoint from Basic Multilingual Plane: one 16-bit code unit.
					a_area.put (c1.to_character_32, j)
					if c1.to_character_32 = {UTF_CONVERTER}.escape_character then
						a_area.put (c1.to_character_32, j + 1)
						j := j + 1
					end
				else
						-- Supplementary Planes: surrogate pair with lead and trail surrogates.
					if i < n then
						c2 := a_str.chars (i + 1).natural_32_code
						a_area.put (((c1 |<< 10) + c2 - 0x35FDC00).to_character_32, j)
					end
					i := i + 1
				end
				j := j + 1
				i := i + 1
			end
		end

	escape_count (a_str: SYSTEM_STRING): INTEGER
			-- Number of `escape_character' in `a_str'.
		require
			is_dotnet: {PLATFORM}.is_dotnet
		local
			i, n: INTEGER
		do
			from
				n := a_str.length
			until
				i = n
			loop
				if a_str.chars (i).to_character_32 = {UTF_CONVERTER}.escape_character then
					Result := Result + 1
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	escape_code_into (a_string: STRING_32; a_code: NATURAL_16)
			-- Escape `a_code' as documented in the note clause of the class into `a_string'.
			-- If `a_code' fits into a NATURAL_8, it will be just the `escape_character' followed
			-- by the 2-digit hexadecimal representation, otherwise `escape_character' followed
			-- by the letter `u' followed by the 4-digit hexadecimal representation.
		do
			a_string.append_character ({UTF_CONVERTER}.escape_character)
			if a_code <= {NATURAL_8}.max_value then
				a_string.append_string_general (a_code.as_natural_8.to_hex_string)
			else
				a_string.append_character ('u')
				a_string.append_string_general (a_code.to_hex_string)
			end
		end

	is_hexa_decimal (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' a valid hexadecimal sequence?
		local
			l_convertor: like ctoi_convertor
		do
			l_convertor := ctoi_convertor
			l_convertor.reset ({NUMERIC_INFORMATION}.type_natural_32)
			l_convertor.parse_string_with_type (a_string, {NUMERIC_INFORMATION}.type_natural_32)
			Result := l_convertor.is_integral_integer
		end

	to_natural_32 (a_hex_string: READABLE_STRING_GENERAL): NATURAL_32
			-- Convert hexadecimal value `a_hex_string' to its corresponding NATURAL_32 value.
		require
			is_hexa: is_hexa_decimal (a_hex_string)
		local
			l_convertor: like ctoi_convertor
		do
			l_convertor := ctoi_convertor
			l_convertor.parse_string_with_type (a_hex_string, {NUMERIC_INFORMATION}.type_no_limitation)
			Result := l_convertor.parsed_natural_32
		end

	ctoi_convertor: HEXADECIMAL_STRING_TO_INTEGER_CONVERTER
			-- Convertor used to convert string to integer or natural
		once
			create Result.make
			Result.set_leading_separators_acceptable (False)
			Result.set_trailing_separators_acceptable (False)
		ensure
			ctoi_convertor_not_void: Result /= Void
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
