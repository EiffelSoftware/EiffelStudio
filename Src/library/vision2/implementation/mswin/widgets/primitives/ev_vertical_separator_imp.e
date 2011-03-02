note
	description: "EiffelVision vertical separator. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_VERTICAL_SEPARATOR_IMP

inherit
	EV_VERTICAL_SEPARATOR_I
		redefine
			interface
		end

	EV_SEPARATOR_IMP
		redefine
			set_default_minimum_size,
			interface
		end

create
	make

feature -- Status setting

   	set_default_minimum_size
   			-- Set `default_minimum_size'.
   		do
			ev_set_minimum_width (2, False)
 		end

feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Repaint 3D separator.
		local
			cur_width_div_two: INTEGER
			r: WEL_RECT
			bk_brush: detachable WEL_BRUSH
			pen: WEL_PEN
		do
			cur_width_div_two := ev_width // 2

			if cur_width_div_two > 1 then
					-- We need to draw a background.
				bk_brush := background_brush
				if bk_brush /= Void then
					create r.make (0, 0, cur_width_div_two - 1, height)
					paint_dc.fill_rect (r, bk_brush)
				end
			end

			pen := shadow_pen
			draw_vertical_line (paint_dc, pen,
				cur_width_div_two - 1)
			pen.delete

			pen := highlight_pen
			draw_vertical_line (paint_dc, pen,
				cur_width_div_two)
			pen.delete

			if cur_width_div_two < width then
					-- We need to draw a background.
				if bk_brush = Void then
					bk_brush := background_brush
				end
				check bk_brush /= Void end
				create r.make (cur_width_div_two + 1, 0, width, height)
				paint_dc.fill_rect (r, bk_brush)
			end

			if bk_brush /= Void then
				bk_brush.delete
			end
		end

	draw_vertical_line (paint_dc: WEL_PAINT_DC;
			a_pen: WEL_PEN; a_x: INTEGER)
			-- Draw graphical component of `Current'.
		do
			paint_dc.select_pen (a_pen)
			paint_dc.line (a_x, 0, a_x, ev_height)
			paint_dc.unselect_pen
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_SEPARATOR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EV_VERTICAL_SEPARATOR_IMP
