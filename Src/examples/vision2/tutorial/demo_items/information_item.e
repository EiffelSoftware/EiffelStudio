indexing
	description:
		"A Demo for error message dialog";
	date: "$Date$";
	revision: "$Revision$"

class 
	INFORMATION_ITEM

inherit
	DEMO_ITEM
		redefine
			demo_window
		end

creation
	make

feature {NONE} -- Initialization

	make (par:EV_TREE_ITEM_HOLDER) is
			-- Create the item and the demo that
			-- goes with it.
		do
			make_with_title (par, "EV_INFORMATION")
		end

	create_demo is
			-- Create the demo_window.
		do
			!! demo_window.make (demo_page)
		end

feature -- Access

	demo_window: INFORMATION_WINDOW

end -- class INFORMATION_ITEM

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
