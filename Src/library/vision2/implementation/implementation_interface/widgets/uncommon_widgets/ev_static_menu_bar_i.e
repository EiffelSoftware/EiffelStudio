--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision static menu bar.A static menu bar%
				% is a menu bar attached to a window. It cannot%
				% be resized or moved."
	note: "The parent of such a menu can only be an EV_TITLED_WINDOW"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_STATIC_MENU_BAR_I

inherit
	EV_MENU_HOLDER_I

feature -- Access
	
	parent: EV_TITLED_WINDOW is
			-- The widget that has the current menu
		require
		do
			if parent_imp /= Void then
				Result ?= parent_imp.interface
			else
				Result := Void
			end
		end

feature {NONE} -- Implementation

	parent_imp: EV_TITLED_WINDOW_IMP
			-- The window where the menu is.

end -- class EV_STATIC_MENU_BAR_I

--!----------------------------------------------------------------
--! EiffelVision : library of reusable components for ISE Eiffel.
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
--!---------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.8.6.4  2000/02/04 18:35:40  oconnor
--| unreleased
--|
--| Revision 1.8.6.3  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.8.6.2  2000/01/27 19:30:07  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.8.6.1  1999/11/24 17:30:15  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.4  1999/11/04 23:10:46  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.8.2.3  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
