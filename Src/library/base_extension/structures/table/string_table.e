note
	description: "Hash tables, used to store items identified by string keys using same_string for comparison."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	warning: "[
		Modifying an object used as a key by an item present in a table will
		cause incorrect behavior. If you will be modifying key objects,
		pass a clone, not the object itself, or an immutable object, as key argument to
		`put' and `replace_key'.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_TABLE [G]

inherit
	HASH_TABLE [G, READABLE_STRING_GENERAL]
		redefine
			same_keys
		end

create
	make

feature -- Comparison

	same_keys (a_search_key, a_key: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_search_key' the same key as `a_key' ?
		do
			Result := a_search_key.same_string (a_key)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
