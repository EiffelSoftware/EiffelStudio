indexing
	description: "Demo for text figures."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_FIGURE_ITEM

inherit
	FIGURE_ITEM

creation
	make

feature {NONE} -- Initialization

	make (par: EV_TREE_ITEM_HOLDER) is
			-- Create the item and the demo that
			-- goes with it.
		do
			make_with_title (par, "EV_TEXT_FIGURE")
		end

feature -- Access

	figure: EV_TEXT_FIGURE is
		local
			pt: EV_POINT
		do
			!! Result.make
			Result.set_line_width (2)
			!! pt.set (90, 50)
			Result.set_base_left (pt)
			Result.set_text ("This is a try")
		end

end -- class TEXT_FIGURE_ITEM

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

