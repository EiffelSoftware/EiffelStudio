note
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CHECK_BUTTON_WINDOW

inherit
	EV_CHECK_BUTTON
		redefine
			make
		end

	DEMO_WINDOW
	WIDGET_COMMANDS
	BUTTON_COMMANDS
	TOGGLE_BUTTON_COMMANDS


create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER)
			-- Create the demo in `par'.
			-- We create the box first without parent because it
			-- is faster.
		do
			Precursor {EV_CHECK_BUTTON} (par)
			set_text ("Check Button")
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "toggle button")
			add_button_commands (Current, event_window, "Toggle button")
			add_toggle_button_commands (Current, event_window, "Toggle button")
		end

	set_tabs
			-- Set the tabs for the action window
		do
			set_primitive_tabs
			tab_list.extend(textable_tab)
			tab_list.extend(fontable_tab)
			tab_list.extend(pixmapable_tab)
			tab_list.extend(toggle_button_tab)
			tab_list.extend(check_button_tab)
			create action_window.make(Current,tab_list)
		end

feature -- Access
	check_b: EV_CHECK_BUTTON;
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


end -- class BUTTON_WINDOW

