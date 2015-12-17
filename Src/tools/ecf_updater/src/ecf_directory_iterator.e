note
	description: "[
				Iterator on .ecf files
				It iterates recursively on directory and process .ecf files
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_DIRECTORY_ITERATOR

inherit
	DIRECTORY_ITERATOR
		redefine
			path_excluded,
			directory_excluded,
			file_excluded,
			process_file
		end

create
	make

feature {NONE} -- Initialization

	make (a_action: like action)
		do
			action := a_action
		end

	action: PROCEDURE [PATH]

feature -- Visitor

	process_file (fn: PATH)
		do
			action.call ([fn])
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
			Result := s.starts_with ({STRING_32} ".") or s.same_string (eifgens_string)
		end

	file_excluded (fn: PATH): BOOLEAN
		do
			Result := not fn.name.ends_with (dot_ecf_string)
		end

feature {NONE} -- Constants

	eifgens_string: STRING_32 = "EIFGENs"

	dot_ecf_string: STRING_32 = ".ecf"

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
