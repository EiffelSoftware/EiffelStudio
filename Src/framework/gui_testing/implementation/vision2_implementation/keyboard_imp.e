note
	description:
		"Implementation for a keyboard interface which sends event via Vision2's EV_SCREEN"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	KEYBOARD_IMP

inherit
	KEYBOARD_I

feature -- Pressing

	press_key (a_key: EV_KEY)
			-- Press `a_key'.
		do
			screen.fake_key_press (a_key)
		end

	release_key (a_key: EV_KEY)
			-- Release `a_key'.
		do
			screen.fake_key_release (a_key)
		end

feature {NONE} -- Implementation

	screen: EV_SCREEN
			-- Screen
		once
			create Result
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
