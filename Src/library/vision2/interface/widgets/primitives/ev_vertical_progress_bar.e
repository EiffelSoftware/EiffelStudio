indexing 
	description:
		"Vertical bar graph gauge for displaying progress of a process."
	appearance:
		"+--+N%
		%|  |%N%
		%|  |%N%
		%|  |%N%
		%|25|%N%
		%|  |%N%
		%|##|%N%
		%|##|%N%
		%+--+"
	status: "See notice at end of class"
 	keywords: "status, progress, bar, vertical"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_PROGRESS_BAR

inherit
	EV_PROGRESS_BAR
		redefine
			implementation
		end

create
	default_create,
	make_with_range,
	make_for_test

feature {EV_ANY_I} -- Implementation

	implementation: EV_VERTICAL_PROGRESS_BAR_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_VERTICAL_PROGRESS_BAR_IMP}
				implementation.make (Current)
		end

end -- class EV_VERTICAL_PROGRESS_BAR

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
--| Revision 1.9  2000/06/07 17:28:13  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.3.4.2  2000/05/16 18:06:00  oconnor
--| asthetics
--|
--| Revision 1.3.4.1  2000/05/03 19:10:11  oconnor
--| mergred from HEAD
--|
--| Revision 1.8  2000/03/21 19:10:39  oconnor
--| comments, formatting
--|
--| Revision 1.7  2000/03/01 19:48:54  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.6  2000/03/01 03:26:40  oconnor
--| added make_for_test
--|
--| Revision 1.5  2000/02/22 18:39:52  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.6  2000/01/31 21:30:50  brendel
--| Revised.
--|
--| Revision 1.3.6.5  2000/01/28 22:24:25  oconnor
--| released
--|
--| Revision 1.3.6.4  2000/01/27 19:30:58  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.3  2000/01/17 19:09:23  oconnor
--| formatting, comments
--|
--| Revision 1.3.6.2  2000/01/10 18:36:10  rogers
--| Fixed to work with the major Vision2 changes. Make is no longer required,
--| default_create is called instead. make_with_range no longer takes a parent.
--| Added create implementation.
--|
--| Revision 1.3.6.1  1999/11/24 17:30:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
