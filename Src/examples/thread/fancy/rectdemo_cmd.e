class
	RECTANGLE_DEMO_CMD

inherit

	DEMO_CMD

creation
	make_in

feature -- Basic operations

	draw (t_parent: CLIENT_WINDOW) is
			-- Draw Rectangles
		local
			dc: WEL_CLIENT_DC
			r_left, r_top, r_right, r_bottom: INTEGER
			brush: WEL_BRUSH
			color: WEL_COLOR_REF
		do
			!! dc.make (t_parent)
			dc.get
			r_left := next_number (t_parent.width)
			r_top := next_number (t_parent.height)
			r_right := next_number (t_parent.width)
			r_bottom := next_number (t_parent.height)
			color := std_colors @ (next_number (std_colors.count))
			!! brush.make_solid (color)
			dc.select_brush (brush)
			dc.rectangle (r_left, r_top, r_right, r_bottom)
 			dc.release
			brush.delete
		end

end -- class RECTANGLE_DEMO_CMD

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, 2nd floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
