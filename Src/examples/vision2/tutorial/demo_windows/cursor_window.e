indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	CURSOR_WINDOW

inherit
	DEMO_WINDOW

	EV_VERTICAL_BOX
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			frame: EV_FRAME
			color: EV_BASIC_COLORS
			code: EV_CURSOR_CODE
			pix: EV_PIXMAP
			but: EV_BUTTON
			hbox: EV_HORIZONTAL_BOX
		do
			{EV_VERTICAL_BOX} Precursor (par)
			!! color
			!! code.make

			!! frame.make_with_text (Current, "Busy...")
			frame.set_foreground_color (color.red)

			!! frame.make_with_text (Current, "another cursor")
			frame.set_foreground_color (color.red)
			create hbox.make (frame)
			hbox.set_border_width (20)
			hbox.set_spacing (20)
			!! cur.make_by_code (code.busy)
			frame.set_cursor (cur)
			create but.make_with_text (hbox, "Button 1")
			!! cur.make_by_code (code.crosshair)
			but.set_cursor (cur)
			create but.make_with_text (hbox, "Button 2")
		end

	set_tabs is
			-- Set the tabs for the action window
		do
		end


feature -- Access

	cur: EV_CURSOR
		-- A cursor used for the demo.

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
		end

	execute2 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
		end

	execute3 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
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
