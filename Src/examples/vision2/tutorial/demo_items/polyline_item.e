indexing
	description: "Demo for polylines."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POLYLINE_ITEM

inherit
	FIGURE_ITEM

creation
	make

feature {NONE} -- Initialization

	make (par: EV_TREE_ITEM_HOLDER) is
			-- Create the item and the demo that
			-- goes with it.
		do
			make_with_title (par, "EV_POLYLINE")
		end

feature -- Access

	figure: EV_POLYLINE is
		local
			pt1, pt2, pt3: EV_PIXEL
		do
			!! Result.make
			Result.set_line_width (2)
			!! pt1.set (110, 30)
			Result.add (pt1)
			!! pt2.set (200, 50)
			Result.add (pt2)
			!! pt3.set (250, 78)
			Result.add (pt3)
		end

end -- class POLYLINE_ITEM

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

