indexing
	description: "Demo for equilateral triangles."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EQUILATERAL_TRIANGLE_ITEM

inherit
	FIGURE_ITEM

creation
	make_with_title

feature -- Access

	figure: EV_EQUILATERAL_TRIANGLE is
		local
			pt: EV_POINT
			angle: EV_ANGLE
		do
			!! Result.make
			Result.path.set_line_width (2)
			!! pt.set (150, 150)
			Result.set_center (pt)
			Result.set_radius (60)
			create angle.make_in_degrees (69)
			Result.set_orientation (angle)
		end

end -- class EQUILATERAL_TRIANGLE_ITEM

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

