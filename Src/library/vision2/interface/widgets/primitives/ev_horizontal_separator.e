indexing 
	description:
		"Eiffel Vision horizontal separator."
	status: "See notice at end of class"
	keywords: "seperator, horizontal"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_HORIZONTAL_SEPARATOR

inherit
	EV_SEPARATOR
		redefine
			implementation
		end

create
	default_create

feature {NONE} -- Implementation

	implementation: EV_HORIZONTAL_SEPARATOR_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_implementation is
			-- Create implementation of horizontal separator.
		do
			create {EV_HORIZONTAL_SEPARATOR_IMP} implementation.make (Current)
		end

end -- class EV_HORIZONTAL_SEPARATOR

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
--| Revision 1.6  2000/02/29 18:09:10  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.5  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.5  2000/01/28 22:24:24  oconnor
--| released
--|
--| Revision 1.3.6.4  2000/01/27 19:30:55  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.3  2000/01/15 02:32:12  oconnor
--| formatting
--|
--| Revision 1.3.6.2  2000/01/11 18:44:06  rogers
--| altered to comply with the major Vision2 changes. removed make and added
--| create implementation.
--|
--| Revision 1.3.6.1  1999/11/24 17:30:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
