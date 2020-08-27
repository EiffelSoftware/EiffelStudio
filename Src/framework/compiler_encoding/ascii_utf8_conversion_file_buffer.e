note
	description: "File buffer that scans characters and convert extended ASCII characters into UTF-8 byte sequence."
	date: "$Date$"
	revision: "$Revision$"

class
	ASCII_UTF8_CONVERSION_FILE_BUFFER

inherit
	YY_UNICODE_FILE_BUFFER
		redefine
			make_with_size
		end

	SYSTEM_ENCODINGS

create
	make,
	make_with_size,
	make_from_file_buffer

feature {NONE} -- Initialization

	make_with_size (a_file: like file; size: INTEGER)
			-- <Precursor>
		do
			Precursor (a_file, size)
			create string_buffer.make (1)
			string_buffer.append_character ('%U')
		end

feature -- Initialization

	make_from_file_buffer (a_buffer: YY_UNICODE_FILE_BUFFER)
			-- Create from other file buffer.
		require
			a_buffer_not_void: a_buffer /= Void
		do
			capacity := a_buffer.capacity
			content := a_buffer.content
			end_of_file := a_buffer.end_of_file
			count := a_buffer.count
			index := a_buffer.index
			line := a_buffer.line
			column := a_buffer.column
			position := a_buffer.position
			beginning_of_line := a_buffer.beginning_of_line
			filled := True
			file := a_buffer.file

			create string_buffer.make (1)
			string_buffer.append_character ('%U')
		end

feature {NONE} -- Implementation

	put_character (a_char: CHARACTER; a_buff: like content)
			-- Put `a_char' into `a_buff'.
			-- Return the number of bytes put into `a_buff'
		require
			a_buff_not_void: a_buff /= Void
			enough_remaining_space: capacity - count >= max_bytes_of_iso_8859_1_to_utf8
		local
			l_conv_count: INTEGER
		do
			count := count + 1
			if a_char.code > 0x7F then
					-- Convert into UTF8
				string_buffer.put (a_char, 1)
				iso_8859_1.convert_to (utf8, string_buffer)
				if iso_8859_1.last_conversion_successful then
					a_buff.fill_from_string (iso_8859_1.last_converted_stream, count)
					l_conv_count := iso_8859_1.last_converted_stream.count
					count := count + l_conv_count - 1
					last_number_of_bytes_put := l_conv_count
					check not_larger_than_max:
						last_number_of_bytes_put <= max_bytes_of_iso_8859_1_to_utf8
					end
				else
						-- FIXME: We should raise a waring at least.
					a_buff.put (a_char, count)
					last_number_of_bytes_put := 1
				end
			else
					-- UTF8 compatible
				a_buff.put (a_char, count)
				last_number_of_bytes_put := 1
			end
		end

feature -- Query

	last_number_of_bytes_put: INTEGER

	max_bytes_of_iso_8859_1_to_utf8: INTEGER = 2
			-- Maximum bytes of a UTF-8 character converted from iso_8859_1 character

feature {NONE} -- Buffer

	string_buffer: STRING

invariant
	string_buffer_not_void: string_buffer /= Void

note
	ca_ignore: "CA013", "CA013: creation procedure is generally available"
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
