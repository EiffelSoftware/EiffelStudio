note
	description: "Summary description for {EIMGEMB}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIMGEMB

create
	make

feature {NONE} -- Initialization

	make (pix: EV_PIXEL_BUFFER)
		do
			pixmap := pix
		end

feature -- Access

	pixmap: EV_PIXEL_BUFFER

feature -- Helpers

	eiffel_file_name_suggestion (loc: PATH): PATH
		do
			create Result.make_from_string (eiffel_class_name_suggestion (loc).as_lower)
			Result := Result.appended_with_extension ("e")
		end

	eiffel_class_name_suggestion (loc: PATH): STRING_8
		local
			p: PATH
			s: STRING_32
		do
			p := loc.entry
			if p = Void then
				p := loc
			end
			s := p.name.as_upper
			if attached p.extension as ext then
				s.remove_tail (ext.count + 1)
			end
			if
				not s.is_valid_as_string_8
			 	or else not (create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (s.to_string_8)
			then
				Result := {STRING_8} "NEW_PIXMAP_MATRIX"
			else
				Result := s.to_string_8
			end
		end

feature -- Generator		

	to_eiffel_class_text (a_class_name: READABLE_STRING_8): STRING_8
			-- Eiffel code
		local
			pix: EV_PIXEL_BUFFER
			i, j: INTEGER
			colors: ARRAYED_LIST [ARRAYED_LIST [NATURAL_32]]
			l_arrayed_list : ARRAYED_LIST [NATURAL_32]
			l_width: INTEGER
			l_iterator: EV_PIXEL_BUFFER_ITERATOR
			l_item: EV_PIXEL_BUFFER_PIXEL
			code_producer: CODE_PRODUCER
		do
			pix := pixmap

			l_width := pix.width
			create Result.make_empty
			create colors.make (pix.width)
			from
				i := 1
				pix.lock
				l_iterator := pix.pixel_iterator
				l_iterator.start
			until
				i > pix.height

			loop
				create l_arrayed_list.make (l_width)
				colors.extend (l_arrayed_list)
				from
					j := 1
				until
					j > l_width
				loop
					l_item := l_iterator.item
					l_arrayed_list.extend (l_item.rgba_value)
					l_iterator.forth

					j := j + 1
				end
				i := i + 1
			end
			pix.unlock

			create code_producer
			Result.append (code_producer.build_top_code (a_class_name))
			Result.append (code_producer.build_initialization_code (pix.width, pix.height))
			Result.append (code_producer.build_c_external_data_code (pix))
			Result.append (code_producer.build_colors_code)
			Result.append (code_producer.new_line)
			Result.append (code_producer.build_fill_memory_code (colors, pix.width, pix.height))
			Result.append (code_producer.new_line)
			Result.append ("end%N")
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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
