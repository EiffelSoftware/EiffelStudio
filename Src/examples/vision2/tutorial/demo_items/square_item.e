indexing
	description: "Demo for squares."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	SQUARE_ITEM

inherit
	FIGURE_ITEM

creation
	make

feature {NONE} -- Initialization

	make (par: EV_TREE_ITEM_HOLDER) is
			-- Create the item and the demo that
			-- goes with it.
		do
			make_with_title (par, "EV_SQUARE")
		end

feature -- Access

	figure: EV_SQUARE is
		local
			pt: EV_POINT
		do
			!! Result.make
			Result.path.set_line_width (2)
			!! pt.set (150, 150)
			Result.set_center (pt)
			Result.set_size_of_side (60)
		end

end -- class SQUARE_ITEM

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

