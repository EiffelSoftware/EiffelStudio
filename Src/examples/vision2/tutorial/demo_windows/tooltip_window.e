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

			create button.make_with_text (Current, "Where are you?")
			tooltip.add_tip (button, "I am here!")
			create button.make_with_text (Current, "You want to change the color?")
			tooltip.add_tip (button, "Click me then.")
			button.add_click_command (Current, Void)
			tooltip.enable
		end

feature -- Access

	tooltip: EV_TOOLTIP
			-- A tooltip for the window.

feature -- Execution feature

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
				-- Change of color.
		local
			color: EV_BASIC_COLORS
		do
			create color
			tooltip.set_foreground_color (color.yellow)
			tooltip.set_background_color (color.dark_blue)
		end

end -- class CURSOR_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
