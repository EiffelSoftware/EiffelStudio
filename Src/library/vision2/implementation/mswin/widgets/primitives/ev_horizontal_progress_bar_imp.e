indexing 
	description:
		"Eiffel Vision horizontal progress bar. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_PROGRESS_BAR_IMP

inherit
	EV_HORIZONTAL_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_PROGRESS_BAR_IMP
		redefine
			set_default_minimum_size,
			interface
		end

create
	make

feature -- Status settings

	set_default_minimum_size is
			-- Initialize the size of `Current'.
		do
			ev_set_minimum_size (10, 20)
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create `Current'.
		do
			Result := Ws_visible + Ws_child
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_PROGRESS_BAR

end -- class EV_HORIZONTAL_PROGRESS_BAR_IMP

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
--| Revision 1.3.8.3  2000/08/11 18:50:59  rogers
--| Fixed copyright clauses. Now use ! instead of |. Formatting.
--|
--| Revision 1.3.8.2  2000/08/08 02:31:49  manus
--| New resizing policy by calling `ev_' instead of `internal_'.
--|
--| Revision 1.3.8.1  2000/05/03 19:09:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/04/26 17:31:42  rogers
--| Formatting and comments.
--|
--| Revision 1.5  2000/02/15 03:20:32  brendel
--| Changed order of initialization. All gauges are now initialized in
--| EV_GAUGE_IMP with values: min: 1, max: 100, step: 1, leap: 10, value: 1.
--| Clean-up.
--| Released.
--|
--| Revision 1.4  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.10.5  2000/02/01 03:33:52  brendel
--| Changed inheritance clause.
--|
--| Revision 1.3.10.4  2000/01/27 19:30:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.10.3  2000/01/10 23:48:49  rogers
--| Added a minimum_width on creation.
--|
--| Revision 1.3.10.2  2000/01/10 18:39:03  rogers
--| Changed to fit in with the major Vision2 changes. See diff for
--| redefinitions. Added interface.
--|
--| Revision 1.3.10.1  1999/11/24 17:30:32  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
