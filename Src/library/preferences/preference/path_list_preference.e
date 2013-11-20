note
	description: "List of path preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PATH_LIST_PREFERENCE

inherit
	LIST_PREFERENCE [PATH]

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature {NONE} -- Implementation

	new_value: LIST [PATH]
		do
			create {ARRAYED_LIST [PATH]} Result.make (0)
		end

	auto_default_value: LIST [PATH]
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			create {ARRAYED_LIST [PATH]} Result.make (0)
		end

	item_to_string_representation (obj: PATH): STRING_32
			-- String representation of `obj'.
		do
			Result := obj.name
		end

	item_from_string_representation (s: STRING_32): PATH
			-- Item from string representation `s'.
		do
			create Result.make_from_string (s)
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
