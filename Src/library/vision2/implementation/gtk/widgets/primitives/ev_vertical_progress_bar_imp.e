indexing 
	description: "Eiffel Vision vertical progress bar. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_PROGRESS_BAR_IMP

inherit
	EV_VERTICAL_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_PROGRESS_BAR_IMP
		redefine
			initialize,
			interface
		end

create
	make

feature {NONE} -- Initialization

	initialize is
		do
			Precursor
			C.gtk_progress_bar_set_orientation (gtk_progress_bar, C.Gtk_progress_top_to_bottom_enum)
		end
			
feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_PROGRESS_BAR

end -- class EV_VERTICAL_PROGRESS_BAR_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.6  2000/02/14 11:04:08  oconnor
--| wrapped in event box
--|
--| Revision 1.4.6.5  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.4.6.4  2000/01/31 21:36:32  brendel
--| Minor cosmetic changes.
--|
--| Revision 1.4.6.3  2000/01/27 19:29:49  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.2  2000/01/14 21:48:04  king
--| Converted to fit in with new structure
--|
--| Revision 1.4.6.1  1999/11/24 17:29:59  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
