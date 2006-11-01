indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	RADIO_BUTTON_WINDOW

inherit
	EV_HORIZONTAL_BOX
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

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the box first without parent because it
			-- is faster.
		local
			radio: EV_RADIO_BUTTON
		do
			Precursor {EV_HORIZONTAL_BOX} (par)

			set_homogeneous (False)
			create radio.make_with_text (Current, "Dummy Radio")
			create radio_b.make_with_text (Current, "Action Button")
			create event_window.make (radio_b)
			add_widget_commands (radio_b, event_window, "toggle button")
			add_button_commands (radio_b, event_window, "Toggle button")
			add_toggle_button_commands (radio_b, event_window, "Toggle button")
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_primitive_tabs
			tab_list.extend(textable_tab)
			tab_list.extend(fontable_tab)
			tab_list.extend(pixmapable_tab)
			tab_list.extend(toggle_button_tab)
			tab_list.extend(check_button_tab)
			tab_list.extend(radio_button_tab)
			create action_window.make(radio_b, tab_list)
		end

feature -- Access

	radio_b: EV_RADIO_BUTTON;

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


end -- class BUTTON_WINDOW

