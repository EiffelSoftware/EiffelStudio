note
	description: "Encoding detector for encoding specified in an eiffel class."
	date: "$Date$"
	revision: "$Revision: $"

class
	EIFFEL_CLASS_ENCODING_DETECTOR

inherit
	ENCODING_DETECTOR

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize current
		do
			create {STRING_8} buffer.make_empty
		end

feature -- Access

	detected_encoding: detachable ENCODING
			-- Detected encoding

feature -- Basic operations

	detect (a_string: STRING_GENERAL)
			-- Detect `detected_encoding' of `a_string'.
		do
			detected_encoding := Void
			last_detection_successful := False
			if not a_string.is_empty then
				buffer := a_string
				index := 0

				find_encoding_keyword
				if found_encoding_keyword then
					extract_encoding
				end
			end
		end

feature {NONE} -- Implementation (Query)

	is_space (l_code: NATURAL_32): BOOLEAN
			-- Is `l_code' a space?
		do
			if l_code.is_valid_character_8_code then
				Result := l_code.to_character_8.is_space
			end
		end

	is_new_line (l_code: NATURAL_32): BOOLEAN
			-- Is `l_code' new line?
		do
			Result := l_code = 0x0A -- "%N"
		end

	is_escape (l_code: NATURAL_32): BOOLEAN
			-- Is `l_code' an escape character?
		do
			Result := l_code = 0x22 -- "%%"
		end

	is_comment (l_code: NATURAL_32): BOOLEAN
			-- Is `l_code' start of comment?
		do
			Result := l_code = 0x2D -- "-" start of comments
		end

	is_manifest_string (l_code: NATURAL_32): BOOLEAN
			-- Is `l_code' start of manifest string?
		do
			Result := l_code = 0x22 -- "%"" start of a manifest string
		end

	is_encoding_keyword (l_code: NATURAL_32): BOOLEAN
			-- Is `l_code' start of `encoding'?
		do
			Result := l_code = 0x45 or l_code = 0x65 -- "E"(0x45) "e"0x65 start of "encoding"
		end

	is_class_keyword (l_code: NATURAL_32): BOOLEAN
			-- Is `l_code' start of class keyword?
		do
			Result := l_code = 0x43 or l_code = 0x63 -- "C"(0x43) "c"0x63 start of "class"
		end

feature {NONE} -- Implementation

	find_encoding_keyword
		require
			index_reset: index = 0
			buffer_set: attached buffer as l_b and then not l_b.is_empty
		local
			l_char: NATURAL_32
			l_count: INTEGER
			l_found_encoding: BOOLEAN
			l_found_class: BOOLEAN
		do
			from
				found_encoding_keyword := False
				l_count := buffer.count
			until
				index >= l_count or else l_found_encoding or else l_found_class
			loop
				index := index + 1
				l_char := buffer.code (index)
				if is_space (l_char) then
					consume_space
				elseif is_comment (l_char) then
					consume_comments
				elseif is_manifest_string (l_char) then
					consume_manifest_string
				elseif is_encoding_keyword (l_char) then
					l_found_encoding := consume_encoding_keyword
				elseif is_class_keyword (l_char) then
					l_found_class := consume_class_keyword
				end
			end
			found_encoding_keyword := l_found_encoding
		end

	extract_encoding
			-- Extract the encoding.
		local
			l_found: BOOLEAN
			l_start, l_end: INTEGER
			l_count: INTEGER
			l_char: NATURAL_32
			l_encoding: like detected_encoding
		do
			from
				l_count := buffer.count
			until
				index >= l_count or else l_found
			loop
				index := index + 1
				l_char := buffer.code (index)
				if is_space (l_char) then
					consume_space
				elseif is_comment (l_char) then
					consume_comments
				elseif is_manifest_string (l_char) then
					l_start := index
					consume_manifest_string
					l_end := index
					l_found := True
				elseif is_class_keyword (l_char) then
					consume_class_keyword.do_nothing
				end
			end
			if l_found and then
				attached buffer as l_buffer and then
				attached l_buffer.substring (l_start + 1, l_end - 1) as s and then
				not s.is_empty and then
				s.is_valid_as_string_8
			then
				create l_encoding.make (s.to_string_8)
					-- Check if the encoding is valid.
				l_encoding.convert_to (utf8, "C")
				if l_encoding.last_conversion_successful then
					last_detection_successful := True
					detected_encoding := l_encoding
				end
			end
		end

	consume_manifest_string
			-- Consume manifest string starting from current position.
		require
			is_manifest_string: is_manifest_string (buffer.code (index))
		local
			l_char: NATURAL_32
			l_count: INTEGER
			l_buffer: like buffer
			l_index: like index
			l_found: BOOLEAN
		do
			from
				l_buffer := buffer
				l_count := l_buffer.count
				l_index := index
			until
				l_index >= l_count or else l_found
			loop
				l_index := l_index + 1
				if l_index <= l_count then
					l_char := l_buffer.code (l_index)
					if is_manifest_string (l_char) then
						l_found := True
					elseif is_escape (l_char) then
						index := l_index + 1 -- Ingore the next char.
					end
				end
			end
			index := l_index -- Do not need to substract one, because the last char '%"' will be consumed.
		end

	consume_encoding_keyword: BOOLEAN
			-- Try consuming encoding keyword starting from current position.
		do
			Result := consume_keyword (encoding_string)
		end

	consume_class_keyword: BOOLEAN
			-- Try consuming class keyword starting from current position.
		do
			Result := consume_keyword (class_string)
		end

	consume_keyword (a_keyword: STRING): BOOLEAN
			-- Try consuming class keyword starting from current position.
		local
			l_char: NATURAL_32
			l_count: INTEGER
			l_buffer: like buffer
			l_index: like index
			l_old_index: like index
		do
			l_index := index
			l_buffer := buffer
			if l_index = 1 or (l_index > 1 and then is_space (l_buffer.code (l_index - 1))) then
				from
					l_count := l_buffer.count
					l_char := l_buffer.code (l_index)
					l_old_index := l_index
				until
					l_index >= l_count or else
					(l_index - l_old_index + 1 > a_keyword.count) or else
					(lower_char (l_char) /= lower_char (a_keyword.code (l_index - l_old_index + 1)))
				loop
					l_index := l_index + 1
					if l_index <= l_count then
						l_char := l_buffer.code (l_index)
					end
				end
				if
					(l_index - l_old_index = a_keyword.count) and then -- keyword matched
					(l_index > l_count or else -- The last char
					is_space (l_buffer.code (l_index)))  -- Check the following char is a space
				then
					index := l_index - 1
					Result := True
				end
			end
		end

	consume_comments
			-- Try consuming comments starting from current position.
		require
			buffer_attached: buffer /= Void
		local
			l_char: NATURAL_32
			l_count: INTEGER
			l_buffer: like buffer
			l_index: like index
		do
			l_buffer := buffer
			l_count := l_buffer.count
			l_index := index
				-- Check if it is real comment starting with "--".
			if l_index < l_count and then is_comment (l_buffer.code (l_index + 1)) then
				from
					l_char := l_buffer.code (l_index)
				until
					l_index >= l_count or else is_new_line (l_char)
				loop
					l_index := l_index + 1
					if l_index <= l_count then
						l_char := l_buffer.code (l_index)
					end
				end
				index := l_index - 1
			end
		end

	consume_space
			-- Consume continous spaces starting from current position.
		require
			buffer_attached: buffer /= Void
		local
			l_char: NATURAL_32
			l_count: INTEGER
			l_buffer: like buffer
			l_index: like index
		do
			from
				l_buffer := buffer
				l_count := l_buffer.count
				l_index := index
				l_char := l_buffer.code (l_index)
			until
				l_index >= l_count or else not is_space (l_char)
			loop
				l_index := l_index + 1
				if l_index <= l_count then
					l_char := l_buffer.code (l_index)
				end
			end
			index := l_index - 1
		end

	lower_char (a_char: NATURAL_32): NATURAL_32
			-- Lower case of `a_char' if possible.
		do
			if a_char.is_valid_character_8_code then
				Result := a_char.to_character_8.as_lower.natural_32_code
			else
				Result := a_char
			end
		end

	found_encoding_keyword: BOOLEAN

	buffer: STRING_GENERAL

	index: INTEGER

	encoding_string: STRING = "encoding"

	class_string: STRING = "class"

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
