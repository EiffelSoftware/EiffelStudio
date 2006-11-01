indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	TEXT_AREA_WINDOW

inherit
	DEMO_WINDOW

	EV_TEXT
		redefine
			make
		end
	WIDGET_COMMANDS
	TEXT_COMPONENT_COMMANDS

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		do
			Precursor {EV_TEXT} (par)
			append_text ("This is a text area.")
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "text area")
			add_text_component_commands (Current, event_window, "Text area")
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_primitive_tabs
			tab_list.extend (text_component_tab)
			tab_list.extend (text_tab)
			create action_window.make (Current, tab_list)
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


end -- class TEXT_AREA_WINDOW

