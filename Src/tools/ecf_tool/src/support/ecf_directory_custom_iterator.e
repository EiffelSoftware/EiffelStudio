note
	description: "[
				Iterator on .ecf files
				It iterates recursively on directory and process .ecf files
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_DIRECTORY_CUSTOM_ITERATOR

inherit
	ECF_DIRECTORY_ITERATOR
		redefine
			directory_excluded
		end

create
	make

feature -- Access

	directory_excluded_function: detachable FUNCTION [PATH, BOOLEAN]

feature -- Change

	set_directory_excluded_function (f: like directory_excluded_function)
		do
			directory_excluded_function := f
		end

feature -- Status

	directory_excluded (dn: PATH): BOOLEAN
		do
			Result := Precursor (dn)
			if not Result and then attached directory_excluded_function as f then
				Result := f.item ([dn])
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
