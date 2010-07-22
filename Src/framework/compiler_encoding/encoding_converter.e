note
	description: "[
					Interface of encoding converter with encoding detection.
					
					Encoding detection priority:
					1. If `a_encoding' is attached, use it as the encoding of `a_file'
					2. Detect BOM from `a_file', use the detected encoding.
					4. Default to ASCII (ISO-8859-1) encoding.
				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ENCODING_CONVERTER

inherit
	ANY
		undefine
			default_create
		end

	STRING_HANDLER
		export
			{NONE} all
		undefine
			default_create
		end

	PLATFORM
		export
			{NONE} all
		undefine
			default_create
		end

	SYSTEM_ENCODINGS
		export
			{NONE} all
		undefine
			default_create
		end

	LOCALIZED_PRINTER
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- <precursor>
		do
			Precursor {ANY}
			create string_buffer.make (50000)
		end

feature -- Buffer

	input_buffer_from_file (a_file: KL_BINARY_INPUT_FILE; a_class: detachable ANY): detachable YY_BUFFER
			-- Fetch the input buffer according to the content of `a_file'.
			-- Set `detected_encoding' and `last_bom' accordingly.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		local
			l_buffer: ENCODING_DETECTION_FILE_BUFFER
			l_ascii_buffer: ASCII_UTF8_CONVERSION_FILE_BUFFER
			l_string: STRING
		do
			detected_encoding := Void
			last_bom := Void
			l_buffer := detection_buffer
			l_buffer.set_file (a_file)
			l_buffer.detect_file
			if l_buffer.last_detection_successful then
				last_bom := l_buffer.last_bom
				if l_buffer.detected_encoding.is_equal (utf8) then
					Result := l_buffer
				else
					-- Report unknown encoding error.
				end
			else
					-- Get encoding from `a_class', if not found, use ASCII encoding.
				if attached a_class and then attached encoding_from_class (a_class) as l_encoding then
					l_string := string_buffer
					l_string.wipe_out
					l_string.append_string (l_buffer.content.to_text)
					a_file.read_string (a_file.count)
					l_string.append (a_file.last_string)
					l_encoding.convert_to (utf8, l_string)
					if l_encoding.last_conversion_successful then
						create Result.make (l_encoding.last_converted_stream)
						detected_encoding := l_encoding
					else
						-- Report unsupported encoding error.
					end
				else
					l_ascii_buffer := ascii_to_utf8_file_buffer
					l_ascii_buffer.make_from_file_buffer (l_buffer)
					Result := l_ascii_buffer
					detected_encoding := iso_8859_1
				end
			end
		ensure
			buffer_attached: Result /= Void
		end

	input_buffer_from_file_of_encoding (a_file: KL_BINARY_INPUT_FILE; a_encoding: ENCODING): detachable YY_BUFFER
			-- Fetch the input buffer according to the content of `a_file'.
			-- Set `detected_encoding' and `last_bom' accordingly.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
			a_encoding_not_void: a_encoding /= Void
		do
			a_file.read_string (a_file.count)
			a_encoding.convert_to (utf8, a_file.last_string)
			if a_encoding.last_conversion_successful then
				create Result.make (a_encoding.last_converted_stream)
			else
				-- Report unsupported encoding error.
			end
			detected_encoding := a_encoding
			last_bom := Void
		ensure
			buffer_attached: Result /= Void
		end

	input_buffer_from_ascii_string (a_string: STRING_8): YY_BUFFER
			-- input buffer from ASCII string.
		require
			a_string_not_void: a_string /= Void
		do
			create Result.make (a_string)
			detected_encoding := iso_8859_1
			last_bom := Void
		ensure
			buffer_attached: Result /= Void
			detected_encoding_attached: detected_encoding /= Void
		end

	input_buffer_from_string_of_encoding (a_string: STRING_8; a_encoding: ENCODING): detachable YY_BUFFER
		require
			a_string_not_void: a_string /= Void
		do
			a_encoding.convert_to (utf8, a_string)
			if a_encoding.last_conversion_successful then
				create Result.make (a_encoding.last_converted_stream)
			end
			detected_encoding := a_encoding
			last_bom := Void
		end

	input_buffer_from_string (a_string: STRING_8; a_class: detachable ANY): YY_BUFFER
		require
			a_string_not_void: a_string /= Void
		local
			l_encoding: detachable ENCODING
			l_string: STRING
		do
			detected_encoding := Void
			last_bom := Void
			bom_detector.detect (a_string)
			if bom_detector.last_detection_successful then
				l_encoding := bom_detector.detected_encoding
				last_bom := bom_detector.last_bom
			elseif a_class /= Void and then attached encoding_from_class (a_class) as l_enc then
				l_encoding := l_enc
			else
				l_encoding := iso_8859_1
			end
			l_string := a_string
			if attached last_bom as l_bom and then not l_bom.is_empty then
				l_string := l_string.substring (l_bom.count + 1, l_string.count)
			end
			l_encoding.convert_to (utf8, l_string)
			if l_encoding.last_conversion_successful then
				create Result.make (l_encoding.last_converted_stream)
			end
			detected_encoding := l_encoding
		end

feature -- Conversion

	utf8_string (a_stream: STRING; a_class: detachable ANY): STRING
			-- Detect encoding of `a_stream' and convert it into utf8.
			-- Detection is not 100% reliable. Use other conversion methods when
			-- encodings are known.
		require
			a_stream_attached: a_stream /= Void
		do
			bom_detector.detect (a_stream)
			last_bom := Void
			if bom_detector.last_detection_successful then
				Result := a_stream.substring (bom_detector.last_bom_count + 1, a_stream.count)
				detected_encoding := bom_detector.detected_encoding
				last_bom := bom_detector.last_bom
			elseif attached a_class as l_class and then attached encoding_from_class (l_class) as l_encoding then
				l_encoding.convert_to (utf8, a_stream)
				if l_encoding.last_conversion_successful then
					Result := l_encoding.last_converted_stream
				else
					-- Report unsupported encoding error.
				end
				detected_encoding := l_encoding
			else
					-- Default to ASCII
				iso_8859_1.convert_to (utf8, a_stream)
				if iso_8859_1.last_conversion_successful then
					Result := iso_8859_1.last_converted_stream
				else
					Result := a_stream
				end
				detected_encoding := iso_8859_1
			end
		ensure
			utf32_string_attached: Result /= Void
			detected_encoding_attached: detected_encoding /= Void
		end

	utf32_string (a_stream: STRING; a_class: detachable ANY): STRING_32
			-- Detect encoding of `a_stream' and convert it into utf32.
		require
			a_stream_attached: a_stream /= Void
		do
			bom_detector.detect (a_stream)
			last_bom := Void
			if bom_detector.last_detection_successful then
				Result := a_stream.substring (bom_detector.last_bom_count + 1, a_stream.count)
				detected_encoding := bom_detector.detected_encoding
				last_bom := bom_detector.last_bom
			elseif attached a_class as l_class and then attached encoding_from_class (l_class) as l_encoding then
				l_encoding.convert_to (utf32, a_stream)
				if l_encoding.last_conversion_successful then
					Result := l_encoding.last_converted_string.as_string_32
				else
						-- Try converting to utf8 first, as some OS does not support utf32.
					l_encoding.convert_to (utf8, a_stream)
					if l_encoding.last_conversion_successful then
						Result := utf8_to_utf32 (l_encoding.last_converted_stream)
					else
						-- Report unsupported encoding error.
					end
				end
				detected_encoding := l_encoding
			else
					-- Default to ASCII
				iso_8859_1.convert_to (utf32, a_stream)
				if iso_8859_1.last_conversion_successful then
					Result := iso_8859_1.last_converted_string
				else
						-- Try converting to utf8 as some OS does not support UTF-32 conversion.
					iso_8859_1.convert_to (utf8, a_stream)
					if iso_8859_1.last_conversion_successful then
						Result := utf8_to_utf32 (iso_8859_1.last_converted_stream)
					else
						Result := a_stream.as_string_32
					end
				end
				detected_encoding := iso_8859_1
			end
		ensure
			utf32_string_attached: Result /= Void
			detected_encoding_attached: detected_encoding /= Void
		end

feature -- Conversion

	utf8_to_utf32 (a_string: STRING_8): STRING_32
			-- UTF8 to UTF32 conversion, Eiffel implementation.
		require
			a_string_not_void: a_string /= Void
		local
			i, nb: INTEGER
			l_ref: INTEGER_32_REF
		do
			from
				i := 1
				nb := a_string.count
				create Result.make (nb)
				create l_ref
			until
				i > nb
			loop
				Result.append_character (read_character_from_utf8 (i, l_ref, a_string))
				i := i + l_ref.item
			end
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

	read_character_from_utf8 (a_position: INTEGER; a_read_bytes: detachable INTEGER_32_REF; a_string: STRING_8): CHARACTER_32
			-- Read a Unicode character from UTF-8 string.
			-- `a_string' is in UTF-8.
			-- `a_position' is the starting byte point of a character.
			-- `a_read_bytes' is the number of bytes read.
		require
			a_string_not_void: a_string /= Void
			a_position_in_range: a_position > 0 and a_position <= a_string.count
			a_position_valid: a_string.code (a_position).to_natural_8 <= 127 or
								(a_string.code (a_position).to_natural_8 & 0xE0) = 0xC0 or
								(a_string.code (a_position).to_natural_8 & 0xF0) = 0xE0 or
								(a_string.code (a_position).to_natural_8 & 0xF8) = 0xF0 or
								(a_string.code (a_position).to_natural_8 & 0xFC) = 0xF8 or
								(a_string.code (a_position).to_natural_8 & 0xFE) = 0xFC
		local
			l_pos: INTEGER
			l_nat8: NATURAL_8
			l_code: NATURAL_32
		do
			l_pos := a_position
			l_nat8 := a_string.code (l_pos).to_natural_8
			if l_nat8 <= 127 then
					-- Form 0xxxxxxx.
				Result := l_nat8.to_character_32

			elseif (l_nat8 & 0xE0) = 0xC0 then
					-- Form 110xxxxx 10xxxxxx.
				l_code := (l_nat8 & 0x1F).to_natural_32 |<< 6
				l_pos := l_pos + 1
				l_nat8 := a_string.code (l_pos).to_natural_8
				l_code := l_code | (l_nat8 & 0x3F).to_natural_32
				Result := l_code.to_character_32

			elseif (l_nat8 & 0xF0) = 0xE0 then
				-- Form 1110xxxx 10xxxxxx 10xxxxxx.
				l_code := (l_nat8 & 0x0F).to_natural_32 |<< 12
				l_nat8 := a_string.code (l_pos + 1).to_natural_8
				l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 6)
				l_nat8 := a_string.code (l_pos + 2).to_natural_8
				l_code := l_code | (l_nat8 & 0x3F).to_natural_32
				Result := l_code.to_character_32
				l_pos := l_pos + 2

			elseif (l_nat8 & 0xF8) = 0xF0 then
				-- Form 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx.
				l_code := (l_nat8 & 0x07).to_natural_32 |<< 18
				l_nat8 := a_string.code (l_pos + 1).to_natural_8
				l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 12)
				l_nat8 := a_string.code (l_pos + 2).to_natural_8
				l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 6)
				l_nat8 := a_string.code (l_pos + 3).to_natural_8
				l_code := l_code | (l_nat8 & 0x3F).to_natural_32
				Result := l_code.to_character_32
				l_pos := l_pos + 3

			elseif (l_nat8 & 0xFC) = 0xF8 then
				-- Starts with 111110xx
				-- This seems to be a 5 bytes character,
				-- but UTF-8 is restricted to 4, then substitute with a space
				Result := ' '
				l_pos := l_pos + 4

			else
				-- Starts with 1111110x
				-- This seems to be a 6 bytes character,
				-- but UTF-8 is restricted to 4, then substitute with a space
				Result := ' '
				l_pos := l_pos + 5

			end
			if a_read_bytes /= Void then
				a_read_bytes.set_item (l_pos - a_position + 1)
			end
		end

	utf32_to_file_encoding (a_str: STRING_32): STRING
			-- Convert utf32 to file encoding (utf8 as default)
		require
			a_str_attached: a_str /= Void
		do
			Result := utf32_to_utf8 (a_str)
		ensure
			utf32_to_console_encoding_attached: Result /= Void
		end

feature -- Validate

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

	string_32_to_stream (a_str: STRING_32): STRING
			-- Byte stream of `a_string'.
		require
			a_str_attached: a_str /= Void
		local
			i: INTEGER_32
			l_code: NATURAL_32
			l_count: INTEGER
			l_is_little_endian: BOOLEAN
		do
			l_count := a_str.count
			if l_count > 0 then
				create Result.make (l_count * 4)
				from
					i := 1
					l_is_little_endian := is_little_endian
				until
					i > l_count
				loop
					l_code := a_str.item (i).natural_32_code
					if l_is_little_endian then
						Result.append_code (l_code & 0x000000FF)
						Result.append_code (l_code & 0x0000FF00 |>> 8)
						Result.append_code (l_code & 0x00FF0000 |>> 16)
						Result.append_code (l_code & 0xFF000000 |>> 24)
					else
						Result.append_code (l_code & 0xFF000000 |>> 24)
						Result.append_code (l_code & 0x00FF0000 |>> 16)
						Result.append_code (l_code & 0x0000FF00 |>> 8)
						Result.append_code (l_code & 0x000000FF)
					end
					i := i + 1
				end
			else
				create Result.make_empty
			end
		ensure
			string_32_to_stream_attached: Result /= Void
		end

feature -- Detection

	encoding_from_string_of_class (a_string: STRING_8; a_class: detachable ANY): detachable ENCODING
			-- Encoding detected from `a_string' of `a_class'.
		do
			last_bom := Void
			Bom_detector.detect (a_string)
			if Bom_detector.last_detection_successful then
				Result := bom_detector.detected_encoding
				last_bom := bom_detector.last_bom
			elseif attached a_class as l_c and then attached encoding_from_class (a_class) as l_encoding then
				Result := l_encoding
			else
				Result := iso_8859_1
			end
		end

	last_bom: detachable STRING_8
			-- Last bom read from `encoding_from_string_of_class'

	detected_encoding: detachable ENCODING assign set_detected_encoding
			-- Detected encoding

feature -- Element Change

	set_detected_encoding (a_encoding: like detected_encoding)
			-- Sets the detected encoding
		require
			a_encoding_not_void: a_encoding /= Void
		do
			detected_encoding := a_encoding
		ensure
			detected_encoding_set: detected_encoding = a_encoding
		end

feature {NONE} -- Implementation

	encoding_from_class (a_class: ANY): detachable ENCODING
			-- Read encoding from `a_class'.
		do
		end

feature {NONE} -- Buffers

	string_buffer: STRING
			-- String buffer

	bom_detector: BOM_ENCODING_DETECTOR
			-- Bom detector
		once
			create Result
		end

	Ascii_to_utf8_File_buffer: ASCII_UTF8_CONVERSION_FILE_BUFFER
			-- On the fly ASCII UTF-8 conversion buffer.
		once
			create Result.make_with_size ((create {KL_STANDARD_FILES}).input, 50000)
		ensure
			file_buffer_not_void: Result /= Void
		end

	detection_buffer: ENCODING_DETECTION_FILE_BUFFER
			-- Buffer for encoding detection
		once
			create Result.make_with_size ((create {KL_STANDARD_FILES}).input, 50000)
		ensure
			file_buffer_not_void: Result /= Void
		end

invariant
	string_buffer_not_void: string_buffer /= Void

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
