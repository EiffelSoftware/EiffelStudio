note
	description: "List of string_32 preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date:"
	revision: "$Revision$"

class
	STRING_LIST_PREFERENCE

inherit
	LIST_PREFERENCE [STRING_32]

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature {NONE} -- Implementation

	new_value: LIST [STRING_32]
		do
			create {ARRAYED_LIST [STRING_32]} Result.make (0)
		end

	auto_default_value: LIST [STRING_32]
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			Result := new_value
		end

	item_to_string_representation (obj: STRING_32): STRING_32
			-- String representation of `obj'.
		do
			Result := obj
		end

	item_from_string_representation (s: STRING_32): STRING_32
			-- Item from string representation `s'.
		do
			Result := s.twin
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
