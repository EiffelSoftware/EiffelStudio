indexing 
	description: "EiffelVision vertical separator. Mswindows implementation."
	status: "See notice at end of class"
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

creation
	make

feature -- Status setting

   	set_default_minimum_size is
   			-- Set `default_minimum_size'.
   		do
			ev_set_minimum_width (2)
 		end

feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Repaint 3D separator.
		local
			cur_width_div_two: INTEGER
			r: WEL_RECT
			bk_brush: WEL_BRUSH
			pen: WEL_PEN
		do
			cur_width_div_two := ev_width // 2

			if cur_width_div_two > 1 then
					-- We need to draw a background.
				bk_brush := background_brush
				create r.make (0, 0, cur_width_div_two - 1, height)
				paint_dc.fill_rect (r, bk_brush)
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
				create r.make (cur_width_div_two + 1, 0, width, height)
				paint_dc.fill_rect (r, bk_brush)
			end

			if bk_brush /= Void then
				bk_brush.delete
			end
		end

	draw_vertical_line (paint_dc: WEL_PAINT_DC;
			a_pen: WEL_PEN; a_x: INTEGER) is
			-- Draw graphical component of `Current'.
		do
			paint_dc.select_pen (a_pen)
			paint_dc.line (a_x, 0, a_x, ev_height)
		end

	interface: EV_VERTICAL_SEPARATOR

end -- class EV_VERTICAL_SEPARATOR_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2001/06/07 23:08:17  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.8.13  2000/11/02 05:02:13  manus
--| Updated comment on EV_SYSTEM_PEN_IMP to show that after using one of these WEL_PEN
--| object the Vision2 implementor needs to call `delete' on them to free the allocated
--| GDI object. Updated code of classes which was not doing it.
--|
--| Revision 1.5.8.12  2000/10/27 02:37:57  manus
--| Correct bad merge of `interface'.
--| Call `delete' instead of `dispose'.
--|
--| Revision 1.5.8.11  2000/10/12 15:50:27  pichery
--| Added reference tracking for GDI objects to decrease
--| the number of GDI objects alive.
--|
--| Revision 1.5.8.10  2000/09/26 03:57:59  manus
--| Better drawing of vertical/horizontal separator when they are bigger than their
--| default minimum size.
--|
--| Revision 1.5.8.9  2000/09/08 19:36:50  manus
--| Removed `is_raised' and `is_flat' from the implementation since they have been removed from
--| the interface.
--|
--| Revision 1.5.8.8  2000/08/11 18:27:51  rogers
--| Fixed copyright clauses. Now use ! instead of |. Formatting.
--|
--| Revision 1.5.8.7  2000/08/08 02:35:13  manus
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--| Redo the painting algorithm so that it is not transparent.
--|
--| Revision 1.5.8.6  2000/07/21 22:12:56  pichery
--| Added drawing operations for flat separators.
--|
--| Revision 1.5.8.5  2000/06/22 19:05:19  pichery
--| - Added the style `is_flat'
--|
--| Revision 1.5.8.4  2000/06/19 21:20:55  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.5.8.3  2000/05/08 19:45:50  brendel
--| Optimized implementation of on_paint.
--|
--| Revision 1.5.8.2  2000/05/03 22:21:28  pichery
--| - Replaced calls to `width'/`height' to calls to
--|   `wel_width'/`wel_height'.
--| - Cosmetics / Optimizations using local variables
--|
--| Revision 1.5.8.1  2000/05/03 19:09:51  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.6  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.10.4  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.5.10.3  2000/01/27 19:30:31  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.10.2  2000/01/11 19:53:31  rogers
--| Modified to comply with the major vision2 changes. See diff for
--| redefinitions. Added interface.
--|
--| Revision 1.5.10.1  1999/11/24 17:30:35  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
