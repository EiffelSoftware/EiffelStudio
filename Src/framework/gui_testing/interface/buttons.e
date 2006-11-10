indexing
	description:
		"Mouse button constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BUTTONS

feature -- Access

	left: INTEGER is 1
		-- Left mouse button

	right: INTEGER is 2
		-- Right mouse button

	middle: INTEGER is 3
		-- Middle mouse button

feature -- Status report

	is_valid_button (a_button: INTEGER): BOOLEAN is
			-- Is `a_button' a valid mouse button?
		do
			Result := a_button = left or a_button = right or a_button = middle
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
