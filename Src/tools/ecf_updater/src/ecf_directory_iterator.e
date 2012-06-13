note
	description: "Summary description for {REGEXP_DIRECTORY_ITERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_DIRECTORY_ITERATOR

inherit
	DIRECTORY_ITERATOR
		redefine
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

	action: PROCEDURE [ANY, TUPLE [READABLE_STRING_GENERAL]]

feature -- Visitor

	process_file (fn: READABLE_STRING_GENERAL)
		do
			action.call ([fn])
		end

feature -- Status

	directory_excluded (dn: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := dn.starts_with (".") or dn.same_string ("EIFGENs")
		end

	file_excluded (fn: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := not fn.ends_with (".ecf")
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
