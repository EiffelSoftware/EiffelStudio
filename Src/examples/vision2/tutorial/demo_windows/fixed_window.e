indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	FIXED_WINDOW

inherit
	EV_FIXED
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			{EV_FIXED} Precursor (par)

			!!button1.make (Current)
			!!button2.make (Current)

			button1.set_text ("Press me")
			!! cmd.make (~execute1)
			button1.add_click_command (cmd, Void)
			button2.set_text ("Me too!")
			button1.set_x_y (10, 20)
			button2.set_x_y (10, 50)
		end

feature -- Access

	button1: EV_BUTTON
			-- a button for the demo

	button2: EV_BUTTON
			-- a button for the demo

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
			button2.set_x_y (button2.x + 10, button2.y + 10)
		end

end -- class FIXED_WINDOW

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
