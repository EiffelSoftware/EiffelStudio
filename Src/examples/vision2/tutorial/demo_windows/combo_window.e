indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	COMBO_WINDOW

inherit
	EV_COMBO_BOX
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
			{EV_COMBO_BOX} Precursor (par)

			!! item1.make_with_text (Current, "Item 1")
			!! item2.make (Current)
			item2.set_text ("Item 2")
			item2.set_selected (True)
			!! item3.make_with_text (Current, "Item 3")
		end

feature -- Access

	item1: EV_LIST_ITEM
			-- an item

	item2: EV_LIST_ITEM
			-- an item

	item3: EV_LIST_ITEM
			-- an item

end -- class COMBO_WINDOW

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
