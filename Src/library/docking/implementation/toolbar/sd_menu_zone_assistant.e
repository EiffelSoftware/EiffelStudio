indexing
	description: "Assistants that manage a SD_MENU_ZONE size and position issues."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_ZONE_ASSISTANT

create
	make

feature {NONE} -- Initlization

	make (a_menu_zone: SD_MENU_ZONE) is
			-- Creation method
		require
			not_void: a_menu_zone /= Void
		do
			menu := a_menu_zone
			create internal_hide_items.make (1)
		ensure
			set: menu = a_menu_zone
		end

feature -- Command

	reduce_size (a_size: INTEGER): INTEGER is
			-- Reduce a_size, Result is how many size actually reduced.
		require

		local
			l_old_size: INTEGER
			l_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
			l_separator: EV_TOOL_BAR_SEPARATOR
		do
			l_old_size := menu.size
			l_items := menu.content.menu_items

			from
				l_items.finish
			until
				-- At least show one button.
				l_items.index <= 1 or Result >= a_size
			loop

				if l_items.item.parent /= Void and then l_items.item.parent.parent /= Void then
					check has: menu.has (l_items.item.parent) end
					l_items.item.parent.parent.prune (l_items.item.parent)
					l_items.item.parent.prune (l_items.item)
					l_separator ?= l_items.i_th (l_items.index - 1)
					if l_separator /= Void then
						-- Prune correspond SD_TOOL_BAR_SEPARATOR from `menu'.
						menu.prune_last_separator
					end
					internal_hide_items.extend (l_items.item)
				end

				if menu.row /= Void then
					if not menu.is_vertical then
						menu.row.set_item_width (menu, menu.minimum_width)
					else
						menu.row.set_item_height (menu, menu.minimum_height)
					end
				end
				Result := l_old_size - menu.size
				l_items.back
			end
			update_indicator
		end

	expand_size (a_size_to_expand: INTEGER): INTEGER is
			-- Expand `menu' a_size_to_expand, Result is actually size expanded.
		require
			valid: a_size_to_expand >= 0
		local
			l_snapshot: like hide_menu_items
			l_old_size: INTEGER
		do
			if hide_menu_items.count /= 0 then
				from
					l_old_size := menu.size
					prune_all_parent (internal_hide_items)
					l_snapshot := internal_hide_items.twin
					l_snapshot.start
				until
					l_snapshot.after or Result >= a_size_to_expand
				loop
					menu.extend_one_item (l_snapshot.item)

					internal_hide_items.start
					internal_hide_items.prune (l_snapshot.item)
					check not_has: not internal_hide_items.has (l_snapshot.item) end

					Result := menu.size - l_old_size
					l_snapshot.forth
				end
			end
			debug ("docking")
				print ("%NSD_MENU_ZONE_SIZER expand_size +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" +
							 " Result is: " + Result.out)
			end
			update_indicator
		ensure
			valid: Result >= 0
		end

	update_indicator is
			-- Update indicator pixmap.
		local
			l_shared: SD_SHARED
		do
			create l_shared

			menu.internal_tail_tool_bar.disable_vertical_button_style
			if internal_hide_items.count > 0 then
				menu.internal_tail_indicator.set_pixmap (l_shared.icons.menu_customize_indicator_with_hidden_items)
			else
				menu.internal_tail_indicator.set_pixmap (l_shared.icons.menu_customize_indicator)
			end
		end

	on_tail_indicator_selected is
			-- Handle tail indicator selected event.
		local
			l_dialog: SD_HIDE_MENU_ITEM_DIALOG
			l_all_hiden_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
			l_menus: DS_ARRAYED_LIST [SD_MENU_ZONE]
			l_helper: SD_POSITION_HELPER
		do
			create l_all_hiden_items.make (1)
			if hide_menu_items.count > 0 then
				-- Prepare all hiden items in Current row.
				l_menus := menu.row.menu_zones
				from
					l_menus.start
				until
					l_menus.after
				loop
					l_all_hiden_items.append (l_menus.item_for_iteration.sizer.hide_menu_items)
					l_menus.forth
				end
			end

			create l_dialog.make (l_all_hiden_items)
			create l_helper.make
			l_helper.set_dialog_position (l_dialog, menu.tail_indicator_position.x, menu.tail_indicator_position.y)
			l_dialog.show_relative_to_window (menu.internal_docking_manager.main_window)

		end

feature -- Commands for position menu items

	position_groups (a_groups_info: SD_MENU_GROUP_INFO) is
			-- Position menu items by a_group_info.
		require
			not_void: a_groups_info /= Void
			is_horizontal: not menu.is_vertical
			is_floating: menu.is_floating
		local
			l_env: EV_ENVIRONMENT
		do
			create l_env
			if l_env.application.idle_actions.has (last_resize) then
				l_env.application.idle_actions.start
				l_env.application.idle_actions.prune (last_resize)
			end
			last_resize := agent position_groups_imp (a_groups_info)
			l_env.application.idle_actions.extend_kamikaze (last_resize)
		end

	last_resize: PROCEDURE [SD_MENU_ZONE_ASSISTANT, TUPLE]

	extend_items_by_sub_info (a_sub_info: SD_MENU_GROUP_INFO; a_goup_index: INTEGER) is
			-- Extend menu items by a_sub_info.
		require
			not_void: a_sub_info /= Void
			valid: a_goup_index > 0 and a_goup_index <= menu.content.group_count
		local
			l_items: ARRAYED_LIST [INTEGER]
			l_group: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
			l_need_separator: BOOLEAN
			l_temp_row: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
		do
			from
				a_sub_info.start
				l_need_separator := True
				l_group := menu.content.group (a_goup_index)
			until
				a_sub_info.after
			loop
				from
					l_items := a_sub_info.item
					create l_temp_row.make (1)
					l_items.start
				until
					l_items.after
				loop
					l_temp_row.extend (l_group.i_th (l_items.item))
					l_items.forth
				end
				menu.floating_menu.extend_one_new_row (l_temp_row, True, l_need_separator)
				l_need_separator := False
				a_sub_info.forth
			end
		end

feature -- Query

	hide_menu_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM] is
			-- `internal_hide_items'
		do
			prune_all_parent (internal_hide_items)
			Result := internal_hide_items.twin
		ensure
			is_all_parent_void: is_all_parent_void (Result)
		end

	is_all_parent_void (a_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]): BOOLEAN is
			-- Is all items in a_items parent void?
		do
			Result := True
			from
				a_items.start
			until
				a_items.after or not Result
			loop
				Result := a_items.item.parent = Void
				a_items.forth
			end
		end

	groups: ARRAYED_LIST [ARRAYED_LIST [EV_TOOL_BAR_ITEM]] is
			-- Groups in `menu'.
		local
			l_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
			l_separator: EV_TOOL_BAR_SEPARATOR
			l_group: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
		do
			l_items := menu.content.menu_items
			from
				create Result.make (1)
				create l_group.make (1)
				Result.extend (l_group)
				l_items.start
			until
				l_items.after
			loop
				l_separator ?= l_items
				if l_separator /= Void then
					create l_group.make (1)
					Result.extend (l_group)
				else
					l_group.extend (l_items.item)
				end
				l_items.forth
			end
		ensure
			not_void: Result /= Void
		end

	menu: SD_MENU_ZONE
			-- Menu which size issues Current managed.

feature {NONE} -- Implementation

	position_groups_imp (a_groups_info: SD_MENU_GROUP_INFO) is
			-- Position menu items by a_group_info.
		require
			not_void: a_groups_info /= Void
			is_horizontal: not menu.is_vertical
			is_floating: menu.is_floating
		local
			l_row: ARRAYED_LIST [INTEGER]
			l_new_row: BOOLEAN
			l_item: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
		do
			menu.floating_menu.lock_update
			menu.floating_menu.wipe_out

			menu.content.prune_items_from_parent

			from
				a_groups_info.start
			until
				a_groups_info.after
			loop
				if not a_groups_info.has_sub_info then
					from
						l_new_row := True
						l_row := a_groups_info.item
						l_row.start
					until
						l_row.after
					loop
						l_item := menu.content.group (l_row.item)
						menu.floating_menu.extend_one_new_row (l_item, l_new_row, a_groups_info.is_new_group)
						l_row.forth
						l_new_row := False
					end
				else
					extend_items_by_sub_info (a_groups_info.sub_grouping.item (a_groups_info.index), a_groups_info.index)
				end

				a_groups_info.forth
			end

			menu.floating_menu.to_minmum_size
			menu.floating_menu.unlock_update
		end

	groups_sizes: ARRAYED_LIST [INTEGER] is
			-- Group sizes.
		local
			l_groups: ARRAYED_LIST [ARRAYED_LIST [EV_TOOL_BAR_ITEM]]
			l_group: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
			l_size: INTEGER
		do
			create Result.make (1)
			l_groups := groups
			from
				l_groups.start
			until
				l_groups.after
			loop
				l_group := l_groups.item
				from
					l_group.start
					l_size := 0
				until
					l_group.after
				loop
					l_size := l_size + menu.content.size_of (l_group.item, menu.is_vertical)
					l_group.forth
				end
				Result.extend (l_size)
				l_groups.forth
			end
		end

	prune_all_parent (a_list: ARRAYED_LIST [EV_TOOL_BAR_ITEM]) is
			-- Parent all parent in a_list.
		do
			from
				a_list.start
			until
				a_list.after
			loop
				if a_list.item.parent /= Void then
					a_list.item.parent.prune (a_list.item)
				end
				a_list.forth
			end
		end

	internal_hide_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
			-- Hide menu items.

invariant

	not_void: menu /= Void

end
