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
			interface,
			initialize
		end

	WEL_MENU
		rename
			make as wel_make,
			item as wel_item,
			count as wel_count
		end

feature {NONE} -- Initialization

	initialize is
		do
			Precursor
			create ev_children.make (2)
			is_initialized := True
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
			elseif g.empty then
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
			pix_imp: EV_PIXMAP_IMP
			rgroup: LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]
			chk_imp: EV_CHECK_MENU_ITEM_IMP
		do
			menu_item_imp ?= item_imp

			ev_children.go_i_th (pos)
			ev_children.put_left (menu_item_imp)

			sep_imp ?= item_imp
			if sep_imp /= Void then
				from
					ev_children.go_i_th (pos + 1)
				until
					ev_children.after or else is_menu_separator_imp (ev_children.item)
				loop
					radio_imp ?= ev_children.item
					if radio_imp /= Void then
						if rgroup = Void then
							create rgroup.make
						else
							uncheck_item (radio_imp.id)
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
					insert_popup (wel_menu, pos - 1, menu_imp.text)
				else
					--| FIXME Pixmaps to be implemented...
					--|	if menu_item_imp.pixmap /= Void then
					--|		pix_imp ?= menu_item_imp.pixmap.implementation
					--|		insert_bitmap (pix_imp.bitmap, pos - 1 , menu_item_imp.id)
					--|	end
					insert_string (menu_item_imp.text, pos - 1, menu_item_imp.id)
					check
						inserted: position_to_item_id (pos - 1) = menu_item_imp.id
						inserted_on_same_place: position_to_item_id (pos - 1) = (ev_children @ pos).id
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
							radio_imp.set_radio_group (radio_group)
						end
					end
				end
			end

				-- This is to change the state if necessary.
				-- (see invariant EV_MENU_ITEM_IMP).
			if not is_menu_separator_imp (item_imp) then
				if not menu_item_imp.is_sensitive then
					menu_item_imp.disable_sensitive
				end
				chk_imp ?= item_imp
				if chk_imp /= Void then
					if chk_imp.is_selected then
						chk_imp.enable_select
					end
				end
			end

			ev_children.go_i_th (pos - 1)
		end

	is_menu_separator_imp (item_imp: EV_ITEM_IMP): BOOLEAN is
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
							sep_imp.radio_group.empty
						loop
							uncheck_item (sep_imp.radio_group.item.id)
							sep_imp.radio_group.item.set_radio_group (rgroup)
						end
						sep_imp.remove_radio_group
					end
				end
			end

			delete_position (pos - 1)
			ev_children.prune (menu_item_imp)
		end

	destroy is
		do
			--| FIXME
		end

	radio_group: LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]

	separator_imp_by_index (an_index: INTEGER): EV_MENU_SEPARATOR_IMP is
			-- Separator before item with `an_index'.
		require
			an_index_within_bounds:
				an_index > 0 and then an_index <= ev_children.count
		local
			cur: CURSOR
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
				ev_children.off
			loop
				menu_item := ev_children.item
				sub_menu ?= menu_item
				if sub_menu /= Void then
					sub_menu.menu_item_clicked (an_id)
				elseif menu_item.id = an_id then
					menu_item.on_activate
					interface.item_select_actions.call ([menu_item.interface])
				end
				ev_children.forth
			end
			ev_children.go_to (cur)
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

