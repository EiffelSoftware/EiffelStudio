--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

	description: 
		"EiffelVision invisible container. Invisible container%
		%is a container to be put inside another container to%
		%change the behavior of the child positioning and sizing%
		%inside of the container."
	keywords: "container, invisible"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_INVISIBLE_CONTAINER

inherit
	EV_CONTAINER
		redefine
			implementation
		end
	
feature {NONE} -- Implementation
	
	implementation: EV_INVISIBLE_CONTAINER_I
			
end -- class EV_INVISIBLE_CONTAINER

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
--| Revision 1.7  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.3  2000/01/28 22:24:24  oconnor
--| released
--|
--| Revision 1.6.6.2  2000/01/27 19:30:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.1  1999/11/24 17:30:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
