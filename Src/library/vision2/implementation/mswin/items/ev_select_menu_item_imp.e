indexing	
	description: "Eiffel Vision select menu item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SELECT_MENU_ITEM_IMP

inherit
	EV_SELECT_MENU_ITEM_I
		undefine
			parent
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			interface
		end
	
feature -- Status report

	is_selected: BOOLEAN
			-- Is this menu item checked?

feature -- Status setting

	enable_select is
			-- Select this menu item.
		do
			is_selected := True
			if has_parent then
				parent_imp.check_item (id)
			end
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
--| Revision 1.3  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.6.1  2000/05/03 19:09:11  oconnor
--| mergred from HEAD
--|
--| Revision 1.2  2000/02/25 20:31:10  brendel
--| Now defines is_selected as attribute, because before we were not able
--| to call any of the *selected features when not parented without feature
--| calls on Void targets and WEL precondition violations.
--|
--| Revision 1.1  2000/02/24 20:27:22  brendel
--| Initial revision. Needed for rearranged radio-item inheritance structure.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
