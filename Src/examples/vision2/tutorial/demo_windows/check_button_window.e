indexing
	description:
		"The demo that goes with the button demo";
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


creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the box first without parent because it
			-- is faster.
		do
			{EV_CHECK_BUTTON} Precursor (par)
			set_text ("Check Button")
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "toggle button")
			add_button_commands (Current, event_window, "Toggle button")
			add_toggle_button_commands (Current, event_window, "Toggle button")
		end

	set_tabs is
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
	check_b: EV_CHECK_BUTTON
end -- class BUTTON_WINDOW

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

