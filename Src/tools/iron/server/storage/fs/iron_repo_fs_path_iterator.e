note
	description: "[
				Iterator on package files
				It iterates recursively on directory and process files
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPO_FS_PATH_ITERATOR

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
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
