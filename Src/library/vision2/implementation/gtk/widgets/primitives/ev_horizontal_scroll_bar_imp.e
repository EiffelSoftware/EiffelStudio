indexing
	description: "Eiffel Vision horizontal scroll bar. GTK+ implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_SCROLL_BAR_IMP

inherit
	EV_HORIZONTAL_SCROLL_BAR_I
		redefine
			interface
		end
	
	EV_SCROLL_BAR_IMP
		redefine
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the horizontal scroll bar.
		do
			base_make (an_interface)
			adjustment := C.gtk_adjustment_new (0, 0, 100 + 10, 1, 10, 10)
			set_c_object (C.gtk_hscrollbar_new (adjustment))
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_SCROLL_BAR

end -- class EV_HORIZONTAL_SCROLL_BAR_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
--| Revision 1.9  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.4.3  2000/10/27 16:54:44  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.3.4.2  2000/08/08 00:03:15  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.3.4.1  2000/05/03 19:08:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.8  2000/04/13 18:46:51  brendel
--| Changed default value.
--|
--| Revision 1.7  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.6  2000/02/16 04:10:32  brendel
--| Added redefinition of `make'. Does not call precursor, since
--| we want to keep the page size the same as leap.
--|
--| Revision 1.5  2000/02/15 16:34:31  brendel
--| Fixed bug in initialization found after adding `is_in_default_state' in
--| interface classes.
--|
--| Revision 1.4  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.5  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.3.6.4  2000/01/31 21:36:32  brendel
--| Minor cosmetic changes.
--|
--| Revision 1.3.6.3  2000/01/27 19:29:46  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.2  2000/01/15 01:25:35  king
--| Implemented to fit in with new structure
--|
--| Revision 1.3.6.1  1999/11/24 17:29:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/17 01:53:05  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.3.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
