indexing
	description: "Eiffel implementations for Unicode encoding conversion."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UNICODE_CONVERSION

inherit
	ENCODING_I

	STRING_HANDLER

create {ENCODING}
	default_create

feature -- Querry

	is_code_page_valid (a_code_page: STRING): BOOLEAN is
			-- Is `a_code_page' valid?
		do
			if a_code_page /= Void then
				Result := unicode_encodings.has (a_code_page)
			end
		end

	is_code_page_convertable (a_from_code_page, a_to_code_page: STRING): BOOLEAN is
			-- Is `a_from_code_page' convertable to `a_to_code_page'.
		do
				-- We accept conversion between the same encodings to optimize.
			if a_from_code_page.is_equal (utf8) then
					-- UTF-8 to UTF-32
				Result := a_to_code_page.is_equal (utf8) or else a_to_code_page.is_equal (utf32)
			elseif a_from_code_page.is_equal (utf32) then
					-- UTF-32 to UTF-8
					-- UTF-32 to UTF-16
				Result := a_to_code_page.is_equal (utf32) or else a_to_code_page.is_equal (utf8) or else a_to_code_page.is_equal (utf16)
			elseif a_from_code_page.is_equal (utf16) then
					-- UTF-16 to UTF-32
				Result := a_to_code_page.is_equal (utf16) or else a_to_code_page.is_equal (utf32)
			elseif a_from_code_page.is_equal (utf7) then
					-- Do not support UTF-7 encoding conversion.
				Result := a_to_code_page.is_equal (utf7)
			--else
					-- Neither other endian independent Unicode encodings.
			end
		end

feature -- Conversion

	convert_to (a_from_code_page: STRING; a_from_string: STRING_GENERAL; a_to_code_page: STRING) is
			-- Convert between Unicode encodings.
		do
			reset
				-- We accept conversion between the same encodings to optimize.
			if a_from_code_page.is_equal (a_to_code_page) then
				last_conversion_successful := True
				last_converted_string := a_from_string
			else
				if a_from_code_page.is_equal (utf8) then
						-- UTF-8 to UTF-32
					last_converted_string := utf8_to_utf32 (a_from_string.as_string_8)
					last_conversion_successful := True
				elseif a_from_code_page.is_equal (utf32) then
					if a_to_code_page.is_equal (utf8) then
							-- UTF-32 to UTF-8
						last_converted_string := utf32_to_utf8 (a_from_string.as_string_32)
						last_conversion_successful := True
					elseif a_to_code_page.is_equal (utf16) then
							-- UTF-32 to UTF-16
						last_converted_string := utf32_to_utf16 (a_from_string.as_string_32)
						last_was_wide_string := True
						last_conversion_successful := True
					end
				elseif a_from_code_page.is_equal (utf16) then
						-- UTF-16 to UTF-32
					if a_to_code_page.is_equal (utf32) then
						last_converted_string := utf16_to_utf32 (a_from_string.as_string_32)
						last_conversion_successful := True
					end
				--elseif a_from_code_page.is_equal (utf7) then
						-- Do not support UTF-7 encoding conversion.
				--else
						-- Neither other endian independent Unicode encodings.
				end
			end
		end

feature {NONE} -- Implementation

	utf8_to_utf32 (a_string: STRING_8): STRING_32 is
			-- UTF32 to UTF8 conversion, Eiffel implementation.
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

	utf32_to_utf8 (a_string: STRING_32): STRING_8 is
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
				if l_code <= 127 then
						-- Of the form 0xxxxxxx.
					Result.append_code (l_code)
				elseif l_code <= 0x7FF then
						-- Insert 110xxxxx 10xxxxxx.
					Result.append_code (0xC0 | (l_code |>> 6))
					Result.append_code (0x80 | (l_code & 0x3F))
				elseif l_code <= 0xFFFF then
						-- Start with 1110xxxx
					Result.append_code (0xE0 | (l_code |>> 12))
					Result.append_code (0x80 | ((l_code |>> 6) & 0x3F))
					Result.append_code (0x80 | (l_code & 0x3F))
				else -- l_code <= 0x10FFFF then
						-- Start with 11110xxx
					check
						max_4_bytes: l_code <= 0x10FFFF
						-- UTF-8 has been restricted to 4 bytes characters
					end
					Result.append_code (0xF0 | (l_code |>> 18))
					Result.append_code (0x80 | ((l_code |>> 12) & 0x3F))
					Result.append_code (0x80 | ((l_code |>> 6) & 0x3F))
					Result.append_code (0x80 | (l_code & 0x3F))
				end
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

	unicode_encodings: HASH_TABLE [STRING, STRING] is
			-- Supported Unicode encodings
		once
			create Result.make (8)
			Result.put (utf7, utf7)
			Result.put (utf8, utf8)
			Result.put (utf16, utf16)
			Result.put (utf32, utf32)
			Result.put (utf16_le, utf16_le)
			Result.put (utf32_le, utf32_le)
			Result.put (utf16_be, utf16_be)
			Result.put (utf32_be, utf32_be)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
