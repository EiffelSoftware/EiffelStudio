indexing 
	description:
		"Eiffel Vision separator.%N%
		%Base class for horizontal and vertical seperators."
	status: "See notice at end of class"
	keywords: "seperator"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SEPARATOR

inherit 
	EV_PRIMITIVE
		redefine
			implementation
		end

feature {NONE} -- Implementation

	implementation: EV_SEPARATOR_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

end -- class EV_SEPARATOR

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
--| Revision 1.6  2000/02/22 18:39:52  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.4  2000/01/28 20:00:20  oconnor
--| released
--|
--| Revision 1.4.6.3  2000/01/27 19:30:57  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.2  2000/01/15 02:30:38  oconnor
--| formatting
--|
--| Revision 1.4.6.1  1999/11/24 17:30:55  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
