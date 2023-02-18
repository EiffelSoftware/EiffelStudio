note
	description: "Represents a mutable INI document."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_DOCUMENT

inherit
	INI_PROPERTY_CONTAINER
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize current INI document.
		do
			Precursor {INI_PROPERTY_CONTAINER}
			create sections.make (0)
		end

feature -- Access

	document: INI_DOCUMENT
			-- Document section belongs to
		do
			Result := Current
		end

	sections: ARRAYED_LIST [INI_SECTION]
			-- Document sections

	is_empty: BOOLEAN
			-- Is document empty?
		do
			Result := sections.is_empty and properties.is_empty
		end

feature -- Query

	sections_of_name (a_name: STRING; a_ignore_case: BOOLEAN): ARRAYED_LIST [INI_SECTION]
			-- Retrieves a list of sections by name
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_sect: INI_SECTION
			l_equal: BOOLEAN
		do
			create Result.make (0)
			across
				sections as s
			loop
				l_sect := s
				if a_ignore_case then
					l_equal := l_sect.label.is_case_insensitive_equal (a_name)
				else
					l_equal := l_sect.label.is_equal (a_name)
				end
				if l_equal then
					Result.extend (l_sect)
				end
			end
		ensure
			result_attached: Result /= Void
		end

	section_of_name (a_name: STRING; a_ignore_case: BOOLEAN): detachable INI_SECTION
			-- Retrieves first section of name `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_sects: like sections
			l_sect: INI_SECTION
			l_cursor: CURSOR
			l_equal: BOOLEAN
		do
			l_sects := sections
			if not l_sects.is_empty then
				l_cursor := l_sects.cursor
				from l_sects.start until l_sects.after or Result /= Void loop
					l_sect := l_sects.item
					if a_ignore_case then
						l_equal := l_sect.label.is_case_insensitive_equal (a_name)
					else
						l_equal := l_sect.label.is_equal (a_name)
					end
					if l_equal then
						Result := l_sect
					end
					l_sects.forth
				end
				l_sects.go_to (l_cursor)
			end
		ensure
			result_attached: not sections_of_name (a_name, a_ignore_case).is_empty implies Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
