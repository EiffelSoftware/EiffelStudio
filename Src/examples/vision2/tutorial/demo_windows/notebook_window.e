indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	NOTEBOOK_WINDOW

inherit
	EV_NOTEBOOK
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- For efficiency, we first create the notebook 
			-- without parent.
		do
			{EV_NOTEBOOK} Precursor (Void)
			!! button1.make (Current)
			!! box.make (Current)
			!! button_box.make_with_text (box, "button 1")
			!! button_box.make_with_text (box, "button 2")
			!! button_box.make_with_text (box, "button 3")
			!! button_box.make_with_text (box, "button 4")
			button1.set_text ("Button")			
			append_page (button1, "Button")
			append_page (box, "Pixmap 2")
			set_current_page (2)
			set_parent (par)
		end

feature -- Access

	button1, button_box: EV_BUTTON
		-- Buttons for the demo

	box: EV_VERTICAL_BOX
		-- Box for the demo

end -- class NOTEBOOK_WINDOW

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
