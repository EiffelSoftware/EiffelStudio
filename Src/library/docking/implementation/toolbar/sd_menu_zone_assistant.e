indexing
	description: "Assistants that manage a SD_TOOL_BAR_ZONE size and position issues."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_ZONE_ASSISTANT

create
	make

feature {NONE} -- Initlization

	make (a_tool_bar_zone: SD_TOOL_BAR_ZONE) is
			-- Creation method
		require
			not_void: a_tool_bar_zone /= Void
		do
			tool_bar := a_tool_bar_zone
			create internal_hidden_items.make (1)
			create last_state.make
		ensure
			set: tool_bar = a_tool_bar_zone
		end

feature -- Command

	reduce_size (a_size: INTEGER): INTEGER is
			-- Reduce `a_size', `Result' is how many size actually reduced.
		require
			valid: a_size >= 0
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_separator: SD_TOOL_BAR_SEPARATOR
		do
			l_items := tool_bar.content.items
			from
				l_items.finish
			until
				-- At least show one button.
				l_items.index <= 1 or Result >= a_size
			loop
				if tool_bar.has (l_items.item) then
					internal_hidden_items.extend (l_items.item)
					if not tool_bar.is_vertical then
						Result := Result + l_items.item.width
					else
						Result := Result + l_items.item.rectangle.height
					end
					tool_bar.prune (l_items.item)

					l_separator := Void
					l_separator ?= l_items.i_th (l_items.index - 1)
					if l_separator /= Void then
						check has: tool_bar.has (l_separator) end
						internal_hidden_items.extend (l_separator)
						Result := Result + l_separator.width
						tool_bar.prune (l_separator)
					end
				end
				l_items.back
			end

			update_indicator
			tool_bar.compute_minmum_size
		end

	expand_size (a_size_to_expand: INTEGER): INTEGER is
			-- Expand `internal_tool_bar' a_size_to_expand, Result is actually size expanded.
		require
			valid: a_size_to_expand >= 0
		local
			l_snapshot: like internal_hidden_items
			l_old_size: INTEGER
			l_stop: BOOLEAN
			l_last_result: INTEGER
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_item_after: SD_TOOL_BAR_ITEM
		do
			if internal_hidden_items.count /= 0 then
				from
					l_old_size := tool_bar.size
					l_snapshot := internal_hidden_items.twin
					l_snapshot.finish
				until
					l_snapshot.before or l_stop
				loop
					l_separator := Void
					l_item_after := Void
					l_separator ?= l_snapshot.item
					set_item_wrap (l_snapshot.item)
					tool_bar.extend_one_item (l_snapshot.item)
					if l_separator /= Void then
						-- We should extend item after separator.
						if internal_hidden_items.index_of (l_separator, 1) > 1 then
							l_item_after := internal_hidden_items.i_th (internal_hidden_items.index_of (l_separator, 1) - 1)
							set_item_wrap (l_item_after)
							tool_bar.extend_one_item (l_item_after)
						end
					end
					l_last_result := Result
					if not tool_bar.is_vertical then
						Result := Result + l_snapshot.item.width
						if l_item_after /= Void then
							Result := Result + l_item_after.width
						end
					else
						Result := Result + l_snapshot.item.rectangle.height
						if l_item_after /= Void then
							Result := Result + l_item_after.rectangle.height
						end
					end

					if Result > a_size_to_expand then
						-- We should rollback one item and stop.
						l_stop := True
						tool_bar.prune (l_snapshot.item)
						if l_item_after /= Void then
							tool_bar.prune (l_item_after)
						end
						Result := l_last_result
					else
						internal_hidden_items.prune_all (l_snapshot.item)
						if l_item_after /= Void then
							internal_hidden_items.prune_all (l_item_after)
						end
					end
					l_snapshot.back
					if l_separator /= Void then
						l_snapshot.back
					end
				end
			end
			update_indicator
			set_item_wrap_before_separator
			tool_bar.compute_minmum_size
		ensure
			valid: 0 <= Result and Result <= a_size_to_expand
		end

	update_indicator is
			-- Update indicator pixmap.
		local
			l_shared: SD_SHARED
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			if tool_bar.has (tool_bar.tail_indicator) then
				create l_shared
				if internal_hidden_items.count > 0 then
					if not tool_bar.is_vertical then
						tool_bar.tail_indicator.set_pixmap (l_shared.icons.tool_bar_customize_indicator_with_hidden_items)
					else
						tool_bar.tail_indicator.set_pixmap (l_shared.icons.tool_bar_customize_indicator_with_hidden_items_horizontal)
					end
				else
					if not tool_bar.is_vertical then
						tool_bar.tail_indicator.set_pixmap (l_shared.icons.tool_bar_customize_indicator)
					else
						tool_bar.tail_indicator.set_pixmap (l_shared.icons.tool_bar_customize_indicator_horizontal)
					end
				end
				l_items := tool_bar.internal_items
				if l_items.last /= tool_bar.tail_indicator then
					l_items.prune_all (tool_bar.tail_indicator)
					l_items.extend (tool_bar.tail_indicator)
				end
				if l_items.count > 1 then
					if tool_bar.is_vertical and not l_items.i_th (l_items.count - 1).is_wrap then
						l_items.i_th (l_items.count - 1).set_wrap (True)
					end
					if not tool_bar.is_vertical and l_items.i_th (l_items.count - 1).is_wrap then
						l_items.i_th (l_items.count - 1).set_wrap (False)
					end
				end
			end
		end

	on_tail_indicator_selected is
			-- Handle tail indicator selected event.
		local
			l_dialog: SD_TOOL_BAR_HIDDEN_ITEM_DIALOG
			l_all_hiden_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_tool_bars: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_helper: SD_POSITION_HELPER
			l_indicator_size: INTEGER
		do
			create l_all_hiden_items.make (1)
			-- Prepare all hiden items in Current row.
			l_tool_bars := tool_bar.row.zones
			from
				l_tool_bars.start
			until
				l_tool_bars.after
			loop
				l_all_hiden_items.append (l_tool_bars.item_for_iteration.assistant.hide_tool_bar_items)
				l_tool_bars.forth
			end

			create l_dialog.make (l_all_hiden_items, tool_bar)
			create l_helper.make
			if tool_bar.is_vertical then
				l_indicator_size := tool_bar.tail_indicator.rectangle.height
			else
				l_indicator_size := tool_bar.tail_indicator.width
			end
			if not tool_bar.is_vertical then
				l_helper.set_tool_bar_hidden_dialog_position (l_dialog, tool_bar.hidden_dialog_position.x, tool_bar.hidden_dialog_position.y, tool_bar.tail_indicator.width)
			else
				l_helper.set_tool_bar_hidden_dialog_vertical_position (l_dialog, tool_bar.hidden_dialog_position.x, tool_bar.hidden_dialog_position.y, tool_bar.tail_indicator.rectangle.height)
			end

			l_dialog.show_relative_to_window (tool_bar.docking_manager.main_window)
		end

	dock_last_state is
			-- Dock to `last_state'.
		require
			is_floating: tool_bar.is_floating
		local
			l_container: EV_BOX
			l_row: SD_TOOL_BAR_ROW
		do
			tool_bar.dock

			l_container := tool_bar.docking_manager.tool_bar_manager.tool_bar_container (last_state.container_direction)
			if l_container.count < last_state.container_row_number or last_state.is_only_zone then
				-- The row it missing, we should create a new one.
				-- Or the row last time is in the only one in row.
				if last_state.container_direction = {SD_DOCKING_MANAGER}.dock_top or last_state.container_direction = {SD_DOCKING_MANAGER}.dock_bottom then
					create l_row.make (False)
				else
					check direction_valid: last_state.container_direction = {SD_DOCKING_MANAGER}.dock_left or last_state.container_direction = {SD_DOCKING_MANAGER}.dock_right end
					create l_row.make (True)
				end
				if l_container.count > last_state.container_row_number then
					l_container.go_i_th (last_state.container_row_number)
					l_container.put_left (l_row)
				else
					l_container.extend (l_row)
				end
			else
				l_row ?= l_container.i_th (last_state.container_row_number)
				check not_void: l_row /= Void end
				-- Insert current zone to exsiting row.
			end
			check not_void: l_row /= Void end

			l_row.extend (tool_bar)
			l_row.set_item_position_relative (tool_bar, last_state.position)
			tool_bar.docking_manager.command.resize (True)
		ensure
			docked: not tool_bar.is_floating
		end

	record_docking_state is
			-- Record docking state.
		require
			is_docking: not tool_bar.is_floating
		local
			l_box: EV_BOX
			l_parent: SD_TOOL_BAR_ROW
		do
			last_state.set_position (tool_bar.position)
			last_state.set_size (tool_bar.size)
			last_state.set_container_direction (tool_bar.docking_manager.tool_bar_manager.container_direction (tool_bar))

			l_box := tool_bar.docking_manager.tool_bar_manager.tool_bar_container (last_state.container_direction)
			l_parent ?= tool_bar.parent
			check not_void: l_parent /= Void end
			last_state.set_container_row_number (l_box.index_of (l_parent, 1))

			last_state.set_is_only_zone (l_box.count = 1)
		end

	floating_last_state is
			-- Float to `last_state'
		require
			is_docking: not tool_bar.is_floating
		do
			record_docking_state
			tool_bar.float (last_state.screen_x, last_state.screen_y)
			if last_state.floating_group_info /= Void then
				tool_bar.floating_tool_bar.assistant.position_groups (last_state.floating_group_info)
			end
		ensure
			is_floating: tool_bar.is_floating
		end

	open_items_layout is
			-- Open items layout.
		require
			not_void: last_state.items_layout /= Void
			not_void: tool_bar.content /= Void
		local
			l_item: SD_TOOL_BAR_ITEM
			l_all_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_name: STRING
			l_datas: ARRAYED_LIST [TUPLE [STRING, BOOLEAN]]
			l_content: SD_TOOL_BAR_CONTENT
			l_separator: SD_TOOL_BAR_SEPARATOR
		do
			from
				create l_separator.make
				l_all_items :=  tool_bar.content.items.twin
				l_content := tool_bar.content
				l_content.wipe_out
				l_datas := last_state.items_layout
				l_datas.start
			until
				l_datas.after
			loop
				l_name ?= l_datas.item @ 1
				check not_void: l_name /= Void end
				l_item := Void
				if l_name.is_equal (l_separator.name) then
					-- First check if it's a separator
					l_content.items.extend (l_separator)
					create l_separator.make
				else
					from
						l_all_items.start
					until
						l_all_items.after or l_item /= Void
					loop
						if l_all_items.item.name.is_equal (l_name) then
							l_item := l_all_items.item
							if not l_datas.item.boolean_item (2) then
								l_item.disable_displayed
							else
								l_item.enable_displayed
							end
						end
						l_all_items.forth
					end
					check must_fount: l_item /= Void end
					l_content.items.extend (l_item)
				end
				l_datas.forth
			end
			tool_bar.wipe_out
			tool_bar.extend (l_content)
		end

feature {SD_CONFIG_MEDIATOR} -- Special setting.

	set_last_state (a_last_data: SD_TOOL_BAR_ZONE_STATE) is
			-- Set `last_data'
		require
			not_void: a_last_data /= Void
		do
			last_state := a_last_data
		ensure
			set: last_state = a_last_data
		end

feature -- Query

	can_reduce_size (a_size: INTEGER): INTEGER is
			-- How many size can reduce, same as `reduce_size' but not really prune items.
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_separator: SD_TOOL_BAR_SEPARATOR
		do
			l_items := tool_bar.content.items
			from
				l_items.finish
			until
				-- At least show one button.
				l_items.index <= 1 or Result >= a_size
			loop
				if tool_bar.has (l_items.item) then
					if not tool_bar.is_vertical then
						Result := Result + l_items.item.width
					else
						Result := Result + l_items.item.rectangle.height
					end
					l_separator := Void
					l_separator ?= l_items.i_th (l_items.index - 1)
					if l_separator /= Void then
						check has: tool_bar.has (l_separator) end
						Result := Result + l_separator.width
					end
				end
				l_items.back
			end
		end

	can_expand_size (a_size_to_expand: INTEGER): INTEGER is
			-- How many size can actually expanded
		require
			valid: a_size_to_expand >= 0
		local
			l_snapshot: like internal_hidden_items
			l_old_size: INTEGER
			l_stop: BOOLEAN
			l_last_result: INTEGER
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_item_after: SD_TOOL_BAR_ITEM
		do
			if internal_hidden_items.count /= 0 then
				from
					l_old_size := tool_bar.size
					l_snapshot := internal_hidden_items.twin
					l_snapshot.finish
				until
					l_snapshot.before or l_stop
				loop
					l_separator := Void
					l_item_after := Void
					l_separator ?= l_snapshot.item
					if l_separator /= Void then
						-- We should extend item after separator.
						l_item_after := internal_hidden_items.i_th (internal_hidden_items.index_of (l_separator, 1) - 1)
					end
					l_last_result := Result
					if not tool_bar.is_vertical then
						Result := Result + l_snapshot.item.width
						if l_item_after /= Void then
							Result := Result + l_item_after.width
						end
					else
--						Result := Result + l_snapshot.item.rectangle.height
						Result := Result + tool_bar.row_height
						if l_item_after /= Void then
--							Result := Result + l_item_after.rectangle.height
							Result := Result + {SD_TOOL_BAR_SEPARATOR}.width
						end
					end
					if Result > a_size_to_expand then
						l_stop := True
						Result := l_last_result
					end
					l_snapshot.back
					if l_separator /= Void then
						l_snapshot.back
					end
				end
			end
		ensure
			valid: 0 <= Result and Result <= a_size_to_expand
		end

	hide_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM] is
			-- `internal_hidden_items'
		do
			Result := internal_hidden_items.twin
		end

	groups: ARRAYED_LIST [ARRAYED_LIST [SD_TOOL_BAR_ITEM]] is
			-- Groups in `internal_tool_bar'.
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_group: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			l_items := tool_bar.content.items
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

	tool_bar: SD_TOOL_BAR_ZONE
			-- Tool bar which size issues Current managed.

	last_state: SD_TOOL_BAR_ZONE_STATE
			-- Last tool bar docking state.

feature {NONE} -- Implementation

	set_item_wrap (a_item: SD_TOOL_BAR_ITEM) is
			-- Set `a_item' wrap state.
		require
			not_void: a_item /= Void
		do
			if tool_bar.is_vertical then
				a_item.set_wrap (True)
			else
				a_item.set_wrap (False)
			end
		end

	set_item_wrap_before_separator is
			-- When `tool_bar' is_vertical, we should set item before separator not wrap.
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_last_item: SD_TOOL_BAR_ITEM
		do
			if tool_bar.is_vertical then
				l_items := tool_bar.items
				from
					l_items.start
				until
					l_items.after
				loop
					l_separator ?= l_items.item
					if l_separator /= Void and then l_last_item/= Void then
						l_last_item.set_wrap (False)
					end
					l_last_item := l_items.item
					l_items.forth
				end
			end
		end

	groups_sizes: ARRAYED_LIST [INTEGER] is
			-- Group sizes.
		local
			l_groups: ARRAYED_LIST [ARRAYED_LIST [SD_TOOL_BAR_ITEM]]
			l_group: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
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
					l_size := l_size + l_group.item.width
					l_group.forth
				end
				Result.extend (l_size)
				l_groups.forth
			end
		end

	internal_hidden_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Hide tool_bar items.

invariant

	not_void: tool_bar /= Void
	not_void: last_state /= Void

end
