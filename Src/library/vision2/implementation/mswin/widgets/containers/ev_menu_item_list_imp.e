indexing
	description: "Eiffel Vision menu item list. Mswindows implementation."
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
			interface
		end

	WEL_MENU
		rename
			make as wel_make,
			item as wel_item,
			count as wel_count
		end

	EV_MENU_ITEM_LIST_ACTION_SEQUENCES_IMP

feature {NONE} -- Initialization

	make (an_interface: like interface) is
		do
			base_make (an_interface)
			create ev_children.make (2)
		end
			
feature -- Standard output

	print_radio_groups is
		local
			cur: CURSOR
			sep_imp: EV_MENU_SEPARATOR_IMP
			list_imp: EV_MENU_ITEM_LIST_IMP
		do
			cur := ev_children.cursor
			from
				io.put_string ("Menu:%N")
				print_radio_group (radio_group)
				ev_children.start
			until
				ev_children.off
			loop
				sep_imp ?= ev_children.item
				if sep_imp /= Void then
					io.put_string ("Separator:%N")
					print_radio_group (sep_imp.radio_group)
				end
				list_imp ?= ev_children.item
				if list_imp /= Void then
					list_imp.print_radio_groups
				end
				ev_children.forth
			end
			ev_children.go_to (cur)
		end

	print_radio_group (g: like radio_group) is
		local
			cur: CURSOR
		do
			if g = Void then
				io.put_string ("%T(no radio-group)%N")
			elseif g.is_empty then
				io.put_string ("%T(empty group)%N")
			else
				cur := g.cursor
				from
					g.start
				until
					g.off
				loop
					if g.item.is_selected then
						io.put_string ("->")
					end
					io.put_string ("%T" + g.item.text + "%N")
					g.forth
				end
				g.go_to (cur)
			end
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
			radio_imp: EV_RADIO_MENU_ITEM_IMP
			rgroup: LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]
			chk_imp: EV_CHECK_MENU_ITEM_IMP
			pix_imp: EV_PIXMAP_IMP_STATE
			tmp_bitmap: WEL_BITMAP
		do
			menu_item_imp ?= item_imp

			ev_children.go_i_th (pos)

			sep_imp ?= item_imp
			if sep_imp /= Void then
				from
					ev_children.go_i_th (pos + 1)
				until
					ev_children.after or else
						is_menu_separator_imp (ev_children.item)
				loop
					radio_imp ?= ev_children.item
					if radio_imp /= Void then
						if rgroup = Void then
							create rgroup.make
						else
							uncheck_item (radio_imp.id)
							radio_imp.disable_select
						end
						radio_imp.set_radio_group (rgroup)
					end							
					ev_children.forth
				end
				if rgroup /= Void then
					sep_imp.set_radio_group (rgroup)
				end
				insert_separator (pos - 1)
			else
				menu_imp ?= item_imp
				if menu_imp /= Void then
					wel_menu ?= menu_imp
						-- We check that the text of the menu is not empty.
						-- This stops insert_popup from failing, as text
						-- returns Void if empty.
					if menu_imp.text = Void then
						insert_popup (wel_menu, pos - 1, "")
					else
						insert_popup (wel_menu, pos - 1, menu_imp.text)
					end
				else
					if menu_item_imp.pixmap_imp /= Void then
						pix_imp ?= menu_item_imp.pixmap.implementation
						tmp_bitmap := pix_imp.get_bitmap
						insert_bitmap (tmp_bitmap, pos -1, menu_item_imp.id)
						tmp_bitmap.decrement_reference
						tmp_bitmap := Void
					else
						-- We check that the text of the item is not empty.
						-- This stops insert_string from failing, as text
						-- returns Void if empty.
						if menu_item_imp.text = Void then
							insert_string ("", pos - 1, menu_item_imp.id)
						else
							insert_string
							(menu_item_imp.text, pos - 1, menu_item_imp.id)
						end
					end
					check
						inserted: position_to_item_id (pos - 1) =
							menu_item_imp.id
						inserted_on_same_place: position_to_item_id (pos - 1) =
							(ev_children @ pos).id
					end

					radio_imp ?= item_imp
					if radio_imp /= Void then
						-- Attach it to a radio group.
						sep_imp := separator_imp_by_index (pos)
						if sep_imp /= Void then 
							-- It follows a separator.
							if sep_imp.radio_group = Void then
								sep_imp.create_radio_group
								-- First item inserted in the group is selected.
								radio_imp.enable_select
							end
							radio_imp.set_radio_group (sep_imp.radio_group)
						else
							-- It is above any separator.
							if radio_group = Void then
								create radio_group.make
								-- First item inserted in the group is selected.
								radio_imp.enable_select
							end
								-- If `radio_imp' already has a selected peer
								-- then disable `radio_imp'.
							if radio_imp.selected_peer /= Void then
								radio_imp.disable_select
							end
							radio_imp.set_radio_group (radio_group)
						end
					end
				end
			end

				-- If `item_imp' is a check menu item then check if necessary.
				chk_imp ?= item_imp
				if chk_imp /= Void then
					if chk_imp.is_selected then
						chk_imp.enable_select
					end
				end

				-- Disable `menu_item_imp' if necessary.
				--| Disabling through the implementation so
				--| internal_non_sensitive from EV_SENSITIVE_I is not changed. 
			if not menu_item_imp.is_sensitive or not is_sensitive then
				menu_item_imp.disable_sensitive
			end
			update_parent_size
		end
		
	update_parent_size is
			-- Update size of parent.
		deferred
		end

	is_menu_separator_imp (item_imp: EV_ITEM_IMP): BOOLEAN is
			-- Is `item_imp' of type EV_MENU_SEPARATOR_IMP?
		local
			sep_imp: EV_MENU_SEPARATOR_IMP
		do
			sep_imp ?= item_imp
			Result := sep_imp /= Void
		end

	remove_item (item_imp: EV_ITEM_IMP) is
			-- Remove `item_imp' from `ev_children'.
		local
			pos: INTEGER
			menu_item_imp: EV_MENU_ITEM_IMP
			sep_imp: EV_MENU_SEPARATOR_IMP
			radio_imp: EV_RADIO_MENU_ITEM_IMP
			rgroup: like radio_group
		do
			menu_item_imp ?= item_imp
			pos := ev_children.index_of (menu_item_imp, 1)
	
				-- Enable `menu_item_imp' if necessary.
			if not is_sensitive then
				if not menu_item_imp.internal_non_sensitive then
					menu_item_imp.enable_sensitive
				end
			end

				-- Handle radio grouping.
			sep_imp ?= item_imp
			radio_imp ?= item_imp
			if sep_imp /= Void or else radio_imp /= Void then
				-- Find the radio-group we need to modify.
				from
					rgroup := radio_group
					ev_children.start
				until
					ev_children.item = menu_item_imp
				loop
					sep_imp ?= ev_children.item
					if sep_imp /= Void then
						rgroup := sep_imp.radio_group
					end
					ev_children.forth
				end
				-- `rgroup' is now the group above `item_imp'.
				if radio_imp /= Void then
					-- Remove from `rgroup'.
					radio_imp.remove_from_radio_group
				else
					sep_imp ?= item_imp
					if sep_imp.radio_group /= Void then
						-- Merge `rgroup' with the one from `sep_imp'.
						from
							sep_imp.radio_group.last.enable_select
							sep_imp.radio_group.start
						until
							sep_imp.radio_group.is_empty
						loop
							uncheck_item (sep_imp.radio_group.item.id)
							sep_imp.radio_group.item.set_radio_group (rgroup)
						end
						sep_imp.remove_radio_group
					end
				end
			end

			remove_position (pos - 1)
			
				-- If `Current' is now empty, then we need to update the 
				-- size of the parent. When an EV_MENU_BAR is empty, it takes
				-- up no space.
			if wel_count = 0 then
				update_parent_size
			end	
		end

	radio_group: LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]

	separator_imp_by_index (an_index: INTEGER): EV_MENU_SEPARATOR_IMP is
			-- Separator before item with `an_index'.
		require
			an_index_within_bounds:
				an_index > 0 and then an_index <= ev_children.count
		local
			cur_item: INTEGER
			sep_imp: EV_MENU_SEPARATOR_IMP
		do
			from
				ev_children.start
				cur_item := 1
			until
				ev_children.off or else an_index = cur_item
			loop
				sep_imp ?= ev_children.item
				if sep_imp /= Void then
					Result := sep_imp
				end
				ev_children.forth
				cur_item := cur_item + 1
			end
		end

feature {EV_ANY_I, EV_POPUP_MENU_HANDLER} -- Implementation

	is_sensitive: BOOLEAN is
			-- Is `Current' sensitive?
		deferred
		end

	internal_replace (an_item: EV_MENU_ITEM_IMP; pos: INTEGER) is
			-- replace item at position `pos' with `an_item'.
			-- Will not alter state of radio_menu_items.
		local
			radio_menu_item_imp: EV_RADIO_MENU_ITEM_IMP
			wel_menu: WEL_MENU
			menu_imp: EV_MENU_IMP
			chk_imp: EV_CHECK_MENU_ITEM_IMP
			pix_imp: EV_PIXMAP_IMP_STATE
			tmp_bitmap: WEL_BITMAP
		do
				-- Remove item at `pos' - 1 from `Current'
			delete_position (pos - 1)
			
			ev_children.go_i_th (pos)

			menu_imp ?= an_item
			if menu_imp /= Void then
				wel_menu ?= menu_imp
					-- We check that the text of the menu is not empty.
					-- This stops insert_popup from failing, as text
					-- returns Void if empty.
				if menu_imp.text = Void then
					insert_popup (wel_menu, pos - 1, "")
				else
					insert_popup (wel_menu, pos - 1, menu_imp.text)
				end
			else
					if an_item.pixmap_imp /= Void then
						pix_imp ?= an_item.pixmap.implementation
						tmp_bitmap := pix_imp.get_bitmap
						insert_bitmap (tmp_bitmap, pos -1, an_item.id)
						tmp_bitmap.decrement_reference
						tmp_bitmap := Void
					else
						-- We check that the text of the item is not empty.
						-- This stops insert_string from failing, as text
						-- returns Void if empty.
						if an_item.text = Void then
							insert_string ("", pos - 1, an_item.id)
						else
							insert_string
							(an_item.text, pos - 1, an_item.id)
						end
					end
				check
					inserted: position_to_item_id (pos - 1) =
						an_item.id
				end
			end
				-- If `an_item' is a check menu item then check if necessary.
			chk_imp ?= an_item
			if chk_imp /= Void then
				if chk_imp.is_selected then
					chk_imp.enable_select
				end
			end

			-- If `an_item' is selected then select in `Current'.	
		radio_menu_item_imp ?= an_item
		if radio_menu_item_imp /= Void then
			if radio_menu_item_imp.is_selected then
				radio_menu_item_imp.enable_select
			end
		end
	end
	
	menu_opened (a_menu: WEL_MENU) is
			-- Call `select_actions' for `a_menu'.
		local
			cur: CURSOR
			menu_item: EV_MENU_ITEM_IMP
			sub_menu: EV_MENU_IMP
			wel_menu: WEL_MENU
		do
			cur := ev_children.cursor
			from
				ev_children.start
			until
				ev_children.after
			loop	
				menu_item := ev_children.item
				if menu_item /= Void then
					sub_menu ?= menu_item
				end
				if sub_menu /= Void then
					wel_menu ?= sub_menu
					if wel_menu.item = a_menu.item then
						if sub_menu.select_actions_internal /= Void then
							sub_menu.select_actions_internal.call ([])
						end
					else
						sub_menu.menu_opened (a_menu)
					end
				end
				if not ev_children.off then
					ev_children.forth
				end
			end
			if ev_children.valid_cursor (cur) then
				ev_children.go_to (cur)
			end	
		end

	menu_item_clicked (an_id: INTEGER) is
			-- Call `on_activate' for menu item with `an_id'.
		local
			cur: CURSOR
			sub_menu: EV_MENU_IMP
			menu_item: EV_MENU_ITEM_IMP
		do
			cur := ev_children.cursor
			from
				ev_children.start
			until
				ev_children.after
			loop
				menu_item := ev_children.item
				if menu_item /= Void then
					sub_menu ?= menu_item
					if sub_menu /= Void then
						sub_menu.menu_item_clicked (an_id)
					elseif menu_item.id = an_id then
						menu_item.on_activate
						if item_select_actions_internal /= Void then
							item_select_actions_internal.call
								([menu_item.interface])
						end
					end
				end
				if not ev_children.off then
					ev_children.forth
				end
			end
			if ev_children.valid_cursor (cur) then
				ev_children.go_to (cur)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_ITEM_LIST

end -- class EV_MENU_ITEM_LIST_IMP

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.18  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.17  2001/06/07 23:08:15  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.15.2.24  2001/04/03 17:18:50  rogers
--| Added menu_opened which calls the select actions for a given WEL_MENU.
--| Previously, the select actions were never called on the menus.
--|
--| Revision 1.15.2.23  2001/03/22 19:13:59  xavier
--| Fixed a precondition violation occurring when modifying the menus or menu bars
--| while a menu item is clicked.
--|
--| Revision 1.15.2.22  2001/03/21 19:14:43  rogers
--| When the last item is removed from `Current', we now update the size of
--| the parent. For example, if `Current' is an EV_MENU_BAR, then it no longer
--| takes up any space, and we need to resize the parent and its contents.
--|
--| Revision 1.15.2.21  2001/03/21 18:22:25  rogers
--| Added missing comments to `update_parent_size' and `is_menu_separator_imp'.
--|
--| Revision 1.15.2.20  2001/03/04 22:27:54  pichery
--| - renammed `bitmap' into `get_bitmap'
--| - Cosmetics
--|
--| Revision 1.15.2.19  2001/02/23 23:40:17  pichery
--| Added tight reference tracking for wel_bitmaps.
--|
--| Revision 1.15.2.18  2000/12/04 18:39:18  rogers
--| Fixed bug in menu_item_clicked. If the select_actions of an item
--| modified the contents of the parent, then this could cause a pre
--| condition violation when calling `ev_children.forth'.
--|
--| Revision 1.15.2.17  2000/12/04 17:55:38  rogers
--| Remove_item now calls remove_position instead of delete_position. This
--| allows a sub menu to be removed from a menu and then re-inserted into
--| another menu.
--|
--| Revision 1.15.2.16  2000/11/29 00:43:11  rogers
--| Changed empty to is_empty.
--|
--| Revision 1.15.2.15  2000/08/21 18:15:20  rogers
--| Removed commented out destroy.
--|
--| Revision 1.15.2.14  2000/08/21 18:07:10  rogers
--| Changed export of is_sensitive to EV_ANY_I. Removed destroy.
--|
--| Revision 1.15.2.13  2000/08/21 17:46:55  rogers
--| enabled pixmap functionality. Added internal_replace which will replace
--| in item in `Current', without altering the state of any radio groupings.
--|
--| Revision 1.15.2.12  2000/08/18 19:31:52  rogers
--| Insert_item now handles items with pixmaps.
--|
--| Revision 1.15.2.11  2000/08/17 18:19:30  rogers
--| insert_item now internally disables the selection of radio menu items
--| when added. Previously, they were graphically unselected but when queried,
--| `is_Selected' would return `True'.
--|
--| Revision 1.15.2.10  2000/08/16 23:07:01  rogers
--| Added is_Sensitive as deferred. insert_item now disables the item added to
--| `Current' when `Current' is disabled. remove_item now enables the removed
--| item if the item was only disabled due to being parented in a disabled
--| menu.
--|
--| Revision 1.15.2.9  2000/08/16 19:04:27  rogers
--| Minor comment change.
--|
--| Revision 1.15.2.7  2000/08/16 17:39:18  rogers
--| Fixed bug in insert_item. Adding an item with no text will no longer
--| cause a_string_not_void to fail from insert_string in WEL_MENU.
--|
--| Revision 1.15.2.6  2000/08/04 19:31:34  rogers
--| All actions sequences called through the interface have been replaced with
--| calls to the internal action sequences. Formatting to 80 columns.
--|
--| Revision 1.15.2.5  2000/07/25 00:00:04  rogers
--| Now inherits EV_MENU_ITEM_LIST_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.15.2.4  2000/07/01 08:59:00  pichery
--| Fixed bugs
--|
--| Revision 1.15.2.3  2000/06/29 03:12:04  pichery
--| Fixed bug in `remove'
--|
--| Revision 1.15.2.2  2000/05/30 16:24:57  rogers
--| Removed unreferenced local variables.
--|
--| Revision 1.15.2.1  2000/05/03 19:09:36  oconnor
--| mergred from HEAD
--|
--| Revision 1.15  2000/04/10 17:57:48  brendel
--| Removed calls to ev_children in graphical insert/remove function.
--|
--| Revision 1.14  2000/04/10 16:27:56  brendel
--| Modified creation sequence.
--|
--| Revision 1.13  2000/04/07 01:33:52  brendel
--| Improved separator_imp_by_index.
--|
--| Revision 1.12  2000/04/05 21:16:12  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.11.2.1  2000/04/03 18:22:07  brendel
--| Renamed count as wel_count.
--|
--| Revision 1.11  2000/03/24 19:21:36  rogers
--| Redefined initialize from EV_ITEM_LIST_IMP.
--|
--| Revision 1.10  2000/03/23 01:05:06  brendel
--| Now calls item_select_actions.
--|
--| Revision 1.9  2000/03/22 23:48:45  brendel
--| Exported menu_item_clicked to EV_POPUP_MENU_HANDLER.
--| Removed stupid comment about performance.
--|
--| Revision 1.8  2000/03/15 16:56:17  brendel
--| Removed redefinition of insert_string, since the bug is fixed in WEL.
--|
--| Revision 1.7  2000/02/25 20:22:12  brendel
--| Added redefine of insert_string, since there is a bug in WEL. Remove this
--| redeclaration and fix WEL as soon as this is known to be the right fix.
--| Added fix that makes sure the state of menu items is actually set in
--| the menu.
--|
--| Revision 1.6  2000/02/24 01:41:22  brendel
--| Fully implemented radio item grouping.
--|
--| Revision 1.5  2000/02/23 02:23:16  brendel
--| Implemented radio grouping separated by menu-separators.
--| Added feature `menu_item_clicked' that tries to find the menu-item that
--| has been clicked based on its `id'.
--|
--| Revision 1.4  2000/02/22 18:39:46  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.3  2000/02/19 05:45:00  oconnor
--| released
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

