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
			set_leap
		end

feature -- Element change

	set_leap (a_leap: INTEGER) is
			-- Set `leap' to `a_leap'.
			-- We redefine it to keep the page size the same as leap.
		do
			if leap /= a_leap then
				C.set_gtk_adjustment_struct_upper (adjustment, maximum + a_leap)
				C.set_gtk_adjustment_struct_page_increment (adjustment, a_leap)
				C.set_gtk_adjustment_struct_page_size (adjustment, a_leap)
				C.gtk_adjustment_changed (adjustment)
			end
		ensure then
			maximum_same: maximum = old maximum
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
