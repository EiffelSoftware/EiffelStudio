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
		do
			{EV_VERTICAL_BOX} Precursor (par)
			!! color
			!! code.make

			!! frame.make_with_text (Current, "Normal Cursor")

			!! frame.make_with_text (Current, "Busy Cursor")
			!! cur.make_by_code (code.busy)
			frame.set_cursor (cur)
			!! frame.make_with_text (Current, "Crosshair Cursor")
			!! cur.make_by_code (code.crosshair)
			frame.set_cursor (cur)
			!! frame.make_with_text (Current, "Help Cursor")
			!! cur.make_by_code (code.help)
			frame.set_cursor (cur)
			!! frame.make_with_text (Current, "Ibeam Cursor")
			!! cur.make_by_code (code.ibeam)
			frame.set_cursor (cur)
			!! frame.make_with_text (Current, "No Cursor")
			!! cur.make_by_code (code.no)
			frame.set_cursor (cur)
			!! frame.make_with_text (Current, "Sizeall Cursor")
			!! cur.make_by_code (code.sizeall)
			frame.set_cursor (cur)
			!! frame.make_with_text (Current, "Sizens Cursor")
			!! cur.make_by_code (code.sizens)
			frame.set_cursor (cur)
			!! frame.make_with_text (Current, "Sizewe Cursor")
			!! cur.make_by_code (code.sizewe)
			frame.set_cursor (cur)
			!! frame.make_with_text (Current, "Uparrow Cursor")
			!! cur.make_by_code (code.uparrow)
			frame.set_cursor (cur)
			!! frame.make_with_text (Current, "Wait Cursor")
			!! cur.make_by_code (code.wait)
			frame.set_cursor (cur)
		end

	set_tabs is
			-- Set the tabs for the action window
		do
		end


feature -- Access

	cur: EV_CURSOR
		-- A cursor used for the demo.

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

