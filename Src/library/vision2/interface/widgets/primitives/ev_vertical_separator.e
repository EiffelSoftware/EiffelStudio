indexing 
	description: "EiffelVision vertical separator."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_VERTICAL_SEPARATOR

inherit
	EV_SEPARATOR
		redefine
			implementation
		end

create
	default_create

feature {NONE} -- Implementation

	implementation: EV_VERTICAL_SEPARATOR_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_implementation is
			-- Create implementation of vertical separator.
		do
			create {EV_VERTICAL_SEPARATOR_IMP} implementation.make (Current)
		end

end -- class EV_VERTICAL_SEPARATOR

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.5  2000/01/28 22:24:26  oconnor
--| released
--|
--| Revision 1.3.6.4  2000/01/27 19:30:58  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.3  2000/01/15 02:36:59  oconnor
--| formatting
--|
--| Revision 1.3.6.2  2000/01/11 18:41:14  rogers
--| altered to comply with the major Vision2 changes. removed make and added
--| create implementation.
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
