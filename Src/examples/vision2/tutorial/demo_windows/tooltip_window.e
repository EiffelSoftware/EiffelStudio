indexing
	description:
		"The demo that goes with the button demo";
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

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			frame: EV_FRAME
			button: EV_BUTTON
		do
			{EV_VERTICAL_BOX} Precursor (par)
			create tooltip.make

			create button.make_with_text (Current, "Move mouse over button.")
			create frame.make_with_text (Current, "Empty Frame.")
			tooltip.add_tip (button, "I am a Tool Tip!")
			tooltip.enable
		end

	set_tabs is
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

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
		end

end -- class CURSOR_WINDOW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

