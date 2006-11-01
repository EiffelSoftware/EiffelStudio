indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	FRAME_WINDOW

inherit
	EV_FRAME
		redefine
			make
		end

	DEMO_WINDOW
	WIDGET_COMMANDS

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'. For efficiency, we
			-- first create the frame without parent.

		do
			Precursor {EV_FRAME} (par)
			set_text ("A frame with text")
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "frame")
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_container_tabs
			create frame_tab.make(Void)
			tab_list.extend(frame_tab)
			create action_window.make(Current,tab_list)	
		end

feature -- Access

	frame_tab: FRAME_TAB;

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


end -- class SCROLLABLE_WINDOW

