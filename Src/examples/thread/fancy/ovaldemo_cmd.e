indexing
	description: "Draw ovals in a specified window."
	date: "$Date$"
	revision: "$Revision$"
	
class
	OVAL_DEMO_CMD

inherit
	DEMO_CMD

create
	make_in

feature -- Basic operations

	draw (t_parent: CLIENT_WINDOW) is
			-- Draw Ovals.
		local
			dc: WEL_CLIENT_DC
			r_left, r_top, r_right, r_bottom: INTEGER
			brush: WEL_BRUSH
			color: WEL_COLOR_REF
			l_rect: WEL_RECT
		do
				-- Initialize
			r_left := next_number (t_parent.width)
			r_top := next_number (t_parent.height)
			r_right := next_number (t_parent.width)
			r_bottom := next_number (t_parent.height)
			color := std_colors @ (next_number (std_colors.count))
			create brush.make_solid (color)
			create l_rect.make (1, 1, t_parent.width, 30)

				-- Drawing part
			create dc.make (t_parent)
			dc.get
			dc.select_brush (brush)
			dc.ellipse (r_left, r_top, r_right, r_bottom)
 			dc.draw_text (count.out, l_rect, {WEL_DT_CONSTANTS}.Dt_bottom)
 			dc.release

				-- Clean
			brush.delete
			
				-- Update
			count := count + 1
		end

	count: INTEGER
			-- Number of time where `draw' has been called.

invariant
	count_nonnegative: count >= 0
	
end -- class OVAL_DEMO_CMD

--|----------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel.
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

