indexing	
	description: "Eiffel Vision select menu item. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SELECT_MENU_ITEM_IMP

inherit
	EV_SELECT_MENU_ITEM_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			interface
		end
	
feature -- Status report

	is_selected: BOOLEAN is
			-- Is this menu item checked?
		do
			Result := C.gtk_check_menu_item_struct_active (c_object).to_boolean
		end

feature -- Status setting

	enable_select is
			-- Select this menu item.
		do
			C.gtk_check_menu_item_set_active (c_object, True)
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
--| Revision 1.3  2001/06/07 23:08:02  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.6.1  2000/05/03 19:08:36  oconnor
--| mergred from HEAD
--|
--| Revision 1.2  2000/02/25 01:53:38  brendel
--| Implemented.
--|
--| Revision 1.1  2000/02/24 20:27:21  brendel
--| Initial revision. Needed for rearranged radio-item inheritance structure.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
