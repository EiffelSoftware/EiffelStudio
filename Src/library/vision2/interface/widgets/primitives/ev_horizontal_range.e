indexing 
	description: "Eiffel Vision horizontal range."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_RANGE

inherit
	EV_RANGE
		redefine
			implementation
		end

create
	default_create,
	make_with_range

feature {NONE} -- Implementation

	implementation: EV_HORIZONTAL_RANGE_I
			-- Platform dependent access.

	create_implementation is
			-- Create implementation of horizontal range.
		do
			create {EV_HORIZONTAL_RANGE_IMP} implementation.make (Current)
		end

end -- class EV_HORIZONTAL_RANGE

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
--| Revision 1.3  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.5  2000/02/02 00:56:04  brendel
--| Revised.
--|
--| Revision 1.2.6.4  2000/01/28 22:24:24  oconnor
--| released
--|
--| Revision 1.2.6.3  2000/01/27 19:30:54  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.2  2000/01/11 16:53:40  rogers
--| Altered to comply with the major Vision2 changes. Make with range no longer takes a parent. Added create implementation.
--|
--| Revision 1.2.6.1  1999/11/24 17:30:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
