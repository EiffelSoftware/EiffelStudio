note
	description: "[
				Iterator on package files
				It iterates recursively on directory and process files
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_FS_PATH_ITERATOR

inherit
	DIRECTORY_ITERATOR
		redefine
			path_excluded,
			directory_excluded,
			file_excluded,
			process_directory,
			process_file
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create file_actions
			create directory_actions
		end

feature -- Actions		

	file_actions: ACTION_SEQUENCE [TUPLE [PATH]]
	directory_actions: ACTION_SEQUENCE [TUPLE [PATH]]

feature -- Visitor

	process_file (fn: PATH)
		do
			file_actions.call ([fn])
			Precursor (fn)
		end

	process_directory (dn: PATH)
		do
			directory_actions.call ([dn])
			Precursor (dn)
		end

feature -- Status

	path_excluded (a_path: PATH): BOOLEAN
		do
			Result := a_path.name.starts_with ({STRING_32} ".")
		end

	directory_excluded (dn: PATH): BOOLEAN
		local
			s: STRING_32
		do
			s := dn.name
			Result := s.starts_with ({STRING_32} ".")  or s.starts_with ({STRING_32} "_")
		end

	file_excluded (fn: PATH): BOOLEAN
		do
			Result := False
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
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

end
