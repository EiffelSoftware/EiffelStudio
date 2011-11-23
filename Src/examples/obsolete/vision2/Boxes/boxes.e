note
	description:
		"Root class of the boxes example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	BOXES

create
	make

feature {NONE} -- Initialization

	make
		local
			l_app: EV_APPLICATION
		do
			create l_app
			create first_window.make_top_level
			first_window.show
			first_window.close_request_actions.extend (agent first_window.destroy_and_exit_if_last)
			l_app.launch
		end

feature -- Initialization

	first_window: MAIN_WINDOW;
			-- Main window of the example

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


end -- class BOXES

