indexing 
	description:
		"Eiffel Vision horizontal scrollbar. %N%
		%Mswindows implementation."
	status: "See notice at end of class"
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
			set_default_minimum_size,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create as horizontal scrollbar.
		do
			base_make (an_interface)
			make_horizontal (default_parent, 0, 0, 0, 0, -1)
		end
	
feature -- Status setting

   	set_default_minimum_size is
   			-- Platform dependant initializations.
   		do
			ev_set_minimum_height (
				(create {WEL_SYSTEM_METRICS}).
				horizontal_scroll_bar_arrow_height)
 		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_SCROLL_BAR

end -- class EV_HORIZONTAL_SCROLL_BAR_IMP

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.7  2001/06/07 23:08:16  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.8.4  2000/08/11 18:49:33  rogers
--| Fixed copyright clauses. Now use ! instead of |. Formatting.
--|
--| Revision 1.2.8.3  2000/08/08 02:33:29  manus
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--|
--| Revision 1.2.8.2  2000/06/11 02:32:13  manus
--| By default the ID of a control we do not care about is -1 not 0.
--| Fixed the way we compute either the width or the height of the scroll bar so
--| that we take the width of a vertical scroll bar and the height of a
--| horizontal one.
--|
--| Revision 1.2.8.1  2000/05/03 19:09:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/03/07 00:10:06  brendel
--| Implemented minimum size using WEL_SYSTEM_METRICS.
--|
--| Revision 1.5  2000/02/15 03:20:32  brendel
--| Changed order of initialization. All gauges are now initialized in
--| EV_GAUGE_IMP with values: min: 1, max: 100, step: 1, leap: 10, value: 1.
--| Clean-up.
--| Released.
--|
--| Revision 1.4  2000/02/14 22:30:34  brendel
--| Changed to comply with signature change of `set_range' in EV_GAUGE.
--| Now takes INTEGER_INTERVAL instead of 2 integers.
--|
--| Revision 1.3  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.10.4  2000/02/01 03:34:22  brendel
--| Changed inheritance clause.
--|
--| Revision 1.2.10.3  2000/01/27 19:30:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.10.2  2000/01/06 20:35:28  rogers
--| Fixed to fit in with major new vision2 changes. make now takes an interface.
--| make_with_range no longer takes a parent. Initialize is redefined from
--| ev_scroll_bar_imp and set the standard range as 1-100.
--|
--| Revision 1.2.10.1  1999/11/24 17:30:32  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
