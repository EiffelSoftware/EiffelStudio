note
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	TOOLTIP_WINDOW

inherit
	DEMO_WINDOW

	EV_VERTICAL_BOX
		redefine
			make
		end

	EV_COMMAND

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER)
			-- Create the demo in `par'.
		local
			frame: EV_FRAME
			button: EV_BUTTON
		do
			Precursor {EV_VERTICAL_BOX} (par)
			create tooltip.make

			create button.make_with_text (Current, "Move mouse over button.")
			create frame.make_with_text (Current, "Empty Frame.")
			tooltip.add_tip (button, "I am a Tool Tip!")
			tooltip.enable
		end

	set_tabs
			-- Set the tabs for the action window.
		do
			create tab_list.make
			tab_list.extend (tool_tip_tab)
			create action_window.make (tooltip, tab_list)
			tool_tip_tab.set_colors
		end

feature -- Access

	tooltip: EV_TOOLTIP
			-- A tooltip for the window.

feature -- Execution Feature

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA)
		do
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


end -- class CURSOR_WINDOW

