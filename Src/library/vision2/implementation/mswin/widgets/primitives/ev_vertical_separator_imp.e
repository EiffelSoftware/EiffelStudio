--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision vertical separator,%
			% Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_VERTICAL_SEPARATOR_IMP

inherit
	EV_VERTICAL_SEPARATOR_I
		redefine
			interface
		select
			interface
		end

	EV_SEPARATOR_IMP
		rename
			interface as ev_separator_imp_interface
		redefine
			set_default_minimum_size
		end

creation
	make

feature -- Status setting

   	set_default_minimum_size is
   			-- Plateform dependant initializations.
   		do
			internal_set_minimum_width (2)
 		end

feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Repaint 3D separator based on `is_raised'.
		local
			cur_width_div_two: INTEGER
		do
			cur_width_div_two := wel_width // 2
			if is_raised then
				draw_vertical_line (paint_dc, highlight_pen,
					cur_width_div_two - 2)
				draw_vertical_line (paint_dc, shadow_pen,
					cur_width_div_two + 1)
				draw_vertical_line (paint_dc, black_pen,
					cur_width_div_two + 2)
			else
				draw_vertical_line (paint_dc, shadow_pen,
					cur_width_div_two - 1)
				draw_vertical_line (paint_dc, highlight_pen,
					cur_width_div_two)
			end
		end

	draw_vertical_line (paint_dc: WEL_PAINT_DC;
			a_pen: WEL_PEN; a_x: INTEGER) is
			-- Draw graphical component of `Current'.
		do
			paint_dc.select_pen (a_pen)
			paint_dc.line (a_x, 0, a_x, wel_height)
		end

	interface: EV_VERTICAL_SEPARATOR

end -- class EV_VERTICAL_SEPARATOR_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/06/07 17:28:01  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
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
--| Modified to comply with the major vision2 changes. See diff for redefinitions. Added interface.
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
