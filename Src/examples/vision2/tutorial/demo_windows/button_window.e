indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	BUTTON_WINDOW

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
			-- We create the box first without parent because it
			-- is faster.
		do
			{EV_VERTICAL_BOX} Precursor (Void)

			set_homogeneous (False)
			!! b1.make_with_text (Current, "Button")
--			!! pixmap.make_from_file (b1, the_parent.pixname("power_small.xpm"))
			!! b2.make (Current)
--			!! pixmap.make_from_file (b2, the_parent.pixname("power_small.xpm"))
			!! toggle_b.make_with_text (Current, "Toggle Button")
			!! check_b.make_with_text (Current, "Check Button")
			!! frame.make_with_text (Current, "Frame")
			!! box.make (frame)
			!! radio1_b.make_with_text (box, "Radio 1")
			!! radio2_b.make_with_text (box, "Radio 2")
			!! radio3_b.make_with_text (box, "Radio 3")

			set_parent (par)
		end

feature -- Access

	b1, b2, b3, b4: EV_BUTTON
	pixmap: EV_PIXMAP
	toggle_b: EV_TOGGLE_BUTTON
	check_b: EV_CHECK_BUTTON
	radio1_b: EV_RADIO_BUTTON
	radio2_b: EV_RADIO_BUTTON
	radio3_b: EV_RADIO_BUTTON
	frame: EV_FRAME
	box: EV_VERTICAL_BOX	

end -- class BUTTON_WINDOW

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
