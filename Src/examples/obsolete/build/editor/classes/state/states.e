indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class STATES

feature 

	exit_from_application: INTEGER is -2

	return_to_previous: INTEGER is -1

	basic: INTEGER is 1
			-- BASIC

	editing: INTEGER is 2
			-- Editing

	viewing: INTEGER is 3;
			-- Viewing

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


end -- class STATES
