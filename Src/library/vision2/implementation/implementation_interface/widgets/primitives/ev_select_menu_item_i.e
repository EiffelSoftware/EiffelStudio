indexing	
	description: "Eiffel Vision select menu item. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SELECT_MENU_ITEM_I

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

feature {NONE} -- Implementation

	interface: EV_SELECT_MENU_ITEM

end -- class EV_SELECT_MENU_ITEM_I

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
--| Revision 1.2  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.6.1  2000/05/03 19:09:07  oconnor
--| mergred from HEAD
--|
--| Revision 1.1  2000/02/24 20:27:22  brendel
--| Initial revision. Needed for rearranged radio-item inheritance structure.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
