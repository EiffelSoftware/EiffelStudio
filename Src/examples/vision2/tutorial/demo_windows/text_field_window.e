indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	TEXT_FIELD_WINDOW

inherit
	EV_VERTICAL_BOX
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'. For efficiency, we first
			-- create the box without parent.
		local
			frame: EV_FRAME
		do
			{EV_VERTICAL_BOX} Precursor (Void)
			!! frame.make_with_text (Current, "A Text Field")
			!! textfield.make_with_text (frame, "Edit me")
			!! frame.make_with_text (Current, "A Password Field")
			!! passwordfield.make_with_text (frame, "Me too")
			set_parent (par)
		end

feature -- Access

	TextField: EV_TEXT_FIELD
			-- A text field in the demo

	PasswordField: EV_PASSWORD_FIELD
			-- A password field

end -- class TEXT_FIELD_WINDOW

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
