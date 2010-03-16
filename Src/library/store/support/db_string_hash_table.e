note
	description: "HASH_TABLE where keys are of type STRING."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	DB_STRING_HASH_TABLE [G]

inherit
	HASH_TABLE [G, STRING]
		redefine
			same_keys
		end

create
	make

feature -- Comparison

	same_keys (a_search_key, a_key: STRING_8): BOOLEAN
			-- See if `a_search_key' and `a_key' have the same content.
		do
				-- When code is completely void-safe we can remove the check.
			if a_search_key /= Void and a_key /= Void then
				Result := a_search_key.same_string (a_key)
			end
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
