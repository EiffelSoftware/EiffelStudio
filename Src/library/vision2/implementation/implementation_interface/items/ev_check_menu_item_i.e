indexing	
	description: "Eiffel Vision check menu. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_CHECK_MENU_ITEM_I

inherit
	EV_MENU_ITEM_I
		redefine
			interface
		end
	
feature -- Status report

	is_selected: BOOLEAN is
			-- Is this menu item checked?
		deferred
		end

feature -- Status setting

	enable_select is
			-- Select this menu item.
		deferred
		ensure
			is_selected: is_selected
		end

	disable_select is
			-- Deselect this menu item.
		deferred
		ensure
			not_is_selected: not is_selected
		end

	toggle is
			-- Invert the value of `is_selected'.
		deferred
		ensure
			inverted: is_selected = not old is_selected
		end

feature {NONE} -- Implementation

	interface: EV_CHECK_MENU_ITEM

end -- class EV_CHECK_MENU_ITEM_I

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
--| Revision 1.7  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.5  2000/02/05 01:40:40  brendel
--| Inherits from EV_MENU_ITEM_I instead of EV_MENU_I.
--|
--| Revision 1.6.6.4  2000/02/04 04:02:40  oconnor
--| released
--|
--| Revision 1.6.6.3  2000/02/03 23:31:59  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.6.6.2  2000/01/27 19:29:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.1  1999/11/24 17:30:01  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/04 23:10:32  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.6.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
