note
	description	: "Simple program demonstrating the use of cursors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURSOR_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	make_and_launch
			-- Create and launch.
		do
			default_create
			prepare
			launch
		end

	prepare
			-- Initialize world.
		do
			first_window.show
			destroy_actions.extend (agent destroy)
		end

feature {NONE} -- Implementation

	first_window: MAIN_WINDOW
			-- The window with the drawable area.
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


end -- class CURSOR_TEST
