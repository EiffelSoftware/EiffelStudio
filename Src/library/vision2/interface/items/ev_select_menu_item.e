indexing	
	description:
		"Eiffel Vision select menu item. Ancestor for EV_CHECK_MENU_ITEM %N%
		%and EV_RADIO_MENU_ITEM."
	status: "See notice at end of class"
	keywords: "menu, item, check, select"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SELECT_MENU_ITEM

inherit
	EV_MENU_ITEM
		redefine
			implementation
		end
	
feature -- Status report

	is_selected: BOOLEAN is
			-- Is this menu item checked?
		do
			Result := implementation.is_selected
		ensure
			bridge_ok: Result = implementation.is_selected
		end

feature -- Status setting

	enable_select is
			-- Select this menu item.
		do
			implementation.enable_select
		ensure
			is_selected: is_selected
		end

feature {NONE} -- Implementation

	implementation: EV_SELECT_MENU_ITEM_I
			-- Platform dependent access.

end -- class EV_SELECT_MENU_ITEM

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
--| Revision 1.1  2000/02/24 20:29:09  brendel
--| Initial revision. Needed for rearranged radio-item inheritance structure.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

