indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	TABLE_WINDOW

inherit
	EV_TABLE
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- First, we put a Void parent because it is faster
		do
			{EV_TABLE} Precursor (Void)

			!! button.make_with_text (Current, "OK")
			set_child_position (button, 0, 0, 1, 1)
			!! button.make_with_text (Current, "KO")
			set_child_position (button, 1, 0, 3, 1)
			!! note.make (Current)
			!! button.make_with_text (note, "Press me")
			note.append_page (button, "Page 1")
			!! button.make_with_text (note, "Me too")
			note.append_page (button, "Page 2")
			set_child_position (note, 1, 1, 3, 5)
			!! text.make (Current)
			set_child_position (text, 0, 1, 1, 5)

	--		set_homogeneous (false)
			set_row_spacing (5)
			set_column_spacing (5)

			set_parent (par)
		end

feature -- Access

	note: EV_NOTEBOOK
		-- A notebook for the demo

	text: EV_TEXT_FIELD
		-- A text field for the demo

	button: EV_BUTTON
		-- A button for the demo

end -- class TABLE_WINDOW

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
