indexing
	description:
		"Eiffel Vision separator. GTK+ implementation"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SEPARATOR_IMP

inherit
	EV_PRIMITIVE_IMP

feature -- Access

	is_raised: BOOLEAN
			-- Does `Current' appear raised?

feature -- Status setting

	enable_raised is
			-- Set `is_raised' `True'.
		do
			is_raised := True
			--| FIXME To be implemented
		end

	disable_raised is
			-- Set `is_raised' `False'.
		do
			is_raised := False
			--| FIXME To be implemented
		end

end -- class EV_SEPARATOR_IMP

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
--| Revision 1.7  2000/06/07 17:27:39  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.4.4.2  2000/05/05 23:34:03  brendel
--| Added is_raised, enable_raised and disable_raised.
--|
--| Revision 1.4.4.1  2000/05/03 19:08:51  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.3  2000/02/04 04:43:50  oconnor
--| released
--|
--| Revision 1.4.6.2  2000/01/27 19:29:48  oconnor
--| added --| FIXME Not for release
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
