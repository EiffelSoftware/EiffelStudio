indexing
	description: 
		"EiffelVision invisible container, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_ITEM_HOLDER_IMP
	
inherit
	EV_MENU_ITEM_HOLDER_I
		-- Inheriting from widget, because menu and menu bar
		-- are widgets in gtk, although it is not a widget in
		-- EiffelVision. This is just for implementation
		-- reasons.

	EV_CONTAINER_IMP 
		rename
			set_parent as widget_set_parent,
			add_double_click_command as old_add_dblclk,
			remove_double_click_commands as old_remove_dblclk
		end

	EV_ITEM_HOLDER_IMP

	EV_GTK_ITEMS_EXTERNALS

feature -- Access
 
 	ev_children: ARRAYED_LIST [EV_MENU_ITEM_IMP]
 			-- List of the children.

feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		do
			check
				To_be_implemented: False
			end
		end

feature -- Basic operations

	find_item_by_data (data: ANY): EV_ITEM is
			-- Find a child with data equal to `data'.
		do
			check
				To_be_implemented: False
			end
		end

feature -- Deferred features

--	interface: EV_ANY is
--		deferred
--		end

end -- class EV_MENU_ITEM_HOLDER_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.

--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
