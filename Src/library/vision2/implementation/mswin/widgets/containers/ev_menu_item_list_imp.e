--| FIXME Not for release
indexing
	description: "Eiffel Vision menu item list. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_ITEM_LIST_IMP
	
inherit
	EV_MENU_ITEM_LIST_I

	EV_ITEM_LIST_IMP [EV_MENU_ITEM]

	WEL_MENU
		rename
			make as wel_make,
			item as wel_item
		end

feature {NONE} -- Initialization

	initialize is
		do
			create ev_children.make (2)
			is_initialized := True
		end

feature {NONE} -- Implementation

	ev_children: ARRAYED_LIST [EV_MENU_ITEM_IMP]
			-- List of menu items in menu.

	insert_item (item_imp: EV_ITEM_IMP; pos: INTEGER) is
			-- Insert `item_imp' on `pos' in `ev_children'.
		local
			sep_imp: EV_MENU_SEPARATOR_IMP
			wel_menu: WEL_MENU
			menu_imp: EV_MENU_IMP
			menu_item_imp: EV_MENU_ITEM_IMP
			pix_imp: EV_PIXMAP_IMP
		do
			menu_item_imp ?= item_imp
			check
				is_list_of_menu_item_imp: menu_item_imp /= Void
			end

			sep_imp ?= item_imp
			if sep_imp /= Void then
				insert_separator (pos - 1)
			else
				menu_imp ?= item_imp
				if menu_imp /= Void then
					wel_menu ?= menu_imp
					insert_popup (wel_menu, pos - 1, menu_imp.text)
				else
					--| FIXME Pixmaps to be implemented...
				--	if menu_item_imp.pixmap /= Void then
				--		pix_imp ?= menu_item_imp.pixmap.implementation
				--		insert_bitmap (pix_imp.bitmap, pos - 1 , menu_item_imp.id)
				--	end
					insert_string (menu_item_imp.text, pos - 1, menu_item_imp.id)
				end
			end

			ev_children.go_i_th (pos)
			ev_children.put_left (menu_item_imp)
		end

	remove_item (item_imp: EV_ITEM_IMP) is
			-- Remove `item_imp' from `ev_children'.
		local
			pos: INTEGER
			menu_item_imp: EV_MENU_ITEM_IMP
		do
			menu_item_imp ?= item_imp
			pos := ev_children.index_of (menu_item_imp, 1)
			delete_position (pos - 1)
			ev_children.go_i_th (pos)
			ev_children.remove
		end

	destroy is
		do
		end

end -- class EV_MENU_ITEM_LIST_IMP

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
--| Revision 1.2  2000/02/14 12:05:10  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.2  2000/02/05 02:16:08  brendel
--| Started implementing.
--| Remaining to be done:
--|  - pixmaps on menu items.
--|  - check menu item.
--|  - radio menu item.
--|
--| Revision 1.1.2.1  2000/02/04 01:05:40  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

