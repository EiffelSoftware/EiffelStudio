--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

	description: 
		"EiffelVision invisible container, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_INVISIBLE_CONTAINER_IMP
	
inherit
	
	EV_INVISIBLE_CONTAINER_I
		redefine
			interface
		end
		
	EV_CONTAINER_IMP
		redefine
			interface,
			add_child_ok
		end

feature -- Assertion test

	add_child_ok: BOOLEAN is obsolete "use full"
			-- Used in the precondition of
			-- 'add_child'. True, if it is ok to add a
			-- child to container.
		do
			Result := True
		end
	
feature {EV_ANY_I} -- Implementation

	interface: EV_INVISIBLE_CONTAINER

end -- class EV_INVISIBLE_CONTAINER_IMP

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
--| Revision 1.6  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.4  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.5.6.3  2000/01/27 19:29:43  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.2  1999/11/30 23:15:48  oconnor
--| redefine interface to be of more refined type
--|
--| Revision 1.5.6.1  1999/11/24 17:29:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.3  1999/11/17 01:53:03  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.5.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
