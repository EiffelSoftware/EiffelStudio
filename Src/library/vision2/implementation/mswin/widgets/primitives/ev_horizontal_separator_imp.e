--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision horizontal separator,%
			% windows implementation."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_HORIZONTAL_SEPARATOR_IMP

inherit
	EV_HORIZONTAL_SEPARATOR_I
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
			internal_set_minimum_height (2)
 		end

feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
		local
			top: INTEGER
		do
			paint_dc.select_pen (shadow_pen)
			paint_dc.line (0, height // 2 - 1, width, height // 2 - 1)
			paint_dc.select_pen (highlight_pen)
			paint_dc.line (0, height // 2, width, height // 2)
		end

	interface: EV_HORIZONTAL_SEPARATOR

end -- class EV_HORIZONTAL_SEPARATOR_IMP

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
--| Revision 1.6  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.10.4  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.5.10.3  2000/01/27 19:30:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.10.2  2000/01/11 19:47:58  rogers
--| Modified to comply with the major vision2 changes. See diff for redefinitions. Added interface.
--|
--| Revision 1.5.10.1  1999/11/24 17:30:32  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
