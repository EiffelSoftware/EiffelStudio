--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

	description: 
		"EiffelVision invisible container, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_INVISIBLE_CONTAINER_I
	
inherit
	EV_CONTAINER_I
		redefine
			interface
		end
	
feature {EV_ANY_I} -- Implementation

	interface: EV_INVISIBLE_CONTAINER

end -- class EV_INVISIBLE_CONTAINER_I

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
--| Revision 1.5  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.5  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.4.6.4  2000/01/31 17:26:18  brendel
--| Removed add_child_ok from ihn. clause.
--|
--| Revision 1.4.6.3  2000/01/27 19:30:01  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.2  1999/11/30 22:48:43  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.4.6.1  1999/11/24 17:30:10  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
