note
	description: "Eiffel Vision menu item list. Cocoa implementation."
	author: "Daniel Furrer"

deferred class
	EV_MENU_ITEM_LIST_IMP

inherit
	EV_MENU_ITEM_LIST_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_MENU_ITEM, EV_MENU_ITEM_IMP]
		redefine
			interface
		end

	EV_MENU_ITEM_LIST_ACTION_SEQUENCES_IMP

feature {NONE} -- Implementation

	radio_group: LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]
			-- Radios groups


	insert_item (item_imp: EV_MENU_ITEM_IMP; pos: INTEGER)
			-- Insert `item_imp' on `pos' in `ev_children'.
		local
			sep_imp: EV_MENU_SEPARATOR_IMP
			menu_imp: EV_MENU_IMP
			menu_item_imp: EV_MENU_ITEM_IMP
		do
			ev_children.go_i_th (pos)
			menu.insert_item_at_index (item_imp.menu_item, pos - 1)

			sep_imp ?= item_imp
			if sep_imp /= Void then
				insert_separator_item (sep_imp, pos)
			else
				menu_item_imp ?= item_imp
				menu_imp ?= menu_item_imp
				if menu_imp /= Void then
--					insert_menu (menu_imp, pos)
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

	insert_menu_item (menu_item_imp: EV_MENU_ITEM_IMP; pos: INTEGER)
			-- Insert `menu_imp' on `pos' in `ev_children'.
		local
			sep_imp: EV_MENU_SEPARATOR_IMP
			radio_imp: EV_RADIO_MENU_ITEM_IMP
			chk_imp: EV_CHECK_MENU_ITEM_IMP
		do
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
					else
							-- We are adding to an existing group,
							-- so there must be a radio button already checked.
							-- Therefore, we uncheck this one.
						radio_imp.menu_item.set_state ({NS_CELL}.off_state)
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
			chk_imp ?= menu_item_imp
			if chk_imp /= Void then
				if chk_imp.is_selected then
					chk_imp.enable_select
				end
			end
		end

	remove_item (item_imp: EV_MENU_ITEM_IMP)
			-- Remove `item_imp' from `ev_children'.
		local
			pos: INTEGER
		do
			pos := ev_children.index_of (item_imp, 1)
			menu.remove_item_at_index (pos - 1)
		end

	insert_separator_item (sep_imp: EV_MENU_SEPARATOR_IMP; pos: INTEGER)
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
						radio_imp.menu_item.set_state ({NS_CELL}.off_state)
						radio_imp.disable_select
					end
					radio_imp.set_radio_group (rgroup)
				end
				ev_children.forth
			end
			if rgroup /= Void then
				sep_imp.set_radio_group (rgroup)
			end
		end

	separator_imp_by_index (an_index: INTEGER): EV_MENU_SEPARATOR_IMP
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

	is_menu_separator_imp (item_imp: EV_ITEM_IMP): BOOLEAN
			-- Is `item_imp' of type EV_MENU_SEPARATOR_IMP?
		local
			sep_imp: EV_MENU_SEPARATOR_IMP
		do
			sep_imp ?= item_imp
			Result := sep_imp /= Void
		end

	is_sensitive: BOOLEAN
			-- Is `Current' sensitive?
		deferred
		end

feature {EV_ANY_I} -- Implementation

	menu: NS_MENU
		deferred
		end

	interface: detachable EV_MENU_ITEM_LIST note option: stable attribute end;
	
end -- class EV_MENU_ITEM_LIST_IMP
