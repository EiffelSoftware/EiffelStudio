indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	BUTTON_WINDOW

inherit
	DEMO_WINDOW

	EV_BUTTON
		redefine
			make
		end

	WIDGET_COMMANDS
	BUTTON_COMMANDS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the box first hidden because it
			-- is faster.
		local
			color: EV_COLOR
			set_col: EV_COLOR
		do
			{EV_BUTTON} Precursor (par)
			hide
			make_with_text (par, "Button")
			create color.make_rgb (100,0,0)
			set_background_color (color)
			set_col := background_color
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "button")
			add_button_commands (Current, event_window, "Button")
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window
		do
			set_primitive_tabs
			create action_window.make (Current,tab_list)
		end		
	
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

