indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	BUTTON_WINDOW

inherit
	DEMO_WINDOW

	EV_VERTICAL_BOX
		redefine
			make
		end

	PIXMAP_PATH

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the box first without parent because it
			-- is faster.
		local
			pixmap: EV_PIXMAP
		do
			{EV_VERTICAL_BOX} Precursor (par)

			set_homogeneous (False)
			!! b1.make_with_text (Current, "Button")

			!! b2.make (Current)
			create pixmap.make_from_file (pixmap_path ("save"))
			b2.set_pixmap (pixmap)
			!! toggle_b.make_with_text (Current, "Toggle Button")
			!! check_b.make_with_text (Current, "Check Button")
			!! check_b.make_with_text (Current, "Check 2")
			check_b.set_pixmap (pixmap)
			!! frame.make_with_text (Current, "Frame")
			!! box.make (frame)
			!! radio1_b.make_with_text (box, "Radio 1")
			!! radio2_b.make_with_text (box, "Radio 2")
			radio2_b.set_pixmap (pixmap)
			!! radio3_b.make_with_text (box, "Radio 3")

			--Sets the tabs for the action window
			set_primitive_tabs
			create action_window.make(Current,tab_list)
		end

feature -- Access

	b1, b2, b3, b4: EV_BUTTON
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
