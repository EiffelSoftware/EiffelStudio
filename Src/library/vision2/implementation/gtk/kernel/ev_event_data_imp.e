--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision event data. Gtk implementation";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_EVENT_DATA_IMP

inherit
	EV_EVENT_DATA_I
	
	EV_GTK_EXTERNALS	

	EV_GDK_EXTERNALS

	EV_C_GTK
	
feature -- Initialization
	
	initialize (p: POINTER) is
			-- Initialize the object according to C 
			-- pointer 'p'
		do
			-- Do nothing here
		end	
	
	initialize_address: POINTER is
			-- Address of feature initialize
		do
			Result := routine_address ($initialize)
		end

end -- class EV_EVENT_DATA_IMP

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
--| Revision 1.7  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.3  2000/01/27 19:29:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.2  1999/12/01 17:37:10  oconnor
--| migrating to new externals
--|
--| Revision 1.6.6.1  1999/11/24 17:29:45  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
