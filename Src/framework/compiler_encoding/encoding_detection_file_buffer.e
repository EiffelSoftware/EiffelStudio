note
	description: "[
					Buffer to detect file encoding according to leading characters. 
					Characters read rather than BOM will be maitained and able be
					reused by other buffers.
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ENCODING_DETECTION_FILE_BUFFER

inherit
	YY_UNICODE_FILE_BUFFER

	STRING_HANDLER

	BOM_ENCODING_DETECTOR

create
	make_with_size

feature -- Detection

	detect_file
			-- Detect the encoding in file, and make the buffer ready for parsing.
		local
			l_lead: STRING_8
			buff: like content
			l_file: like file
			l_count: INTEGER
		do
			detected_encoding := Void
			last_bom_count := 0
			last_detection_successful := False
			last_bom := Void
			if not end_of_file then
				l_file := file
				compact_left
					-- A BOM has at most 4 bytes.
				create l_lead.make (4)
				l_lead.set_count (4)
				l_count := l_file.read_to_string (l_lead, 1, 4)
				if l_count > 0 then
					l_lead.set_count (l_count)
					buff := content
					detect (l_lead)
					if last_detection_successful then
						buff.fill_from_string (l_lead.substring (last_bom_count + 1, l_lead.count), 1)
						count := count + l_lead.count - last_bom_count
						set_default_encoding (utf8_encoding)
						encoding := utf8_encoding
					else
						buff.fill_from_string (l_lead, 1)
						count := count + l_lead.count
						set_default_encoding (iso_8859_1_encoding)
						encoding := iso_8859_1_encoding
					end
					buff.put (End_of_buffer_character, count + 1)
					buff.put (End_of_buffer_character, count + 2)
				end
			end
		ensure
			detected_encoding_set_when_found: last_detection_successful implies detected_encoding /= Void
		end

note
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
