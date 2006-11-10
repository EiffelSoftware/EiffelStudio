indexing
	description:
		"Keyboard constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	KEYS

inherit
	EV_KEY_CONSTANTS

feature -- Status report

	is_valid_key (a_key: EV_KEY): BOOLEAN is
			-- Is `a_key' a valid key?
		require
			a_key_not_void: a_key /= Void
		do
			Result := valid_key_code (a_key.code)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
