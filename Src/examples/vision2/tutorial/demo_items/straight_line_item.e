indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRAIGHT_LINE_ITEM

inherit
	FIGURE_ITEM

creation
	make_with_title

feature -- Access

	figure: EV_STRAIGHT_LINE is
		local
			pt1, pt2: EV_POINT
		do
			!! Result.make
			!! pt1.set (110, 30)
			!! pt2.set (200, 50)
			Result.set (pt1, pt2)
			Result.set_line_width (2)
		end

end -- class STRAIGHT_LINE_ITEM

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

