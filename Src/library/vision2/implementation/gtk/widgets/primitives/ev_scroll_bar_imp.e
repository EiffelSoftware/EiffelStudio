indexing
	description: "Eiffel Vision scrollbar. GTK+ implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SCROLL_BAR_IMP

inherit
	EV_SCROLL_BAR_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			interface,
			set_leap,
			disconnect_all_signals
		end

feature -- Element change

	set_leap (a_leap: INTEGER) is
			-- Set `leap' to `a_leap'.
			-- We redefine it to keep the page size the same as leap.
		do
			if leap /= a_leap then
				C.set_gtk_adjustment_struct_upper (adjustment, value_range.upper + a_leap)
				C.set_gtk_adjustment_struct_page_increment (adjustment, a_leap)
				C.set_gtk_adjustment_struct_page_size (adjustment, a_leap)
				C.gtk_adjustment_changed (adjustment)
			end
		ensure then
			range_same: value_range.is_equal (old value_range)
		end

feature {NONE} -- Implementation

	disconnect_all_signals is 
		do
			--| FIXME Hack needed to prevent gtk warnings.
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SCROLL_BAR

end -- class EV_SCROLL_BAR_IMP

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.10  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.4.5  2001/04/18 18:34:26  king
--| Redefined disconnect_all_signals to prevent gtk warnings
--|
--| Revision 1.4.4.4  2000/10/27 16:54:44  manus
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
--| Revision 1.4.4.3  2000/09/13 17:18:07  oconnor
--| updated for modified EV_GAUGE
--|
--| Revision 1.4.4.2  2000/08/08 00:03:15  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.4.4.1  2000/05/03 19:08:51  oconnor
--| mergred from HEAD
--|
--| Revision 1.9  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.8  2000/02/16 04:05:04  brendel
--| Removed redefinition of features that altered maximum.
--| Added redefinition of `set_leap', which changes the page size to leap.
--| In EV_GAUGE_IMP, the maximum internally is `page_size' higher.
--|
--| Revision 1.7  2000/02/14 22:53:27  brendel
--| Corrected small errors occured while copying & pasting.
--|
--| Revision 1.6  2000/02/14 22:19:51  brendel
--| Changed range instead of taking two integers to take an INTEGER_INTERVAL.
--| This is to take advantage of the newly introduced operator |..|.
--|
--| Revision 1.5  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.6  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.4.6.5  2000/02/02 01:03:20  brendel
--| Fixed small bug in maximum, where the widget could only reach maximum - leap,
--| where it now can reach maximum.
--|
--| Revision 1.4.6.4  2000/01/31 21:35:58  brendel
--| Implemented in compliance with revised EV_GAUGE.
--|
--| Revision 1.4.6.3  2000/01/27 19:29:48  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.2  2000/01/15 01:25:36  king
--| Implemented to fit in with new structure
--|
--| Revision 1.4.6.1  1999/11/24 17:29:58  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
