note
	description: "[
					Microsoft Ribbon makrup XML callbacks when saving XML

				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_XML_OUTPUT_STREAM

inherit
	XML_OUTPUT_STREAM

create
	make

feature {NONE} -- Initialization

	make (a_index: INTEGER)
			-- Create stream
		require
			valid: a_index >= 1
		local
			l_file: like file
			l_constants: ER_MISC_CONSTANTS
		do
			create l_constants
			if attached l_constants.xml_full_file_name (a_index) as l_file_name then
				create l_file.make_with_path (l_file_name)
				file := l_file
				l_file.create_read_write
			else
				Check should_not_happen: False end
			end
		end

feature -- Access

	name: STRING = "eiffel_ribbon_output_stream"
			-- Name of current stream

feature -- Status report

	is_open_write: BOOLEAN = True
			-- <Precursor>

feature -- Basic operation

	flush
			-- Flush buffered data to stream.
		do
			if attached file as l_file then
				l_file.flush
			end
		end

	close
			-- Close file handle
		do
			if attached file as l_file then
				l_file.close
			end
		end

feature -- Output

	put_character_8 (c: CHARACTER)
			-- <Precursor>
		do
			if attached file as l_file then
				l_file.put_character (c)
			end
		end

	put_character_32 (c: CHARACTER_32)
			-- <Precursor>
		local
			u: UTF_CONVERTER
		do
			if attached file as l_file then
				l_file.put_string (u.string_32_to_utf_8_string_8 (create {STRING_32}.make_filled (c, 1)))
			end
		end

	put_string_32 (a_string: READABLE_STRING_32)
			-- Write `a_string' to output stream.
		local
			u: UTF_CONVERTER
		do
			if attached file as l_file then
				l_file.put_string (u.string_32_to_utf_8_string_8 (a_string))
			end
		end

	put_string_8 (a_string: READABLE_STRING_8)
			-- Write `a_string' to output stream.
		local
			u: UTF_CONVERTER
		do
			if attached file as l_file then
				l_file.put_string (u.string_32_to_utf_8_string_8 (a_string))
			end
		end

feature {NONE} -- Implementation

	file: detachable RAW_FILE
			-- XML file

;note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
