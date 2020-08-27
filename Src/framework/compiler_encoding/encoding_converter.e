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

	STRING_HANDLER
		export
			{NONE} all
		end

	SYSTEM_ENCODINGS
		export
			{NONE} all
		end

	LOCALIZED_PRINTER

	UNICODE_CONVERSION
		rename
			string_32_to_multi_byte as string_32_to_stream_encoding
		end

create
	make

feature {NONE} -- Initialization

	make
			-- <precursor>
		do
			create string_buffer.make (50000)
		end

feature -- Buffer

	input_buffer_from_file (a_file: KL_BINARY_INPUT_FILE; a_class: detachable ANY): detachable YY_UNICODE_BUFFER
			-- Fetch the input buffer according to the content of `a_file'.
			-- Set `detected_encoding' and `last_bom' accordingly.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		local
			l_buffer: ENCODING_DETECTION_FILE_BUFFER
			l_ascii_buffer: like ascii_to_utf8_file_buffer
			l_string: STRING
		do
			detected_encoding := Void
			last_bom := Void
			l_buffer := detection_buffer
			l_buffer.set_file (a_file)
			l_buffer.detect_file
			if attached l_buffer.detected_encoding as l_detected_encoding then
				last_bom := l_buffer.last_bom
				detected_encoding := l_detected_encoding
				if l_detected_encoding.is_equal (utf8) then
--					l_buffer.set_default_encoding (l_buffer.utf8_encoding)
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
						create Result.make_from_utf8_string (l_encoding.last_converted_stream)
						detected_encoding := l_encoding
					else
						-- Report unsupported encoding error.
					end
				else
					l_ascii_buffer := ascii_to_utf8_file_buffer
					l_ascii_buffer.make_from_file_buffer (l_buffer)
					l_ascii_buffer.set_default_encoding (l_ascii_buffer.iso_8859_1_encoding)
					Result := l_ascii_buffer
					detected_encoding := default_encoding
				end
			end
		end

	input_buffer_from_file_of_encoding (a_file: KL_BINARY_INPUT_FILE; a_encoding: ENCODING): detachable YY_UNICODE_BUFFER
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
				create Result.make_from_utf8_string (a_encoding.last_converted_stream)
			else
				-- Report unsupported encoding error.
			end
			detected_encoding := a_encoding
			last_bom := Void
		end

	input_buffer_from_ascii_string (a_string: STRING_8): YY_UNICODE_BUFFER
			-- Input buffer from ASCII string.
		require
			a_string_not_void: a_string /= Void
		do
			create Result.make_from_iso_8859_1_string (a_string)
			detected_encoding := default_encoding
			last_bom := Void
		ensure
			buffer_attached: Result /= Void
			detected_encoding_attached: detected_encoding /= Void
		end

	input_buffer_from_string_of_encoding (a_string: STRING_8; a_encoding: ENCODING): detachable YY_UNICODE_BUFFER
		require
			a_string_not_void: a_string /= Void
		do
			a_encoding.convert_to (utf8, a_string)
			if a_encoding.last_conversion_successful then
				create Result.make_from_utf8_string (a_encoding.last_converted_stream)
			end
			detected_encoding := a_encoding
			last_bom := Void
		end

	input_buffer_from_string (a_string: STRING_8; a_class: detachable ANY): detachable YY_UNICODE_BUFFER
		require
			a_string_not_void: a_string /= Void
		local
			l_encoding: ENCODING
			l_string: STRING
		do
			detected_encoding := Void
			last_bom := Void
			bom_detector.detect (a_string)
			if attached bom_detector.detected_encoding as l_detected_encoding then
				l_encoding := l_detected_encoding
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
				create Result.make_from_utf8_string (l_encoding.last_converted_stream)
			end
			detected_encoding := l_encoding
		end

	default_encoding: ENCODING
			-- Default encoding
		do
			Result := iso_8859_1
		ensure
			Result_set: Result /= Void
		end

feature -- Conversion (based on a class)

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
			elseif attached a_class and then attached encoding_from_class (a_class) as l_encoding then
				l_encoding.convert_to (utf8, a_stream)
				if l_encoding.last_conversion_successful then
					Result := l_encoding.last_converted_stream
				else
						-- Report unsupported encoding error.
					Result := a_stream
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
				detected_encoding := default_encoding
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
				Result := utf8_to_utf32 (a_stream.substring (bom_detector.last_bom_count + 1, a_stream.count))
				detected_encoding := bom_detector.detected_encoding
				last_bom := bom_detector.last_bom
			elseif attached a_class and then attached encoding_from_class (a_class) as l_encoding then
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
						Result := a_stream.as_string_32
					end
				end
				detected_encoding := l_encoding
			else
					-- Default to ASCII
				iso_8859_1.convert_to (utf32, a_stream)
				if iso_8859_1.last_conversion_successful then
					Result := iso_8859_1.last_converted_string_32
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

	utf32_to_file_encoding (a_str: STRING_32): STRING
			-- Convert utf32 to file encoding (utf8 as default)
		require
			a_str_attached: a_str /= Void
		do
			Result := utf32_to_utf8 (a_str)
		ensure
			utf32_to_console_encoding_attached: Result /= Void
		end

	string_32_to_stream (a_str: STRING_32): STRING
			-- Byte stream of `a_string'.
			-- Always generate little endian string.
		require
			a_str_attached: a_str /= Void
		local
			i: INTEGER_32
			l_code: NATURAL_32
			l_count: INTEGER
		do
			l_count := a_str.count
			if l_count > 0 then
				create Result.make (l_count * 4)
				from
					i := 1
				until
					i > l_count
				loop
					l_code := a_str [i].natural_32_code
					Result.append_code (l_code & 0x000000FF)
					Result.append_code (l_code & 0x0000FF00 |>> 8)
					Result.append_code (l_code & 0x00FF0000 |>> 16)
					Result.append_code (l_code & 0xFF000000 |>> 24)
					i := i + 1
				end
			else
				create Result.make_empty
			end
		ensure
			string_32_to_stream_attached: Result /= Void
		end

feature -- Validate

	is_code_point_valid_string_8 (a_utf8_str: STRING_8): BOOLEAN
			-- Is Unicode code point  of `a_utf_8_str' valid for STRING_8?
		require
			a_string_not_void: a_utf8_str /= Void
		local
			i, nb: INTEGER
			l_ref: INTEGER_32_REF
		do
			from
				i := 1
				nb := a_utf8_str.count
				create l_ref
				Result := True
			until
				i > nb or not Result
			loop
				if not read_character_from_utf8 (i, l_ref, a_utf8_str).is_character_8 then
					Result := False
				end
				i := i + l_ref.item
			end
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
			elseif attached a_class and then attached encoding_from_class (a_class) as l_encoding then
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
			create Result.make_with_size (create {KL_STRING_INPUT_STREAM}.make (""), 50000)
		ensure
			file_buffer_not_void: Result /= Void
		end

	detection_buffer: ENCODING_DETECTION_FILE_BUFFER
			-- Buffer for encoding detection
		once
			create Result.make_with_size (create {KL_STRING_INPUT_STREAM}.make (""), 50000)
		ensure
			file_buffer_not_void: Result /= Void
		end

invariant
	string_buffer_not_void: string_buffer /= Void

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
