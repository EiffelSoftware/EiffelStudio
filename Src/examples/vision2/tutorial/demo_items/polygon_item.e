indexing
	description: "Demo for polygons."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	POLYGON_ITEM

inherit
	FIGURE_ITEM

creation
	make_with_title

feature -- Access

	figure: EV_POLYGON is
		local
			pt: EV_POINT
		do
			!! Result.make
			Result.path.set_line_width (2)
			!! pt.set (30, 50)
			Result.add (pt)
			!! pt.set (150, 46)
			Result.add (pt)
			!! pt.set (205, 209)
			Result.add (pt)
			!! pt.set (64, 90)
			Result.add (pt)
			!! pt.set (10, 60)
			Result.add (pt)
			!! pt.set (40, 65)
			Result.add (pt)
			!! pt.set (178, 34)
			Result.add (pt)
		end

end -- class POLYGON_ITEM

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

