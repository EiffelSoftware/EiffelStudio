indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	CURSOR_WINDOW

inherit
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
			cmd: EV_ROUTINE_COMMAND
			frame: EV_FRAME
			color: EV_BASIC_COLORS
			code: EV_CURSOR_CODE
			pix: EV_PIXMAP
		do
			{EV_VERTICAL_BOX} Precursor (par)
			!! color
			!! frame.make_with_text (Current, "Busy...")
			frame.set_foreground_color (color.red)
			!! pix.make_from_file ("d:\divers_kaci\cfg\lak2.bmp")
--			!! cur.make_by_pixmap (pix)
	--		frame.set_cursor (cur)

			!! frame.make_with_text (Current, "another cursor")
			frame.set_foreground_color (color.red)
			!! code.make
			!! cur.make_by_code (code.busy)
			frame.set_cursor (cur)
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
