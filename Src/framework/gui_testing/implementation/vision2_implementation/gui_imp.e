indexing
	description:
		"Implementation for a GUI lookip interface which has direct access on EV_APPLICATION"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GUI_IMP

inherit
	GUI_I

feature {NONE} -- Initialization

feature -- Access

	application_under_test: EV_APPLICATION
			-- Application under test

	screen: EV_SCREEN is
			-- Screen
		once
			create Result
		end

	active_window: EV_WINDOW
			-- Active window

feature -- Element change

	set_application_under_test (an_application: like application_under_test) is
			-- Set `active_window' to `a_window'.
		do
			application_under_test := an_application
		ensure
			application_under_test_set: application_under_test = an_application
		end

	set_active_window (a_window: like active_window) is
			-- Set `active_window' to `a_window'.
		do
			active_window := a_window
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
