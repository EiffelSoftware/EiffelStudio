--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision menu-container, Mswindows implementation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_HOLDER_IMP

inherit
	EV_MENU_HOLDER_I

feature {NONE} -- Initialization

	initialize_children is
			-- Create the children list.
		do
			create ev_children.make (1)
		end

	remove_children is
			-- Remove the children list.
		do
			ev_children := Void
		end

feature -- Access

	ev_children: ARRAYED_LIST [EV_MENU]
			-- Ids of the children of the menu
			-- We need them in memory because we cannot
			-- get them from the system

	item_handler: EV_MENU_ITEM_HANDLER_IMP is
			-- The container that handles the items.
		do
			Result ?= parent_imp
		end

feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		local
			cc: ARRAYED_LIST [EV_MENU]
		do
			cc ?= ev_children
			if not cc.is_empty then
				from
					cc.start
				until
					cc.is_empty
				loop
					remove_menu (cc.first)
				end
			end
			remove_children
		end

	add_menu (menu_imp: EV_MENU) is
			-- Add `a_menu' into container.
		local
			cc: ARRAYED_LIST [EV_MENU]
			it: EV_MENU_ITEM_IMP
		do
	--		-- First, we add the menu here.
	--		menu_container.append_popup (menu_imp.implementation, menu_imp.text)
	--		if ev_children = Void then
	--			initialize_children
	--		end
	--		ev_children.extend (menu_imp)
--
--			-- Then we register the items in it.
--			cc := menu_imp.ev_children
--			if cc /= Void then
--				from
--					cc.start
--				until
--					cc.after
--				loop
--					it ?= cc.item
--					if it /= Void then
--						item_handler.register_item (it)
--					end
--					cc.forth
--				end
--			end
		end

	remove_menu (menu_imp: EV_MENU) is
			-- Remove menu_imp from the container.
		local
			cc: ARRAYED_LIST [EV_MENU]
			it: EV_MENU_ITEM_IMP
		do
			-- First, we remove the menu from here.
			menu_container.delete_position (internal_get_index (menu_imp))
			ev_children.prune_all (menu_imp)

			-- Then, we unregister all the items in it.
			--| FIXME cc ?= menu_imp.implementation.ev_children
			if cc /= Void then
				from
					cc.start
				until
					cc.after
				loop
					it ?= cc.item
					if it /= Void then
						item_handler.unregister_item (it)
					end
					cc.forth
				end
			end

			-- The, we chack if there are no more children.
			if ev_children.is_empty then
				remove_children
			end
		end

feature -- Basic operation

	internal_get_index (menu_imp: EV_MENU): INTEGER is
			-- Return the index of `menu_imp' in the list.
		do
			Result := ev_children.index_of (menu_imp, 1)
		end

feature -- Event association

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
		deferred
		end

feature {EV_MENU_IMP} -- Implementation

	menu_container: WEL_MENU is
			-- Actual WEL container
		deferred
		end

	parent_imp: EV_CONTAINER_IMP is
			-- The window where the menu is.
		deferred
		end

end -- class EV_MENU_HOLDER_IMP

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
--| Revision 1.11  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.9.8.2  2001/03/01 03:23:44  manus
--| Removed obsolete calls to `empty', now replaced by `is_equal'.
--|
--| Revision 1.9.8.1  2000/05/03 19:09:18  oconnor
--| mergred from HEAD
--|
--| Revision 1.10  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.10.4  2000/02/04 01:05:40  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--| Revision 1.9.10.3  2000/01/27 19:30:15  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.10.2  1999/12/17 17:03:15  rogers
--| Altered to fit in with the review branch. ev_children replaces children. Changes made for this change.
--|
--| Revision 1.9.10.1  1999/11/24 17:30:21  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
