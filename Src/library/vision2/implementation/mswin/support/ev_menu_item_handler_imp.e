--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" A class that handle the menu items inside a%
		% container. Ancestor of EV_CONTAINER_IMP."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_ITEM_HANDLER_IMP

feature {NONE} -- Initialization

	initialize_handler is
			-- Create the hash-table.
		do
			create menu_items.make (1)
		end

feature -- Access

	menu_items: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]
			-- List of all the children

feature -- Basic operations

	update_menu is
			-- Graphical update of the menu
		local
			window: EV_WINDOW_IMP
		do
			window := top_level_window_imp
			if window /= Void then
				window.draw_menu
			end
		end

	register_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Register the given item and sub-items in the
			-- general list
		local
			ht: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]
			cc: ARRAYED_LIST [EV_ITEM_IMP]
			it: EV_MENU_ITEM_IMP
		do
			-- Initializations
			--| FIXME cc := item_imp.ev_children
			if menu_items = Void then
				initialize_handler
			end
			ht := menu_items

			-- Then, we register the item.
			ht.put (item_imp, item_imp.id)
			if cc /= Void then
				from
					cc.start
				until
					cc.after
				loop
					it ?= cc.item
					if it /= Void then
						ht.put (it, it.id)
					end
					cc.forth
				end
			end
		end

	unregister_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Register the given item and sub-items in the
			-- general list
		local
			ht: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]
			cc: ARRAYED_LIST [EV_ITEM_IMP]
			it: EV_MENU_ITEM_IMP
		do
			-- Initializations
			ht := menu_items
			--| FIXME cc := item_imp.ev_children

			-- Remove the item ans sub-items.
			ht.remove (item_imp.id)
			if cc /= Void then
				from
					cc.start
				until
					cc.after
				loop
					it ?= cc.item
					if it /= Void then
						ht.remove (it.id)
					end
					cc.forth
				end
			end

			-- If the hash-table is empty, we destroy it.
			if ht.is_empty then
				ht := Void
			end
		end

feature {NONE} -- WEL Implementation

--	on_menu_command (menu_id: INTEGER) is
			-- The `menu_id' has been choosen from the menu.
			-- If this feature is called, it means that the 
			-- child is a menu.
--		do
			--menu_items.item(menu_id).on_activate
--		end

feature {EV_POPUP_MENU_IMP} -- Deferred features

	top_level_window_imp: EV_WINDOW_IMP is
			-- Top level window that contains the current widget.
		deferred
		end

end -- class EV_MENU_ITEM_HANDLER_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.4.3  2001/03/01 03:23:44  manus
--| Removed obsolete calls to `empty', now replaced by `is_equal'.
--|
--| Revision 1.3.4.2  2000/08/11 23:59:17  rogers
--| Aded fixme not for release. As this class is no longer used by Vision2.
--|
--| Revision 1.3.4.1  2000/05/03 19:09:18  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/02/23 02:20:45  brendel
--| Removed feature `on_menu_command'.
--| This is now handled in EV_WINDOW_IMP.
--|
--| Revision 1.5  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.4  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.5  2000/02/05 02:14:35  brendel
--| Commented out some implementation.
--| This class will probably be obsolete anyway.
--|
--| Revision 1.3.6.4  2000/02/04 01:05:40  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--| Revision 1.3.6.3  2000/01/27 19:30:15  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.2  1999/12/17 17:01:00  rogers
--| Altered to fit in with the review branch. Minor changes, code now uses ev_children.
--|
--| Revision 1.3.6.1  1999/11/24 17:30:22  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
