note
	description: "Interface of encoding converter with encoding detection."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENCODING_CONVERTER

inherit
	STRING_HANDLER
		export {NONE} all end

feature -- Conversion

	utf8_string (a_stream: STRING): STRING
			-- Detect encoding of `a_stream' and convert it into utf8.
			-- Detection is not 100% reliable. Use other conversion methods when
			-- encodings are known.
		require
			a_stream_attached: a_stream /= Void
		deferred
		ensure
			utf32_string_attached: Result /= Void
			detected_encoding_attached: detected_encoding /= Void
		end

	string_32_to_stream (a_str: STRING_32): STRING
			-- Byte stream of `a_string'.
		require
			a_str_attached: a_str /= Void
		deferred
		ensure
			string_32_to_stream_attached: Result /= Void
		end

feature -- Conversion

	utf8_to_utf32 (a_string: STRING_8): STRING_32
			-- UTF8 to UTF32 conversion, Eiffel implementation.
		require
			a_string_not_void: a_string /= Void
		local
			l_nat8: NATURAL_8
			l_code: NATURAL_32
			i, nb, cnt: INTEGER
		do
			from
				i := 1
				cnt := 0
				nb := a_string.count
				create Result.make (nb)
				Result.set_count (nb)
			until
				i > nb
			loop
				l_nat8 := a_string.code (i).to_natural_8
				cnt := cnt + 1
				if l_nat8 <= 127 then
						-- Form 0xxxxxxx.
					Result.put (l_nat8.to_character_8, cnt)

				elseif (l_nat8 & 0xE0) = 0xC0 then
						-- Form 110xxxxx 10xxxxxx.
					l_code := (l_nat8 & 0x1F).to_natural_32 |<< 6
					i := i + 1
					l_nat8 := a_string.code (i).to_natural_8
					l_code := l_code | (l_nat8 & 0x3F).to_natural_32
					Result.put (l_code.to_character_32, cnt)

				elseif (l_nat8 & 0xF0) = 0xE0 then
					-- Form 1110xxxx 10xxxxxx 10xxxxxx.
					l_code := (l_nat8 & 0x0F).to_natural_32 |<< 12
					l_nat8 := a_string.code (i + 1).to_natural_8
					l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 6)
					l_nat8 := a_string.code (i + 2).to_natural_8
					l_code := l_code | (l_nat8 & 0x3F).to_natural_32
					Result.put (l_code.to_character_32, cnt)
					i := i + 2

				elseif (l_nat8 & 0xF8) = 0xF0 then
					-- Form 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx.
					l_code := (l_nat8 & 0x07).to_natural_32 |<< 18
					l_nat8 := a_string.code (i + 1).to_natural_8
					l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 12)
					l_nat8 := a_string.code (i + 2).to_natural_8
					l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 6)
					l_nat8 := a_string.code (i + 3).to_natural_8
					l_code := l_code | (l_nat8 & 0x3F).to_natural_32
					Result.put (l_code.to_character_32, cnt)
					i := i + 3

				elseif (l_nat8 & 0xFC) = 0xF8 then
					-- Starts with 111110xx
					-- This seems to be a 5 bytes character,
					-- but UTF-8 is restricted to 4, then substitute with a space
					Result.put (' ', cnt)
					i := i + 4

				else
					-- Starts with 1111110x
					-- This seems to be a 6 bytes character,
					-- but UTF-8 is restricted to 4, then substitute with a space
					Result.put (' ', cnt)
					i := i + 5

				end
				i := i + 1
			end
			Result.set_count (cnt)
		ensure
			Result_not_void: Result /= Void
		end

	utf32_to_utf8 (a_string: STRING_32): STRING_8
			-- Convert UTF32 to UTF8.
		require
			a_string_not_void: a_string /= Void
		local
			bytes_written: INTEGER
			i: INTEGER
			l_code: NATURAL_32
			l_string_length: INTEGER
		do
			l_string_length := a_string.count

				-- First compute how many bytes we need to convert `a_string' to UTF-8.
			from
				i := l_string_length
				bytes_written := 0
			until
				i = 0
			loop
				l_code := a_string.code (i)
				if l_code <= 127 then
					bytes_written := bytes_written + 1
				elseif l_code <= 0x7FF then
					bytes_written := bytes_written + 2
				elseif l_code <= 0xFFFF then
					bytes_written := bytes_written + 3
				else -- l_code <= 0x10FFFF
					bytes_written := bytes_written + 4
				end
				i := i - 1
			end

				-- Fill `utf_ptr8' with the converted data.
			from
				i := 1
				create Result.make (bytes_written)
			until
				i > l_string_length
			loop
				l_code := a_string.code (i)
				append_code_point_to_utf8 (l_code, Result)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

	utf8_to_utf16 (a_string: STRING_8): STRING_32
			-- UTF8 to UTF16 conversion, Eiffel implementation.
			-- |FIXME: UTF-8 to UTF-16 is not implemented.
			-- |FIXME: But in most case, UTF-32 is the same with UTF-16.
		require
			a_string_not_void: a_string /= Void
		do
			Result := utf8_to_utf32 (a_string)
		ensure
			Result_not_void: Result /= Void
		end

	append_code_point_to_utf8 (a_code: NATURAL_32; a_string: STRING_8)
			-- Append an unicode code point `a_code' to an utf8 stream.
		require
			a_string_not_void: a_string /= Void
				-- According to ISO/IEC 10646, the maximum unicode point is 10FFFF.
			a_code_is_valid: a_code >= 0 and then a_code <= 0x10FFFF
		do
				if a_code <= 127 then
						-- Of the form 0xxxxxxx.
					a_string.append_code (a_code)
				elseif a_code <= 0x7FF then
						-- Insert 110xxxxx 10xxxxxx.
					a_string.append_code (0xC0 | (a_code |>> 6))
					a_string.append_code (0x80 | (a_code & 0x3F))
				elseif a_code <= 0xFFFF then
						-- Start with 1110xxxx
					a_string.append_code (0xE0 | (a_code |>> 12))
					a_string.append_code (0x80 | ((a_code |>> 6) & 0x3F))
					a_string.append_code (0x80 | (a_code & 0x3F))
				else -- a_code <= 0x10FFFF then
						-- Start with 11110xxx
					check
						max_4_bytes: a_code <= 0x10FFFF
						-- UTF-8 has been restricted to 4 bytes characters
					end
					a_string.append_code (0xF0 | (a_code |>> 18))
					a_string.append_code (0x80 | ((a_code |>> 12) & 0x3F))
					a_string.append_code (0x80 | ((a_code |>> 6) & 0x3F))
					a_string.append_code (0x80 | (a_code & 0x3F))
				end
		ensure
			a_string_appended: (a_code <= 127 implies a_string.count = old a_string.count + 1) and
								((a_code > 127 and a_code <= 0x7FF) implies a_string.count = old a_string.count + 2) and
								((a_code > 0x7FF and a_code <= 0xFFFF) implies a_string.count = old a_string.count + 3) and
								((a_code > 0xFFFF and a_code <= 0x10FFFF) implies a_string.count = old a_string.count + 4)
		end

feature -- Validate

	file_in_utf8 (a_file: KL_BINARY_INPUT_FILE): BOOLEAN
			-- Is content of `a_file' in valid UTF-8 string?
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		do
			a_file.read_string (a_file.count)
			Result := is_valid_utf8 (a_file.last_string)
		end

	is_valid_utf8 (a_string: STRING): BOOLEAN
			-- Is `a_string' valid UTF-8 string?
		require
			a_string_not_void: a_string /= Void
		local
			l_nat8: NATURAL_8
			l_code: NATURAL_32
			i, nb, cnt: INTEGER
		do
			from
				i := 1
				nb := a_string.count
				Result := True
			until
				i > nb or not Result
			loop
				l_nat8 := a_string.code (i).to_natural_8
				if l_nat8 <= 127 then
						-- Form 0xxxxxxx.
				elseif (l_nat8 & 0xE0) = 0xC0 then
						-- Form 110xxxxx 10xxxxxx.
					l_code := (l_nat8 & 0x1F).to_natural_32 |<< 6
					i := i + 1
				elseif (l_nat8 & 0xF0) = 0xE0 then
					-- Form 1110xxxx 10xxxxxx 10xxxxxx.
					i := i + 2
				elseif (l_nat8 & 0xF8) = 0xF0 then
					-- Form 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx.
					i := i + 3
				elseif (l_nat8 & 0xFC) = 0xF8 then
					-- Starts with 111110xx
					Result := False
				else
					-- Starts with 1111110x
					Result := False
				end
				i := i + 1
			end
		end

	utf32_string (a_stream: STRING): STRING_32
			-- Detect encoding of `a_stream' and convert it into utf32.
		require
			a_stream_attached: a_stream /= Void
		deferred
		ensure
			utf32_string_attached: Result /= Void
			detected_encoding_attached: detected_encoding /= Void
		end

	localized_print (a_str: STRING_GENERAL)
			-- Print `a_str' as localized encoding.
			-- `a_str' is taken as a UTF-32 string.
		deferred
		end

	localized_print_error (a_str: STRING_GENERAL)
			-- Print an error, `a_str', as localized encoding.
			-- `a_str' is taken as a UTF-32 string.
		deferred
		end

	utf32_to_file_encoding (a_str: STRING_32): STRING
			-- Convert utf32 to file encoding (utf8 as default)
		require
			a_str_attached: a_str /= Void
		deferred
		ensure
			utf32_to_console_encoding_attached: Result /= Void
		end

feature -- Detection

	detected_encoding: detachable ANY
			-- Detected encoding
		deferred
		end

	detect_encoding (a_str: detachable STRING_GENERAL)
			-- Detect encoding of `a_str'
		require
			a_str_not_void: a_str /= Void
		deferred
		ensure
			detected_encoding_attached: detected_encoding /= Void
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
