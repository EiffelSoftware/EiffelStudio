indexing
	description: "Demo for slices."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	SLICE_ITEM

inherit
	FIGURE_ITEM

creation
	make_with_title

feature -- Access

	figure: EV_SLICE is
		local
			pt: EV_POINT
			angle1, angle2, angle3: EV_ANGLE
		do
			!! Result.make
			Result.path.set_line_width (2)
			!! pt.set (90, 150)
			Result.set_center (pt)
			Result.set_radius1 (100)
			Result.set_radius2 (100)
			create angle1.make_in_degrees (69)
			Result.set_orientation (angle1)
			create angle2.make_in_degrees (69)
			Result.set_angle1 (angle2)
			create angle3.make_in_degrees (90)
			Result.set_angle2 (angle3)
			Result.set_pieslice_arc
		end

end -- class SLICE_ITEM

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

