indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	BOX_WINDOW

inherit
	EV_HORIZONTAL_BOX
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- For efficiency, we first create the box without
			-- parent.
		do
			{EV_HORIZONTAL_BOX} Precursor (Void)
			set_border_width (10)
			!! button.make_with_text (Current, "Press me")
			!! button.make_with_text (Current, "Button with a very long label")
			!! button.make_with_text (Current, "Button 3")
			set_parent (par)
		end

feature -- Access

	button: EV_BUTTON
		-- A button for the demo

end -- class BOX_WINDOW

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
