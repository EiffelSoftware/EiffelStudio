indexing 
	description:
		"Eiffel Vision vertical scroll bar. %N%
		%Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SCROLL_BAR_IMP

inherit
	EV_VERTICAL_SCROLL_BAR_I
		redefine
			interface
		end

	EV_SCROLL_BAR_IMP
		redefine
			interface,
			set_default_minimum_size
		end
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create as vertical scrollbar.
		do
			base_make (an_interface)
			make_vertical (default_parent, 0, 0, 0, 0, 0)
		end

feature -- Status setting

   	set_default_minimum_size is
   			-- Platform dependant initializations.
   		do
			internal_set_minimum_width ((create {WEL_SYSTEM_METRICS})
				.horizontal_scroll_bar_arrow_height)
 		end

feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_SCROLL_BAR

end -- class EV_VERTICAL_SCROLL_BAR_IMP

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
--| Revision 1.5  2000/03/07 00:10:06  brendel
--| Implemented minimum size using WEL_SYSTEM_METRICS.
--|
--| Revision 1.4  2000/02/15 03:20:32  brendel
--| Changed order of initialization. All gauges are now initialized in
--| EV_GAUGE_IMP with values: min: 1, max: 100, step: 1, leap: 10, value: 1.
--| Clean-up.
--| Released.
--|
--| Revision 1.3  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.10.4  2000/02/01 03:41:16  brendel
--| Rearranged inheritance clause.
--|
--| Revision 1.2.10.3  2000/01/27 19:30:31  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.10.2  2000/01/06 20:35:02  rogers
--| Fixed to fit in with major new vision2 changes. make now takes an interface.
--|  make_with_range no longer takes a parent. Initialize is redefined from
--| ev_scroll_bar_imp and set the standard range as 1-100.
--|
--| Revision 1.2.10.1  1999/11/24 17:30:35  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
