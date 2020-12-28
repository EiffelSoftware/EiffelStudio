note
	description: "Eiffel Vision menu item list. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_ITEM_LIST_IMP

inherit
	EV_MENU_ITEM_LIST_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_MENU_ITEM, EV_MENU_ITEM_IMP]
		redefine
			interface,
			make
		end

	WEL_MENU
		rename
			make as wel_make,
			item as wel_item,
			count as wel_count
		end

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

feature -- Initialization

	old_make (an_interface: attached like interface)
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize
		do
			create ev_children.make (2)
			Precursor
		end

feature {EV_CONTAINER_IMP, EV_MENU_ITEM_LIST_IMP, EV_POPUP_MENU_HANDLER} -- WEL Implementation

	on_menu_char (char_code: CHARACTER; corresponding_menu: WEL_MENU): POINTER
			-- The menu char `char_code' has been typed within `corresponding_menu'.
		local
			shortcut_text: STRING_32
			menu_text: STRING_32
			child_index: INTEGER
			cur: CURSOR
		do
			if corresponding_menu.item = wel_item then
					-- Look for a menu whose shortcut is `char_code'
				create shortcut_text.make (2)
				shortcut_text.append_character ('&')
				shortcut_text.append_character (char_code)
				shortcut_text.to_lower

				cur := ev_children.cursor
				from
					ev_children.start
					child_index := 0
				until
					ev_children.after
				loop
					menu_text := ev_children.item.text.twin
					if menu_text /= Void then
						menu_text.to_lower
						if menu_text.count > shortcut_text.count and then
						   menu_text.substring_index (shortcut_text, 1) /= 0
						then
							if Result = default_pointer then
									-- item with the right letter found,
									-- execute it.
								Result := cwin_make_long (child_index, {WEL_MNC_CONSTANTS}.Mnc_execute)
							else
									-- There is a second item with the right letter,
									-- just select the first one.
								Result := cwin_make_long (cwin_lo_word (Result), {WEL_MNC_CONSTANTS}.Mnc_select)
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

feature {EV_WINDOW_IMP, EV_MENU_ITEM_IMP} -- Operations

	rebuild_control
			-- Rebuild the control by removing all items
			-- and then reinserting them.
			--
			-- Used to entirely redraw the control when
			-- receiving a WM_SETTINGCHANGE message.
		local
			i: INTEGER
			l_cursor: INTEGER
		do
				-- Remove all items
			from
			until
				wel_count <= 0
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
				l_cursor := ev_children.index
				quick_insert_item (ev_children.item, i)
				ev_children.go_i_th (l_cursor)
				ev_children.forth
				i := i + 1
			end

			update_parent_size
		end

feature {NONE} -- Implementation

	ev_children: ARRAYED_LIST [EV_MENU_ITEM_IMP]
			-- List of menu items in menu.

	radio_group: detachable LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]
			-- Radios groups

	insert_item (item_imp: EV_ITEM_IMP; pos: INTEGER)
			-- Insert `item_imp' on `pos' in `ev_children'.
		local
		do
			ev_children.go_i_th (pos)

			if attached {EV_MENU_SEPARATOR_IMP} item_imp as sep_imp then
				insert_separator_item (sep_imp, pos)
			else
				check attached {EV_MENU_ITEM_IMP} item_imp as menu_item_imp then
					if attached {EV_MENU_IMP} menu_item_imp as menu_imp then
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
			end

			update_parent_size
		end

	quick_insert_item (menu_item_imp: EV_MENU_ITEM_IMP; pos: INTEGER)
			-- Quickly insert `item_imp' on `pos' in `ev_children'.
			-- Do not take care of radio groups, etc.
			--
			-- Used to quickly rebuild the control (see `rebuild_control')
		require
			menu_item_imp_not_void: menu_item_imp /= Void
			valid_pos: pos > 0
		local
			menu_flag: INTEGER
		do
			menu_flag := Mf_byposition | Mf_ownerdraw

			if attached {EV_MENU_SEPARATOR_IMP} menu_item_imp as sep_imp then
				cwin_insert_menu (wel_item, pos - 1, Mf_separator | menu_flag,
					default_pointer, cwel_integer_to_pointer (sep_imp.object_id))
			else
				if menu_item_imp.is_sensitive then
					menu_flag := menu_flag | Mf_enabled
				else
					menu_flag := menu_flag | Mf_grayed
				end
				if attached {EV_MENU_IMP} menu_item_imp as menu_imp then
					cwin_insert_menu (wel_item, pos - 1, Mf_popup | menu_flag,
						menu_imp.wel_item, cwel_integer_to_pointer (menu_imp.object_id))
				else
					if attached {EV_CHECKABLE_MENU_ITEM_IMP} menu_item_imp as chk_imp and then chk_imp.is_selected then
						menu_flag := menu_flag | Mf_checked
					end
					cwin_insert_menu (wel_item, pos - 1, menu_flag,
						cwel_integer_to_pointer (menu_item_imp.id),
						cwel_integer_to_pointer (menu_item_imp.object_id))
					check
						inserted: position_to_item_id (pos - 1) = menu_item_imp.id
						inserted_on_same_place: position_to_item_id (pos - 1) = (ev_children @ pos).id
					end
				end
			end
		end

	remove_item (item_imp: EV_ITEM_IMP)
			-- Remove `item_imp' from `ev_children'.
		local
			pos: INTEGER
			rgroup: detachable like radio_group
		do
			check attached {EV_MENU_ITEM_IMP} item_imp as menu_item_imp then
				pos := ev_children.index_of (menu_item_imp, 1)

					-- Enable `menu_item_imp' if necessary.
				if not is_sensitive then
					if not menu_item_imp.internal_non_sensitive then
						menu_item_imp.enable_sensitive
					end
				end

					-- Handle radio grouping.
				if
					attached {EV_MENU_SEPARATOR_IMP} item_imp
					or else attached {EV_RADIO_MENU_ITEM_IMP} item_imp
				then
					-- Find the radio-group we need to modify.
					from
						rgroup := radio_group
						ev_children.start
					until
						ev_children.item = menu_item_imp
					loop
						if attached {EV_MENU_SEPARATOR_IMP} ev_children.item as sep_imp then
							rgroup := sep_imp.radio_group
						end
						ev_children.forth
					end
					-- `rgroup' is now the group above `item_imp'.
					if attached {EV_RADIO_MENU_ITEM_IMP} item_imp as radio_imp then
						-- Remove from `rgroup'.
						radio_imp.remove_from_radio_group
					else
						check attached {EV_MENU_SEPARATOR_IMP} item_imp as sep_imp then
							if attached sep_imp.radio_group as l_radio_group then
								if not l_radio_group.is_empty then
									-- Merge `rgroup' with the one from `sep_imp'.
									from
										l_radio_group.last.enable_select
										l_radio_group.start
									until
										l_radio_group.is_empty
									loop
										uncheck_item (l_radio_group.item.id)
										l_radio_group.item.set_radio_group (rgroup)
									end
								end
								sep_imp.remove_radio_group
							end
						end
					end
				end
				remove_position (pos - 1)
			end

				-- If `Current' is now empty, then we need to update the
				-- size of the parent. When an EV_MENU_BAR is empty, it takes
				-- up no space.
			if wel_count = 0 then
				update_parent_size
			end
		end

	insert_separator_item (sep_imp: EV_MENU_SEPARATOR_IMP; pos: INTEGER)
			-- Insert `sep_imp' on `pos' in `ev_children'.
		local
			rgroup: detachable LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]
		do
			from
				ev_children.go_i_th (pos + 1)
			until
				ev_children.after or else
					is_menu_separator_imp (ev_children.item)
			loop
				if attached {EV_RADIO_MENU_ITEM_IMP} ev_children.item as radio_imp then
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
			cwin_insert_menu (wel_item, pos - 1, Mf_separator | Mf_byposition | Mf_ownerdraw,
				default_pointer, cwel_integer_to_pointer (sep_imp.object_id))
		end

	insert_menu (menu_imp: EV_MENU_IMP; pos: INTEGER)
			-- Insert `menu_imp' on `pos' in `ev_children'.
		local
			menu_flag: INTEGER
		do
			menu_flag := Mf_popup | Mf_byposition | Mf_ownerdraw
			cwin_insert_menu (wel_item, pos - 1, menu_flag, menu_imp.wel_item,
				cwel_integer_to_pointer (menu_imp.object_id))
		end

	insert_menu_item (menu_item_imp: EV_MENU_ITEM_IMP; pos: INTEGER)
			-- Insert `menu_imp' on `pos' in `ev_children'.
		local
			sep_imp: detachable EV_MENU_SEPARATOR_IMP
		do
			cwin_insert_menu (wel_item, pos -1, Mf_byposition | Mf_ownerdraw,
				cwel_integer_to_pointer (menu_item_imp.id),
				cwel_integer_to_pointer (menu_item_imp.object_id))
			check
				inserted: position_to_item_id (pos - 1) = menu_item_imp.id
				inserted_on_same_place: position_to_item_id (pos - 1) = (ev_children @ pos).id
			end

			if attached {EV_RADIO_MENU_ITEM_IMP} menu_item_imp as radio_imp then
				-- Attach it to a radio group.
				sep_imp := separator_imp_by_index (pos)
				if sep_imp /= Void then
					-- It follows a separator.
					if sep_imp.radio_group = Void then
						sep_imp.create_radio_group
							-- First item inserted in the group is selected.
						radio_imp.enable_select
					else
							-- We are adding to an existing group,
							-- so there must be a radio button already checked.
							-- Therefore, we uncheck this one.
						uncheck_item (radio_imp.id)
						radio_imp.disable_select
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
			if attached {EV_CHECK_MENU_ITEM_IMP} menu_item_imp as chk_imp then
				if chk_imp.is_selected then
					chk_imp.enable_select
				end
			end
		end

	update_parent_size
			-- Update size of parent.
		deferred
		end

	is_menu_separator_imp (item_imp: EV_ITEM_IMP): BOOLEAN
			-- Is `item_imp' of type EV_MENU_SEPARATOR_IMP?
		do
			Result := attached {EV_MENU_SEPARATOR_IMP} item_imp
		end

	separator_imp_by_index (an_index: INTEGER): detachable EV_MENU_SEPARATOR_IMP
			-- Separator before item with `an_index'.
		require
			an_index_within_bounds:
				an_index > 0 and then an_index <= ev_children.count
		local
			cur_item: INTEGER
		do
			from
				ev_children.start
				cur_item := 1
			until
				ev_children.off or else an_index = cur_item
			loop
				if attached {EV_MENU_SEPARATOR_IMP} ev_children.item as sep_imp then
					Result := sep_imp
				end
				ev_children.forth
				cur_item := cur_item + 1
			end
		end

	propagate_on_menu_char (char_code: CHARACTER; corresponding_menu: WEL_MENU): POINTER
			-- Propagate the `on_menu_char' message to the submenus until
			-- the message is handled.
		local
			cur: CURSOR
		do
			cur := ev_children.cursor
			from
				ev_children.start
			until
				Result /= default_pointer or ev_children.after
			loop
				if attached {EV_MENU_IMP} ev_children.item as sub_menu then
					Result := sub_menu.on_menu_char (char_code, corresponding_menu)
				end
				ev_children.forth
			end
			ev_children.go_to (cur)
		end

feature {EV_ANY_I, EV_POPUP_MENU_HANDLER} -- Implementation

	is_sensitive: BOOLEAN
			-- Is `Current' sensitive?
		deferred
		end

	internal_replace (an_item: EV_MENU_ITEM_IMP; pos: INTEGER)
			-- replace item at position `pos' with `an_item'.
			-- Will not alter state of radio_menu_items.
		do
				-- Remove item at `pos' - 1 from `Current'
			remove_position (pos - 1)

				-- Insert item at `pos' - 1.
			quick_insert_item (an_item, pos)
			ev_children.go_i_th (pos)
		end

	menu_opened (a_menu: WEL_MENU)
			-- Call `select_actions' for `a_menu'.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_menu_item: detachable EV_MENU_ITEM_IMP
			l_comparator: PREDICATE [EV_MENU_ITEM_IMP]
		do
			l_comparator := agent (a_menu_item: EV_MENU_ITEM_IMP; a_wel_menu: WEL_MENU): BOOLEAN
				do
					if attached {EV_MENU_IMP} a_menu_item as l_menu then
						Result := l_menu.wel_item = a_wel_menu.item
					end
				end (?, a_menu)
			l_menu_item := menu_item_from_comparator (l_comparator)
			if l_menu_item /= Void and then l_menu_item.select_actions_internal /= Void then
				l_menu_item.select_actions.call (Void)
			end
		end

	menu_item_clicked (a_id: INTEGER)
			-- Call `on_activate' for menu item with `a_id'.
		local
			l_menu_item: detachable EV_MENU_ITEM_IMP
			l_comparator: PREDICATE [EV_MENU_ITEM_IMP]
		do
			l_comparator := agent (a_menu_item: EV_MENU_ITEM_IMP; a_item_id: INTEGER): BOOLEAN
				do
					Result := a_menu_item.id = a_item_id
				end (?, a_id)
			l_menu_item := menu_item_from_comparator (l_comparator)
			if l_menu_item /= Void then
				l_menu_item.on_activate
				if attached item_select_actions_internal as act then
					act.call ([l_menu_item.attached_interface])
				elseif
					attached l_menu_item.parent as l_menu and then
					attached l_menu.item_select_actions as p_act
				then
					p_act.call ([l_menu_item.attached_interface])
				end
			end
		end

	menu_item_from_comparator (a_comparator: PREDICATE [EV_MENU_ITEM_IMP]): detachable EV_MENU_ITEM_IMP
			-- Retrieve menu item using comparator predicate `a_comparator'.
		require
			a_comparator_not_void: a_comparator /= Void
		local
			i: INTEGER
			l_count: INTEGER
			l_menu_item: detachable EV_MENU_ITEM_IMP
		do
			from
				i := 1
				l_count := count
			until
				Result /= Void or else i > l_count
			loop
				l_menu_item := ev_children @ i
				if l_menu_item /= Void then
					if attached {EV_MENU_IMP} l_menu_item as l_sub_menu then
						Result := l_sub_menu.menu_item_from_comparator (a_comparator)
					end
					if Result = Void and then a_comparator.item ([l_menu_item]) then
						Result := l_menu_item
					end
				end
				i := i + 1
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_MENU_ITEM_LIST note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_MENU_ITEM_LIST_IMP










