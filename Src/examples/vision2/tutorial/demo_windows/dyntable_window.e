indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	DYNTABLE_WINDOW

inherit
	EV_DYNAMIC_TABLE
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the table first without parent because
			-- it is faster.
		do
			{EV_DYNAMIC_TABLE} Precursor (Void)
			set_row_layout
			set_finite_dimension (2)

			!!button.make_with_text (Current, "Element 1")
			!!button.make_with_text (Current, "Element 2")
			!!button.make_with_text (Current, "Element 3")
			!!button.make_with_text (Current, "Element 4")
			!!button.make_with_text (Current, "Element 5")
			!!button.make_with_text (Current, "Element 6")
			!!button.make_with_text (Current, "Element 7")
			!!button.make_with_text (Current, "Element 8")
			!!button.make_with_text (Current, "Element 9")
			!!button.make_with_text (Current, "Element 10")
			!!button.make_with_text (Current, "Element 11")

			set_homogeneous (True)
			set_row_spacing (5)
			set_column_spacing (5)

			set_parent (par)
		end

feature -- Access

	button: EV_BUTTON
		-- A button for the demo

end -- class DYNTABLE_WINDOW

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
