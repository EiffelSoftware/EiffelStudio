indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	SPLIT_AREA_WINDOW

inherit
	EV_VERTICAL_SPLIT_AREA
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We first create the split area without parent,
			-- it is more efficient.
		do
			{EV_VERTICAL_SPLIT_AREA} Precursor (Void)
			!! hsplit.make (Current)
			!! button.make_with_text (hsplit, "Hello")
			!! texta.make (Current)
			set_parent (par)
		end

feature -- Access

	hsplit: EV_HORIZONTAL_SPLIT_AREA
		-- An horizontal split area for the demo

	button: EV_BUTTON
		-- A button for the demo

	texta: EV_TEXT_AREA
		-- A text are for the demo

end -- class SPLIT_AREA_WINDOW

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
