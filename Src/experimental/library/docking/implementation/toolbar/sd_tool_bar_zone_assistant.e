note
	description: "Assistants that manage a SD_TOOL_BAR_ZONE size and position issues."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_ZONE_ASSISTANT

inherit
	SD_ACCESS

create
	make

feature {NONE} -- Initlization

	make
			-- Creation method
		do
			create internal_hidden_items.make (1)
			create last_state.make
		end

feature -- Command

	set_tool_bar_zone (a_tool_bar_zone: SD_TOOL_BAR_ZONE)
			-- Set `zone' with `a_tool_bar_zone'
		require
			not_void: a_tool_bar_zone /= Void
		do
			zone := a_tool_bar_zone
		ensure
			set: zone = a_tool_bar_zone
		end

	reduce_size (a_size: INTEGER): INTEGER
			-- Reduce `a_size', `Result' is how many size actually reduced
		require
			valid: a_size >= 0
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_item: SD_TOOL_BAR_ITEM
		do
			l_items := attached_zone.content.items_visible
			from
				l_items.finish
			until
				-- At least show one button
				l_items.index <= 1 or Result >= a_size
			loop
				l_item := l_items.item
				if attached_zone.has (l_item) then
					internal_hidden_items.extend (l_item)
					if not attached_zone.is_vertical then
						Result := Result + l_item.width
					else
						Result := Result + l_item.rectangle.height
					end
					attached_zone.prune (l_item)

					if attached {SD_TOOL_BAR_SEPARATOR} l_items.i_th (l_items.index - 1) as l_separator then
						check has: attached_zone.has (l_separator) end
						internal_hidden_items.extend (l_separator)
						Result := Result + l_separator.width
						attached_zone.prune (l_separator)
					end
				end
				l_items.back
			end

			update_indicator
			attached_zone.compute_minmum_size
		end

	expand_size (a_size_to_expand: INTEGER): INTEGER
			-- Expand `internal_tool_bar' a_size_to_expand, Result is actually size expanded
		require
			valid: a_size_to_expand >= 0
		local
			l_snapshot: like internal_hidden_items
			l_snapshot_item: SD_TOOL_BAR_ITEM
			l_old_size: INTEGER
			l_stop: BOOLEAN
			l_last_result: INTEGER
			l_item_after: detachable SD_TOOL_BAR_ITEM
		do
			if internal_hidden_items.count /= 0 then
				from
					l_old_size := attached_zone.size
					l_snapshot := internal_hidden_items.twin
					l_snapshot.finish
				until
					l_snapshot.before or l_stop
				loop
					l_snapshot_item := l_snapshot.item
					l_item_after := Void
					set_item_wrap (l_snapshot_item)
					attached_zone.extend_one_item (l_snapshot_item)
					if attached {SD_TOOL_BAR_SEPARATOR} l_snapshot_item as l_separator then
						-- We should extend item after separator
						if internal_hidden_items.index_of (l_separator, 1) > 1 then
							l_item_after := internal_hidden_items.i_th (internal_hidden_items.index_of (l_separator, 1) - 1)
							set_item_wrap (l_item_after)
							attached_zone.extend_one_item (l_item_after)
						end
					end
					l_last_result := Result
					if not attached_zone.is_vertical then
						Result := Result + l_snapshot_item.width
						if l_item_after /= Void then
							Result := Result + l_item_after.width
						end
					else
						Result := Result + l_snapshot_item.rectangle.height
						if l_item_after /= Void then
							Result := Result + l_item_after.rectangle.height
						end
					end

					if Result > a_size_to_expand then
						-- We should rollback one item and stop
						l_stop := True
						attached_zone.prune (l_snapshot_item)
						if l_item_after /= Void then
							attached_zone.prune (l_item_after)
						end
						Result := l_last_result
					else
						internal_hidden_items.prune_all (l_snapshot_item)
						if l_item_after /= Void then
							internal_hidden_items.prune_all (l_item_after)
						end
					end
					l_snapshot.back
					if attached {SD_TOOL_BAR_SEPARATOR} l_snapshot_item then
						l_snapshot.back
					end
				end
			end
			update_indicator
			set_item_wrap_before_separator
			attached_zone.compute_minmum_size
		ensure
			valid: 0 <= Result and Result <= a_size_to_expand
		end

	update_indicator
			-- Update indicator pixmap
		local
			l_shared: SD_SHARED
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_tail_indicator: SD_TOOL_BAR_NARROW_BUTTON
		do
			if attached_zone.is_floating then
				attached_zone.prune (attached_zone.tail_indicator)
			else
				if attached_zone.has (attached_zone.tail_indicator) then
					create l_shared
					l_tail_indicator := attached_zone.tail_indicator
					if internal_hidden_items.count > 0 then
						if not attached_zone.is_vertical then
							l_tail_indicator.set_pixmap (l_shared.icons.tool_bar_customize_indicator_with_hidden_items)
							l_tail_indicator.set_pixel_buffer (l_shared.icons.tool_bar_customize_indicator_with_hidden_items_buffer)
						else
							l_tail_indicator.set_pixmap (l_shared.icons.tool_bar_customize_indicator_with_hidden_items_horizontal)
							l_tail_indicator.set_pixel_buffer (l_shared.icons.tool_bar_customize_indicator_with_hidden_items_horizontal_buffer)
						end
					else
						if not attached_zone.is_vertical then
							l_tail_indicator.set_pixmap (l_shared.icons.tool_bar_customize_indicator)
							l_tail_indicator.set_pixel_buffer (l_shared.icons.tool_bar_customize_indicator_buffer)
						else
							l_tail_indicator.set_pixmap (l_shared.icons.tool_bar_customize_indicator_horizontal)
							l_tail_indicator.set_pixel_buffer (l_shared.icons.tool_bar_customize_indicator_horizontal_buffer)
						end
					end
					l_items := attached_zone.tool_bar.items
					if l_items.last  /= l_tail_indicator then
						attached_zone.tool_bar.prune (l_tail_indicator)
--						l_items.prune_all (l_tail_indicator)
						attached_zone.tool_bar.extend (l_tail_indicator)
--						l_items.extend (l_tail_indicator)
					end
					if l_items.count > 1 then
						if attached_zone.is_vertical and not l_items.i_th (l_items.count - 1).is_wrap then
							l_items.i_th (l_items.count - 1).set_wrap (True)
						end
						if not attached_zone.is_vertical and l_items.i_th (l_items.count - 1).is_wrap then
							l_items.i_th (l_items.count - 1).set_wrap (False)
						end
					end
				end
			end
		end

	on_tail_indicator_selected
			-- Handle tail indicator selected event
		local
			l_dialog: SD_TOOL_BAR_HIDDEN_ITEM_DIALOG
			l_all_hiden_items: detachable ARRAYED_LIST [SD_TOOL_BAR_ITEM]

			l_helper: SD_POSITION_HELPER
			l_indicator_size: INTEGER

		do
			if attached attached_zone.row as l_row then
				l_all_hiden_items := l_row.hidden_items
			else
				check False end -- Implied by end user is pressing on tool bar tail indicator, so tool bar is displayed on screen
			end
			check l_all_hiden_items /= Void end -- Implied by previous if clause
			create l_dialog.make (l_all_hiden_items, attached_zone)
			create l_helper.make
			if attached_zone.is_vertical then
				l_indicator_size := attached_zone.tail_indicator.rectangle.height
			else
				l_indicator_size := attached_zone.tail_indicator.width
			end
			if not attached_zone.is_vertical then
				l_helper.set_tool_bar_hidden_dialog_position (l_dialog, attached_zone.hidden_dialog_position.x, attached_zone.hidden_dialog_position.y, attached_zone.tail_indicator.width)
			else
				l_helper.set_tool_bar_hidden_dialog_vertical_position (l_dialog, attached_zone.hidden_dialog_position.x, attached_zone.hidden_dialog_position.y, attached_zone.tail_indicator.rectangle.height)
			end

			l_dialog.show
		end

	dock_last_state
			-- Dock to `last_state'
		require
			is_floating: attached_zone.is_floating
		do
			attached_zone.dock
			dock_last_state_for_hide
		ensure
			docked: not attached_zone.is_floating
		end

	dock_last_state_for_hide
			-- Dock to `last_state' for hidding
		local
			l_container: EV_BOX
			l_row: detachable SD_TOOL_BAR_ROW
		do
			l_container := attached_zone.docking_manager.tool_bar_manager.tool_bar_container (last_state.container_direction)
			if l_container.count < last_state.container_row_number or last_state.is_only_zone then
				-- The row it missing, we should create a new one
				-- Or the row last time is in the only one in row
				if last_state.container_direction = {SD_ENUMERATION}.top or last_state.container_direction = {SD_ENUMERATION}.bottom then
					create l_row.make (attached_zone.docking_manager, False)
				else
					check direction_valid: last_state.container_direction = {SD_ENUMERATION}.left or last_state.container_direction = {SD_ENUMERATION}.right end
					create l_row.make (attached_zone.docking_manager, True)
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
				-- Insert current zone to exsiting row
			end
			check not_void: l_row /= Void end

			if attached {EV_WIDGET} attached_zone.tool_bar as lt_widget then
				if attached_zone.row /= Void and then attached lt_widget.parent as l_parent then
					l_parent.prune (lt_widget)
				end

				l_row.extend (attached_zone)
				l_row.set_item_position_relative (lt_widget, last_state.position)
				attached_zone.docking_manager.command.resize (True)
			else
				check not_possible: False end
			end
		end

	record_docking_state
			-- Record docking state
		require
			is_docking: not attached_zone.is_floating
		local
			l_box: EV_BOX
			l_direction: INTEGER
		do
			last_state.set_position (attached_zone.position)
			last_state.set_size (attached_zone.size)
			l_direction := attached_zone.docking_manager.tool_bar_manager.container_direction (attached_zone)

			if not (create {SD_ENUMERATION}).is_direction_valid (l_direction) then
				-- Maybe `attached_zone' can't be found at the moment, don't know exactly why now, see bug#12611.
				-- We set top as default. Larry 5/10/2007
				l_direction := {SD_ENUMERATION}.top
			end
			last_state.set_container_direction (l_direction)

			l_box := attached_zone.docking_manager.tool_bar_manager.tool_bar_container (last_state.container_direction)
			if attached {EV_WIDGET} attached_zone.tool_bar as lt_widget then
				if attached {SD_TOOL_BAR_ROW} lt_widget.parent as l_parent then
					last_state.set_container_row_number (l_box.index_of (l_parent, 1))
					last_state.set_is_only_zone (l_parent.count = 1)
				else
					check False end -- Implied by tool bar existing in main window
				end
			else
				check not_possible: False end
			end
		end

	floating_last_state
			-- Float to `last_state'
		require
			is_docking: not attached_zone.is_floating
		local
			l_group_info: detachable SD_TOOL_BAR_GROUP_INFO
		do
			record_docking_state
			attached_zone.float (last_state.screen_x, last_state.screen_y, True)
			if last_state.floating_group_info /= Void then
				l_group_info := last_state.floating_group_info
				if l_group_info /= Void then
					attached_zone.attached_floating_tool_bar.assistant.position_groups (l_group_info)
				end
			end
		ensure
			is_floating: attached_zone.is_floating
		end

	open_items_layout
			-- Open items layout
		require
			not_void: last_state.items_layout /= Void
			not_void: attached_zone.content /= Void
		local
			l_item: detachable SD_TOOL_BAR_ITEM
			l_all_items: detachable ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_content_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_name: STRING_GENERAL
			l_data: detachable ARRAYED_LIST [TUPLE [name: STRING_GENERAL; displayed: BOOLEAN]]
			l_content: detachable SD_TOOL_BAR_CONTENT
			l_separator: SD_TOOL_BAR_SEPARATOR
		do
			l_data := last_state.items_layout
			if l_data /= Void then
				from
					create l_separator.make
					l_all_items :=  attached_zone.content.items.twin
					l_content := attached_zone.content
					l_content.wipe_out
					l_data.start
				until
					l_data.after
				loop
					l_name := l_data.item.name
					check not_void: l_name /= Void end
					if l_name.as_string_32.is_equal (l_separator.name.as_string_32) then
						-- First check if it's a separator
						l_content.items.extend (l_separator)
						create l_separator.make
					else
						from
							l_item := Void
							l_all_items.start
						until
							l_all_items.after or l_item /= Void
						loop
							check is_items_name_unique (l_name) end
							if l_all_items.item.name.as_string_32.is_equal (l_name.as_string_32) then
								l_item := l_all_items.item
								if not l_data.item.displayed then
									l_item.disable_displayed
								else
									l_item.enable_displayed
								end
							end
							l_all_items.forth
						end
						if l_item /= Void then
								-- l_item may be void in the case of changing tools, which
								-- affects the layout.
							l_content.items.extend (l_item)
						end
					end
					l_data.forth
				end
			end
			-- After restored items data, content items should not less than original state items' count (state before calling this feature)
			-- See bug#13972
			-- SD_TOOL_BAR_SEPARATOR is ignored
			from
				check l_content /= Void end -- Implied by previous loop
				l_content_items := l_content.items
				check l_all_items /= Void end -- Implied by previous loop
				l_all_items.start
			until
				l_all_items.after
			loop
				l_item := l_all_items.item

				if (not l_content_items.has (l_item)) and (not (attached {SD_TOOL_BAR_SEPARATOR} l_item)) then
					l_item.disable_displayed
					l_content_items.extend (l_item)
				end
				l_all_items.forth
			end
			-- Maybe we should check items count (ignore separator) should equal original items count

			refresh_items_visible
		end

	save_items_layout (a_items: detachable ARRAYED_LIST [SD_TOOL_BAR_ITEM])
			-- Save items layout
			-- (export status {NONE})
		local
			l_data: ARRAYED_LIST [TUPLE [name: STRING_GENERAL; displayed: BOOLEAN]]
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			from
				if a_items /= Void then
					l_items := a_items
				else
					l_items := attached_zone.content.items
				end
				create l_data.make (l_items.count)
				l_items.start
			until
				l_items.after
			loop
				l_data.extend ([l_items.item.name, l_items.item.is_displayed])
				l_items.forth
			end
			last_state.set_items_layout (l_data)
		ensure
			saved: last_state.items_layout /= Void
		end

	refresh_items_visible
			-- Refresh items visible states
		local
			l_content: SD_TOOL_BAR_CONTENT
		do
			l_content := attached_zone.content
			attached_zone.wipe_out
			l_content.clear
			attached_zone.extend (l_content)
			update_indicator
			if attached_zone.row /= Void then
				attached_zone.docking_manager.command.resize (True)
			end
			if attached_zone.is_floating then
				attached_zone.attached_floating_tool_bar.regroup_after_customize
			end
		end

feature {SD_OPEN_CONFIG_MEDIATOR} -- Special setting.

	set_last_state (a_last_data: SD_TOOL_BAR_ZONE_STATE)
			-- Set `last_data'
		require
			not_void: a_last_data /= Void
		do
			last_state := a_last_data
		ensure
			set: last_state = a_last_data
		end

feature -- Query

	can_reduce_size (a_size: INTEGER): INTEGER
			-- How many size can reduce, same as `reduce_size' but not really prune items
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_item: SD_TOOL_BAR_ITEM
		do
			l_items := attached_zone.content.items_visible
			from
				l_items.finish
			until
				-- At least show one button
				l_items.index <= 1 or Result >= a_size
			loop
				l_item := l_items.item
				if attached_zone.has (l_item) then
					if not attached_zone.is_vertical then
						Result := Result + l_item.width
					else
						Result := Result + l_item.rectangle.height
					end
					if attached {SD_TOOL_BAR_SEPARATOR} l_items.i_th (l_items.index - 1) as l_separator then
						check has: attached_zone.has (l_separator) end
						Result := Result + l_separator.width
					end
				end
				l_items.back
			end
		end

	can_expand_size (a_size_to_expand: INTEGER): INTEGER
			-- How many size can actually expanded
		require
			valid: a_size_to_expand >= 0
		local
			l_snapshot: like internal_hidden_items
			l_snapshot_item: SD_TOOL_BAR_ITEM
			l_old_size: INTEGER
			l_stop: BOOLEAN
			l_last_result: INTEGER
			l_item_after: detachable SD_TOOL_BAR_ITEM
		do
			if internal_hidden_items.count /= 0 then
				from
					l_old_size := attached_zone.size
					l_snapshot := internal_hidden_items.twin
					l_snapshot.finish
				until
					l_snapshot.before or l_stop
				loop
					l_snapshot_item := l_snapshot.item

					l_item_after := Void
					if attached {SD_TOOL_BAR_SEPARATOR} l_snapshot_item as l_separator then
						-- We should extend item after separator
						l_item_after := internal_hidden_items.i_th (internal_hidden_items.index_of (l_separator, 1) - 1)
					end
					l_last_result := Result
					if not attached_zone.is_vertical then
						Result := Result + l_snapshot_item.width
						if l_item_after /= Void then
							Result := Result + l_item_after.width
						end
					else
--						Result := Result + l_snapshot_item.rectangle.height
						Result := Result + attached_zone.tool_bar.row_height
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
					if attached {SD_TOOL_BAR_SEPARATOR} l_snapshot_item then
						l_snapshot.back
					end
				end
			end
		ensure
			valid: 0 <= Result and Result <= a_size_to_expand
		end

	hide_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- `internal_hidden_items'
		do
			Result := internal_hidden_items.twin
		end

	groups: ARRAYED_LIST [ARRAYED_LIST [SD_TOOL_BAR_ITEM]]
			-- Groups in `internal_tool_bar'
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_group: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			l_items := attached_zone.content.items_visible
			from
				create Result.make (1)
				create l_group.make (1)
				Result.extend (l_group)
				l_items.start
			until
				l_items.after
			loop
				if attached {SD_TOOL_BAR_SEPARATOR} l_items.item then
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

	zone: detachable SD_TOOL_BAR_ZONE
			-- Tool bar which size issues Current managed

	attached_zone: attached like zone
			-- Attached `zone'
		require
			set: zone /= Void
		local
			l_result: like zone
		do
			l_result := zone
			check l_result /= Void end -- Implied by precondition
			Result := l_result
		ensure
			set: Result /= Void
		end

	last_state: SD_TOOL_BAR_ZONE_STATE
			-- Last tool bar docking state

	is_items_name_unique (a_name: STRING_GENERAL): BOOLEAN
			-- If all items' name in `a_items' unique?
		require
			not_void: a_name /= Void and then not a_name.is_empty
			not_void: zone /= Void
		local
			l_items: LIST [SD_TOOL_BAR_ITEM]
		do
			from
				Result := True
				l_items := attached_zone.content.items.twin
				l_items.start
			until
				l_items.after
			loop
				Result := not (l_items.item.name ~ a_name.as_string_32)

				l_items.forth
			end
		end

feature {NONE} -- Implementation

	set_item_wrap (a_item: SD_TOOL_BAR_ITEM)
			-- Set `a_item' wrap state
		require
			not_void: a_item /= Void
		do
			a_item.set_wrap (attached_zone.is_vertical)
		end

	set_item_wrap_before_separator
			-- When `zone' is_vertical, we should set item before separator not wrap
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_separator: detachable SD_TOOL_BAR_SEPARATOR
			l_last_item: detachable SD_TOOL_BAR_ITEM
		do
			if attached_zone.is_vertical then
				l_items := attached_zone.tool_bar.items
				from
					l_items.start
				until
					l_items.after
				loop
					l_separator ?= l_items.item
					if l_separator /= Void and then l_last_item /= Void then
						l_last_item.set_wrap (False)
					end
					l_last_item := l_items.item
					l_items.forth
				end
			end
		end

	groups_sizes: ARRAYED_LIST [INTEGER]
			-- Group sizes
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
			-- Hide tool_bar items

invariant
	not_void: last_state /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
