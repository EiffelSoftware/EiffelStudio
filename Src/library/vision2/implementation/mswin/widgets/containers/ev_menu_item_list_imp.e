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

	WEL_RETURN_VALUE
		export
			{NONE} all
		end
		
	WEL_MNC_CONSTANTS
		export
			{NONE} all
		end

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
		
feature {EV_CONTAINER_IMP, EV_MENU_ITEM_LIST_IMP, EV_POPUP_MENU_HANDLER} -- WEL Implementation

	on_menu_char (char_code: CHARACTER; corresponding_menu: WEL_MENU): INTEGER is
			-- The menu char `char_code' has been typed within `corresponding_menu'.
		local
			shortcut_text: STRING
			menu_text: STRING
			child_index: INTEGER
			cur: CURSOR
		do
			if corresponding_menu.item = wel_item then
					-- Look for a menu whose shortcut is `char_code'
				shortcut_text := "&"
				shortcut_text.append_character (char_code)
				shortcut_text.to_lower

				cur := ev_children.cursor
				from
					ev_children.start
					child_index := 0
				until
					ev_children.after
				loop
					menu_text := clone (ev_children.item.text)
					if menu_text /= Void then
						menu_text.to_lower
						if menu_text.count > shortcut_text.count and then
						   menu_text.substring_index (shortcut_text, 1) /= 0
						then
							if Result = 0 then
									-- item with the right letter found,
									-- execute it.
								Result := (Mnc_execute |<< 16) | child_index
							else
									-- There is a second item with the right letter,
									-- just select the first one.
								Result := (Mnc_select |<< 16) | (Result & 0x0000FFFF)
							end
						end
					end
					ev_children.forth
					child_index := child_index + 1
				end
				ev_children.go_to (cur)
			else
					-- Propagate the event to the submenus.
				Result := propagate_on_menu_char (char_code, corresponding_menu)
			end
		end
		
feature {EV_WINDOW_IMP} -- Operations

	rebuild_control is
			-- Rebuild the control by removing all items
			-- and then reinserting them.
			--
			-- Used to entirely redraw the control when
			-- receiving a WM_SETTINGCHANGE message.
		local
			i: INTEGER
		do
				-- Remove all items
			from
			until
				wel_count = 0
			loop
				remove_position (0)
			end
			
				-- Quickly reinsert them
			from
				ev_children.start
				i := 1
			until
				ev_children.after
			loop
				quick_insert_item (ev_children.item, i)
				ev_children.forth
				i := i + 1
			end

			update_parent_size
		end
		
feature {NONE} -- Implementation

	ev_children: ARRAYED_LIST [EV_MENU_ITEM_IMP]
			-- List of menu items in menu.

	radio_group: LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]
			-- Radios groups
			
	insert_item (item_imp: EV_ITEM_IMP; pos: INTEGER) is
			-- Insert `item_imp' on `pos' in `ev_children'.
		local
			sep_imp: EV_MENU_SEPARATOR_IMP
			menu_imp: EV_MENU_IMP
			menu_item_imp: EV_MENU_ITEM_IMP
		do
			ev_children.go_i_th (pos)

			sep_imp ?= item_imp
			if sep_imp /= Void then
				insert_separator_item (sep_imp, pos)
			else
				menu_item_imp ?= item_imp
				menu_imp ?= menu_item_imp
				if menu_imp /= Void then
					insert_menu (menu_imp, pos)
				else
					insert_menu_item (menu_item_imp, pos)
				end

					-- Disable `menu_item_imp' if necessary.
					--| Disabling through the implementation so
					--| internal_non_sensitive from EV_SENSITIVE_I is not changed. 
				if not menu_item_imp.is_sensitive or not is_sensitive then
					menu_item_imp.disable_sensitive
				end
			end

			update_parent_size
		end
		
	quick_insert_item (menu_item_imp: EV_MENU_ITEM_IMP; pos: INTEGER) is
			-- Quickly insert `item_imp' on `pos' in `ev_children'.
			-- Do not take care of radio groups, etc.
			--
			-- Used to quickly rebuild the control (see `rebuild_control')
		local
			sep_imp: EV_MENU_SEPARATOR_IMP
			menu_imp: EV_MENU_IMP
			chk_imp: EV_CHECKABLE_MENU_ITEM_IMP
			menu_flag: INTEGER
		do
			menu_flag := Mf_byposition | Mf_ownerdraw

			sep_imp ?= menu_item_imp
			if sep_imp /= Void then
				cwin_insert_menu (wel_item, pos - 1, Mf_separator | menu_flag, 0, cwel_integer_to_pointer (sep_imp.object_id))
			else
				menu_imp ?= menu_item_imp
				if menu_item_imp.is_sensitive then
					menu_flag := menu_flag | Mf_enabled
				else
					menu_flag := menu_flag | Mf_grayed
				end
				if menu_imp /= Void then
					cwin_insert_menu (wel_item, pos - 1, Mf_popup | menu_flag, cwel_pointer_to_integer (menu_imp.wel_item), cwel_integer_to_pointer (menu_imp.object_id))
				else
					chk_imp ?= menu_item_imp
					if chk_imp /= Void and then chk_imp.is_selected then
						menu_flag := menu_flag | Mf_checked
					end
					cwin_insert_menu (wel_item, pos - 1, menu_flag, menu_item_imp.id, cwel_integer_to_pointer (menu_item_imp.object_id))
					check
						inserted: position_to_item_id (pos - 1) = menu_item_imp.id
						inserted_on_same_place: position_to_item_id (pos - 1) = (ev_children @ pos).id
					end
				end
			end
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

	insert_separator_item (sep_imp: EV_MENU_SEPARATOR_IMP; pos: INTEGER) is
			-- Insert `sep_imp' on `pos' in `ev_children'.
		local
			radio_imp: EV_RADIO_MENU_ITEM_IMP
			rgroup: LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]
		do
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
			cwin_insert_menu (wel_item, pos - 1, Mf_separator | Mf_byposition | Mf_ownerdraw, 0, cwel_integer_to_pointer (sep_imp.object_id))
		end
		
	insert_menu (menu_imp: EV_MENU_IMP; pos: INTEGER) is
			-- Insert `menu_imp' on `pos' in `ev_children'.
		local
			menu_flag: INTEGER
		do
			menu_flag := Mf_popup | Mf_byposition | Mf_ownerdraw
			cwin_insert_menu (wel_item, pos - 1, menu_flag, cwel_pointer_to_integer (menu_imp.wel_item),  cwel_integer_to_pointer (menu_imp.object_id))
		end
		
	insert_menu_item (menu_item_imp: EV_MENU_ITEM_IMP; pos: INTEGER) is
			-- Insert `menu_imp' on `pos' in `ev_children'.
		local
			sep_imp: EV_MENU_SEPARATOR_IMP
			radio_imp: EV_RADIO_MENU_ITEM_IMP
			chk_imp: EV_CHECK_MENU_ITEM_IMP
		do
			cwin_insert_menu (wel_item, pos -1, Mf_byposition | Mf_ownerdraw, menu_item_imp.id, cwel_integer_to_pointer (menu_item_imp.object_id))
			check
				inserted: position_to_item_id (pos - 1) = menu_item_imp.id
				inserted_on_same_place: position_to_item_id (pos - 1) = (ev_children @ pos).id
			end

			radio_imp ?= menu_item_imp
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
			
				-- If `item_imp' is a check menu item then check if necessary.
			chk_imp ?= menu_item_imp
			if chk_imp /= Void then
				if chk_imp.is_selected then
					chk_imp.enable_select
				end
			end
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

	propagate_on_menu_char (char_code: CHARACTER; corresponding_menu: WEL_MENU): INTEGER is
			-- Propagate the `on_menu_char' message to the submenus until
			-- the message is handled.
		local
			sub_menu: EV_MENU_IMP
			cur: CURSOR
		do
			cur := ev_children.cursor
			from
				ev_children.start
			until
				Result /= 0 or ev_children.after
			loop
				sub_menu ?= ev_children.item
				if sub_menu /= Void then
					Result := sub_menu.on_menu_char (char_code, corresponding_menu)
				end
				ev_children.forth
			end
			ev_children.go_to (cur)
		end

feature {EV_ANY_I, EV_POPUP_MENU_HANDLER} -- Implementation

	is_sensitive: BOOLEAN is
			-- Is `Current' sensitive?
		deferred
		end

	internal_replace (an_item: EV_MENU_ITEM_IMP; pos: INTEGER) is
			-- replace item at position `pos' with `an_item'.
			-- Will not alter state of radio_menu_items.
		do
				-- Remove item at `pos' - 1 from `Current'
			delete_position (pos - 1)
				
				-- Insert item at `pos' - 1.
			quick_insert_item (an_item, pos)
			ev_children.go_i_th (pos)
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
							item_select_actions_internal.call ([menu_item.interface])
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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

