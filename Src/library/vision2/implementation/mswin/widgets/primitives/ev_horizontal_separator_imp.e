indexing 
	description	: "EiffelVision horizontal separator, windows implementation."
	status		: "See notice at end of class."
	date		: "$Date$";
	revision	: "$Revision$"

class
	EV_HORIZONTAL_SEPARATOR_IMP

inherit
	EV_HORIZONTAL_SEPARATOR_I
		redefine
			interface
		end

	EV_SEPARATOR_IMP
		redefine
			set_default_minimum_size,
			interface
		end

creation
	make

feature -- Status setting

   	set_default_minimum_size is
   			-- Platform dependant initialization.
   		do
			ev_set_minimum_height (2)
 		end

feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Repaint 3D separator.
		local
			cur_height_div_two: INTEGER
			r: WEL_RECT
			bk_brush: WEL_BRUSH
			pen: WEL_PEN
		do
			cur_height_div_two := ev_height // 2

			if cur_height_div_two > 1 then
					-- We need to draw a background.
				bk_brush := background_brush
				create r.make (0, 0, width, cur_height_div_two - 1)
				paint_dc.fill_rect (r, bk_brush)
			end

			pen := shadow_pen
			draw_horizontal_line (paint_dc, pen,
				cur_height_div_two - 1)
			pen.delete

			pen := highlight_pen
			draw_horizontal_line (paint_dc, pen,
				cur_height_div_two)
			pen.delete

			if cur_height_div_two < height then
					-- We need to draw a background.
				if bk_brush = Void then
					bk_brush := background_brush
				end
				create r.make (0, cur_height_div_two + 1, width, height)
				paint_dc.fill_rect (r, bk_brush)
			end

			if bk_brush /= Void then
				bk_brush.delete
			end
		end

	draw_horizontal_line (paint_dc: WEL_PAINT_DC;
			a_pen: WEL_PEN; a_y: INTEGER) is
			-- Draw graphical component of `Current'.
		do
			paint_dc.select_pen (a_pen)
			paint_dc.line (0, a_y, width, a_y)
		end

	interface: EV_HORIZONTAL_SEPARATOR

end -- class EV_HORIZONTAL_SEPARATOR_IMP

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

