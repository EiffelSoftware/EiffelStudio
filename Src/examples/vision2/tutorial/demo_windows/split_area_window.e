indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	SPLIT_AREA_WINDOW

inherit
	EV_VERTICAL_SPLIT_AREA
		redefine
			make
		end
	DEMO_WINDOW
	WIDGET_COMMANDS

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We first create the split area without parent,
			-- it is more efficient.
		do
			Precursor {EV_VERTICAL_SPLIT_AREA} (Void)
			create hsplit.make (Current)
			set_position (50)
			create button.make_with_text (hsplit, "Hello")
			hsplit.set_position (100)
			create texta.make (Current)
			set_position (50)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "split area")
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_container_tabs
			tab_list.extend (split_area_tab)
			create action_window.make (hsplit, tab_list)
		end

feature -- Access

	hsplit: EV_HORIZONTAL_SPLIT_AREA
		-- An horizontal split area for the demo

	button: EV_BUTTON
		-- A button for the demo

	texta: EV_TEXT;
		-- A text are for the demo

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


end -- class SPLIT_AREA_WINDOW

