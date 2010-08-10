note
	description: "File buffer that scans characters and convert extended ASCII characters into UTF-8 byte sequence."
	date: "$Date$"
	revision: "$Revision$"

class
	ASCII_UTF8_CONVERSION_FILE_BUFFER

inherit
	YY_FILE_BUFFER
		redefine
			fill
		end

	SYSTEM_ENCODINGS

create
	make,
	make_with_size,
	make_from_file_buffer

feature -- Initialization

	make_from_file_buffer (a_buffer: YY_FILE_BUFFER)
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

feature -- Element Change

	fill
			-- Fill buffer with characters from `file'.
			-- Do not lose unprocessed characters in buffer.
			-- Resize buffer if necessary. Set `filled' to True
			-- if characters have been added to buffer.
		local
			nb, nb2, pos, end_pos, i: INTEGER
			buff: like content
		do
				-- If the last call to `fill' failed to add
				-- more characters, this means that the end of
				-- file has already been reached. Do not attempt
				-- to fill again the buffer in that case.
			if filled and not end_of_file then
					-- First move last characters to start of buffer
					-- and eventually resize `content' if necessary.
				compact_left
				buff := content
				nb := capacity - count
					-- Read in more data.
				if interactive then
					file.read_character
					if not file.end_of_input then
						put_character (file.last_character, buff).do_nothing
						filled := True
					else
						filled := False
						end_of_file := True
					end
				else
					pos := count + 1
					end_pos := pos + nb - 1
					from
						i := pos
					until
						i > end_pos
					loop
						file.read_character
						if not file.end_of_input then
							i := i + put_character (file.last_character, buff)
						else
							nb2 := i - pos - nb
							i := end_pos + 1
						end
					end
					nb2 := nb2 + i - pos

					if nb2 < nb then
						end_of_file := file.end_of_input
					end
					if nb2 > 0 then
						filled := True
					else
						filled := False
					end
				end
				buff.put (End_of_buffer_character, count + 1)
				buff.put (End_of_buffer_character, count + 2)
			else
				filled := False
			end
		end

	put_character (a_char: CHARACTER; a_buff: like content): INTEGER
			-- Put `a_char' into `a_buff'.
			-- Return the number of bytes put into `a_buff'
		require
			a_buff_not_void: a_buff /= Void
		do
			count := count + 1
			if a_char.code > 0x7F then
					-- Convert into UTF8
				string_buffer.put (a_char, 1)
				iso_8859_1.convert_to (utf8, string_buffer)
				if iso_8859_1.last_conversion_successful then
					a_buff.fill_from_string (iso_8859_1.last_converted_stream, count)
					count := count + iso_8859_1.last_converted_stream.count - 1
					Result := iso_8859_1.last_converted_stream.count
				else
						-- FIXME: We should raise a waring at least.
					a_buff.put (a_char, count)
					Result := 1
				end
			else
					-- UTF8 compatible
				a_buff.put (a_char, count)
				Result := 1
			end
		end

feature {NONE} -- Buffer

	string_buffer: STRING

invariant
	string_buffer_not_void: string_buffer /= Void

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
