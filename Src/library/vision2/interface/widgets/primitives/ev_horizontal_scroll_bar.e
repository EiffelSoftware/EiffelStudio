indexing
	description:
		"Interactive horizontal scrolling widget."
	appearance:
		"+-+---------+-+%N%
		%|<| |#|     |>|%N%
		%+-+---------+-+"
	status: "See notice at end of class."
	keywords: "horizontal, scroll, bar, gauge"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_SCROLL_BAR

inherit
	EV_SCROLL_BAR
		redefine
			implementation
		end

create
	default_create,
	make_with_range,
	make_for_test

feature {NONE} -- Implementation

	implementation: EV_HORIZONTAL_SCROLL_BAR_I
			-- Responsible for interaction with the native graphics toolkit.

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_HORIZONTAL_SCROLL_BAR_IMP} implementation.make (Current)
		end

end -- class EV_HORIZONTAL_SCROLL_BAR

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
--| Revision 1.8  2000/03/21 02:10:26  oconnor
--| comments and formatting
--|
--| Revision 1.7  2000/03/01 20:07:36  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.6  2000/03/01 03:30:06  oconnor
--| added make_for_test
--|
--| Revision 1.5  2000/02/29 18:09:10  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.4  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.3  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.5  2000/01/31 21:30:50  brendel
--| Revised.
--|
--| Revision 1.2.6.4  2000/01/28 22:24:24  oconnor
--| released
--|
--| Revision 1.2.6.3  2000/01/27 19:30:55  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.2  2000/01/06 20:30:45  rogers
--| Now works with the new vision2 changes. added create implementation.
--| removed make, make_with_range now does not take a parent.
--|
--| Revision 1.2.6.1  1999/11/24 17:30:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
