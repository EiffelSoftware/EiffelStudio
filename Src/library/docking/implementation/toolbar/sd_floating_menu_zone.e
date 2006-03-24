indexing
	description: "A dialog hold SD_TOOL_BAR_ZONE when it floating."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FLOATING_TOOL_BAR_ZONE

inherit
	EV_UNTITLED_DIALOG
		rename
			show as show_allow_to_back,
			extend as extend_to_dialog,
			has as has_dialog,
			wipe_out as wipe_out_dialog
		export
			{NONE} all
			{ANY} destroy, screen_x, screen_y, has_recursive, prune, set_position, set_size
			{ANY} lock_update, unlock_update
			{SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT} minimum_width, minimum_height, resize_actions
			{SD_TOOL_BAR_MANAGER} hide
		end
create
	make

feature {NONE} -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		local
			l_pixmaps: EV_STOCK_PIXMAPS
		do
			default_create
			internal_docking_manager := a_docking_manager
			create internal_shared
			disable_user_resize

			init_border_box

			create l_pixmaps
			create internal_padding_box
			internal_padding_box.set_border_width (1)
			internal_padding_box.set_padding_width (1)
			internal_padding_box.set_pointer_style (l_pixmaps.standard_cursor)
			internal_border_box.extend (internal_padding_box)

			create internal_title_bar
			internal_title_bar.pointer_double_press_actions.extend (agent recover_docking_state)
			internal_title_bar.close_request_actions.extend (agent on_close_request)
			internal_title_bar.custom_actions.extend (agent on_customize)
			internal_padding_box.extend (internal_title_bar)
			internal_padding_box.disable_item_expand (internal_title_bar)

			last_group_count := 1

		ensure
			set: internal_docking_manager = a_docking_manager
		end

	init_border_box is
			-- Initialize `internal_border_box'.
		do
			create {EV_VERTICAL_BOX} internal_border_box
			internal_border_box.set_border_width (internal_border_width)
			internal_border_box.set_background_color (internal_shared.tool_bar_title_bar_color)
			extend_to_dialog (internal_border_box)
			internal_border_box.pointer_motion_actions.extend (agent on_border_box_pointer_motion)
			internal_border_box.pointer_button_press_actions.extend (agent on_border_pointer_press)
			internal_border_box.pointer_button_release_actions.extend (agent on_border_pointer_release)
		end

feature -- Command

	show is
			-- Show `Current'.
		do
			if internal_shared.allow_window_to_back then
				show_allow_to_back
			else
				show_relative_to_window (internal_docking_manager.main_window)
			end
		ensure
			shown: is_displayed
		end

	extend (a_tool_bar_zone: SD_TOOL_BAR_ZONE) is
			-- Extend `a_tool_bar_zone'.
		require
			a_tool_bar_zone_not_void: a_tool_bar_zone /= Void
			a_tool_bar_zone_horizontal: not a_tool_bar_zone.is_vertical
			a_tool_bar_zone_parent_void: a_tool_bar_zone.parent = Void
			not_extended: content = Void
		do
			zone := a_tool_bar_zone
			tool_bar := a_tool_bar_zone
			internal_padding_box.extend (a_tool_bar_zone)
			content := a_tool_bar_zone.content

			internal_title_bar.set_content (content)

			internal_title_bar.drawing_area.pointer_button_press_actions.extend (agent (a_tool_bar_zone.agents).on_drag_area_pressed)
			internal_title_bar.drawing_area.pointer_button_release_actions.extend (agent (a_tool_bar_zone.agents).on_drag_area_release)
			internal_title_bar.drawing_area.pointer_motion_actions.extend (agent (a_tool_bar_zone.agents).on_drag_area_motion)

			create group_divider.make_with_content (content)

			create assistant.make (Current)
		ensure
			set: content = a_tool_bar_zone.content
			set: zone = a_tool_bar_zone
		end

feature -- Query

	zone: SD_TOOL_BAR_ZONE
			-- Tool bar zone Current managed.

	has (a_tool_bar_zone: EV_WIDGET): BOOLEAN is
			-- Has a_tool_bar_zone?
		do
			Result := internal_padding_box.has (a_tool_bar_zone)
		end

	content: SD_TOOL_BAR_CONTENT
			-- Content which Current managed.

	assistant: SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT
			-- Assistant to position items.

	tool_bar: SD_TOOL_BAR
			-- SD_TOOL_BAR where contain SD_TOOL_BAR_ITEMs.

feature {NONE} -- Implementation of resize issues.

	on_border_box_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle border box pointer motion.
		local
			l_temp_group_count: INTEGER
			l_temp_group_info: SD_TOOL_BAR_GROUP_INFO
			l_pointer_offset: INTEGER
			l_old_position: INTEGER
		do
			if not internal_border_box.has_capture then
				on_border_pointer_motion_no_capture (a_x, a_y)
			else
				inspect
					internal_pointer_direction
				when {SD_DOCKING_MANAGER}.dock_left then
					l_old_position := screen_x + width
					l_pointer_offset := (screen_x + width) - a_screen_x
					if l_pointer_offset > 0 then
						l_temp_group_info := group_divider.best_grouping_by_width (l_pointer_offset)
						l_temp_group_count := group_divider.last_group_index
						if l_temp_group_count /= last_group_count then
							lock_update
							assistant.position_groups (l_temp_group_info)
							last_group_count := group_divider.last_group_index
							set_x_position (l_old_position - width)
							unlock_update
						end
					end
				when {SD_DOCKING_MANAGER}.dock_right then
					if a_screen_x - screen_x > 0 then
						l_temp_group_info := group_divider.best_grouping_by_width (a_screen_x - screen_x)
						l_temp_group_count := group_divider.last_group_index
						if l_temp_group_count /= last_group_count then
							assistant.position_groups (l_temp_group_info)
							last_group_count := group_divider.last_group_index
						end
					end
				when {SD_DOCKING_MANAGER}.dock_top then
					l_old_position := screen_y + height
					l_pointer_offset := screen_y + height - a_screen_y - (tool_bar.screen_y - screen_y)
					if l_pointer_offset > 0  then
						l_temp_group_count := group_count_by_height (l_pointer_offset)
						if l_temp_group_count /= last_group_count and l_temp_group_count <= group_divider.max_row_count then
							lock_update
							assistant.position_groups (group_divider.best_grouping (l_temp_group_count))
							last_group_count := l_temp_group_count
							set_y_position (l_old_position - height)
							unlock_update
						end
					end
				when {SD_DOCKING_MANAGER}.dock_bottom then
					l_pointer_offset := a_screen_y - tool_bar.screen_y
					if l_pointer_offset > 0 then
						l_temp_group_count := group_count_by_height (l_pointer_offset)
						if l_temp_group_count /= last_group_count and l_temp_group_count <= group_divider.max_row_count then
							assistant.position_groups (group_divider.best_grouping (l_temp_group_count))
							last_group_count := l_temp_group_count
						end
					end
				end
			end
		end

	group_count_by_height (a_pointer_height: INTEGER): INTEGER is
			-- Group count base on `a_pointer_height'.
		require
			valid: a_pointer_height > 0
		local
			l_total_height_without_subgroup: INTEGER
			l_temp_height: INTEGER
		do
			l_total_height_without_subgroup := zone.content.group_count * tool_bar.row_height + (zone.content.group_count - 1) * {SD_TOOL_BAR_SEPARATOR}.width
			if a_pointer_height <= l_total_height_without_subgroup then
				Result := a_pointer_height // (tool_bar.row_height + {SD_TOOL_BAR_SEPARATOR}.width) + 1
			else
				l_temp_height := a_pointer_height - (zone.content.group_count - 1) * {SD_TOOL_BAR_SEPARATOR}.width
				check valid: l_temp_height > 0 end
				Result := l_temp_height // tool_bar.row_height + 1
			end

			if Result > content.item_count_except_separator then
				Result := content.item_count_except_separator
			elseif Result = 0 then
				Result := 1
			end
		ensure
			valid: 0 < Result and Result <= content.item_count_except_separator
		end

	last_group_count: INTEGER
			-- Group index for last pointer motion.

	on_border_pointer_motion_no_capture (a_x, a_y: INTEGER) is
			-- Handle pointer motion actions when not has capture.
		require
			not_capture: not internal_border_box.has_capture
		local
			l_styles: EV_STOCK_PIXMAPS
		do
			create l_styles
			if 0 <= a_x and a_x <= internal_border_width then
				internal_pointer_direction := {SD_DOCKING_MANAGER}.dock_left
			elseif (internal_border_box.width - internal_border_width) <= a_x and a_x <= internal_border_box.width then
				internal_pointer_direction := {SD_DOCKING_MANAGER}.dock_right
			elseif 0 <= a_y and a_y <= internal_border_width then
				internal_pointer_direction := {SD_DOCKING_MANAGER}.dock_top
			else
				internal_pointer_direction := {SD_DOCKING_MANAGER}.dock_bottom
			end
			if internal_pointer_direction = {SD_DOCKING_MANAGER}.dock_left or internal_pointer_direction = {SD_DOCKING_MANAGER}.dock_right then
				internal_border_box.set_pointer_style (l_styles.sizewe_cursor)
			else
				internal_border_box.set_pointer_style (l_styles.sizens_cursor)
			end
		end

	on_border_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer press actions.
		do
			if a_button = 1 then
				internal_border_box.enable_capture
			end
		end

	on_border_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release actions.
		do
			if internal_border_box.has_capture then
				internal_border_box.disable_capture
			end
		end

	internal_pointer_direction: INTEGER
			-- Pointer direction, one value of SD_DOCKING_MANAGER dock_top, dock_bottom, dock_left, dock_right.
			-- Used when user dragging Current border.

feature {SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT, SD_TOOL_BAR_DRAGGING_AGENTS} -- Implementation

	recover_docking_state is
			-- Recover to orignal docking state.
		do
			-- First we record floating states.
			-- SD_TOOL_BAR_GROUP_INFO is already recorded when grouping.
			zone.assistant.last_state.set_screen_x (screen_x)
			zone.assistant.last_state.set_screen_y (screen_y)

			zone.assistant.dock_last_state
		end

	group_divider: SD_TOOL_BAR_GROUP_DIVIDER
			-- Divider to divide tool bar groups.

	internal_title_bar: SD_TOOL_BAR_TITLE_BAR
			-- Title bar

	internal_border_box: EV_BOX
			-- Border box surround target tool bar.

	internal_padding_box: EV_VERTICAL_BOX
			-- Box to show padding.

	internal_border_width: INTEGER is 2
			-- Border width.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

	internal_shared: SD_SHARED
			-- All singletons.

feature {NONE} -- Implementation

	on_close_request is
			-- Handle close request actions.
		do
			content.close_request_actions.call ([])
		end

	on_customize is
			-- Handle customize actions.
		local
			l_dialog: SD_TOOL_BAR_HIDDEN_ITEM_DIALOG
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_helper: SD_POSITION_HELPER
			l_rect: EV_RECTANGLE
		do
			create l_items.make (1)
			create l_dialog.make (l_items, zone)
			create l_helper.make
			l_rect := internal_title_bar.custom_rectangle
			l_helper.set_tool_bar_floating_dialog_position (l_dialog, l_rect.x, l_rect.y, l_rect.width, l_rect.height)
			l_dialog.show_relative_to_window (Current)
		end

invariant

	not_void: internal_shared /= Void
	not_void: internal_title_bar /= Void

indexing
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
