note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class STATES

feature 

	exit_from_application: INTEGER = -2

	return_to_previous: INTEGER = -1

	basic: INTEGER = 1
			-- BASIC

	editing: INTEGER = 2
			-- Editing

	viewing: INTEGER = 3;
			-- Viewing

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


end -- class STATES
