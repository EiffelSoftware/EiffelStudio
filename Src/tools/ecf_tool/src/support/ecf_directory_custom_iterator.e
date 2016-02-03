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
			directory_excluded,
			process_directory
		end

create
	make

feature -- Operation

	process_directory (dn: PATH)
			-- Iterate on directory `dn'
			-- process files first and then directories recursively.
		do
			if attached process_directory_action as act then
				act.call (dn)
			end
			Precursor (dn)
		end

feature -- Access

	directory_excluded_function: detachable FUNCTION [PATH, BOOLEAN]

	process_directory_action: detachable PROCEDURE [PATH]

feature -- Change

	set_directory_excluded_function (f: like directory_excluded_function)
		do
			directory_excluded_function := f
		end

	set_process_directory_action (act: like process_directory_action)
		do
			process_directory_action := act
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
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
