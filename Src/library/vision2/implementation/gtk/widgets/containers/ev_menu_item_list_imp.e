indexing
	description: "Eiffel Vision menu item list. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_ITEM_LIST_IMP
	
inherit
	EV_MENU_ITEM_LIST_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_MENU_ITEM]
		redefine
			interface,
			add_to_container
		end

feature {NONE} -- implementation

	add_to_container (v: like item) is
			-- Add `v' to container.
			--| We redefine this to use `gtk_menu_append' instead of
			--| `gtk_container_add' so that empty menu items are
			--| treated as separators by GTK.
		local
			imp: EV_WIDGET_IMP
		do
			imp ?= v.implementation
			C.gtk_menu_append (list_widget, imp.c_object)
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			C.gtk_menu_reorder_child (a_container, a_child, a_position)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_ITEM_LIST
	
end -- class EV_MENU_ITEM_LIST_IMP

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
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.5  2000/02/05 01:39:40  brendel
--| Redefined `add_to_container', because for separators, we need to call
--| gtk_menu_append instead of gtk_container_add to make the separator appear.
--|
--| Revision 1.1.2.4  2000/02/04 19:02:12  brendel
--| Removed redefinitions of add_to_container and remove_from_container, since
--| we do not want to prevent the submenu-arrow (>) to show anymore if there
--| are no items in the menu-list.
--|
--| Revision 1.1.2.3  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.1.2.2  2000/02/04 01:13:59  brendel
--| Removed unused local variable.
--|
--| Revision 1.1.2.1  2000/02/03 23:31:59  brendel
--| Revised.
--| Changed inheritance structure.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
