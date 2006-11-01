indexing
	description:
		"The demo that goes with the range demo"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RANGE_WINDOW

inherit
	EV_HORIZONTAL_RANGE
		redefine
			make
		end

	DEMO_WINDOW
	WIDGET_COMMANDS

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in 'par'.
			-- We create the table first without parent as it
			-- is faster.
		do
			Precursor {EV_HORIZONTAL_RANGE} (par)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "range")
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_gauge_tabs
			tab_list.extend(range_tab)
			create action_window.make(Current,tab_list)
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


end -- class RANGE_WINDOW

