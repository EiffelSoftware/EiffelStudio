note
	description:
		"Interface for a keyboard implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	KEYBOARD_I

inherit
	EV_KEY_CONSTANTS

feature -- Pressing

	press_key (a_key: EV_KEY)
			-- Press `a_key'.
		require
			a_key_valid: valid_key_code (a_key.code)
		deferred
		end

	release_key (a_key: EV_KEY)
			-- Release `a_key'.
		require
			a_key_valid: valid_key_code (a_key.code)
		deferred
		end

note
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
