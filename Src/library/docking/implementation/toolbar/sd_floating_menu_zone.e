indexing
	description: "A dialog hold SD_MENU_ZONE when it floating."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FLOATING_MENU_ZONE

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
			internal_border_box.set_background_color (internal_shared.menu_title_bar_color)
			extend_to_dialog (internal_border_box)
			internal_border_box.pointer_motion_actions.extend (agent on_border_box_pointer_motion)
			internal_border_box.pointer_button_press_actions.extend (agent on_border_pointer_press)
			internal_border_box.pointer_button_release_actions.extend (agent on_border_pointer_release)
		end

	init_group_width is
			-- Initialize
		local
			l_count: INTEGER
		do
			create all_group_width.make (1)
			from
				l_count := 1
			until
				l_count > content.group_count
			loop
				all_group_width.extend (group_divider.maximum_group_width (l_count))
				l_count := l_count + 1
			end

			one_group_height := internal_menu_item_box.height
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

	extend (a_menu_zone: SD_MENU_ZONE) is
			-- Extend `a_menu_zone'.
		require
			a_menu_zone_not_void: a_menu_zone /= Void
			a_menu_zone_horizontal: not a_menu_zone.is_vertical
			a_menu_zone_parent_void: a_menu_zone.parent = Void
			not_extended: not extended
		do
			a_menu_zone.wipe_out
			-- We extend a_menu_zone only because we use it for enable_capture
			-- Actually when floating, all toolbar items is contain in Current, not in a_menu_zone.
			internal_border_box.extend (a_menu_zone)
			a_menu_zone.set_minimum_height (0)
			internal_border_box.disable_item_expand (a_menu_zone)
			zone := a_menu_zone
			-- FIXIT: How to get width of dialog border?
--			set_maximum_width (a_menu_zone.minimum_width + 8)
--			set_maximum_height (a_menu_zone.content.button_count_except_separator * a_menu_zone.height + 8)
			extended := True
			content := a_menu_zone.content
			extend_menu_items
			internal_title_bar.set_content (content)

			internal_title_bar.drawing_area.pointer_button_press_actions.extend (agent (a_menu_zone.internal_agents).on_drag_area_pressed)
			internal_title_bar.drawing_area.pointer_button_release_actions.extend (agent (a_menu_zone.internal_agents).on_drag_area_release)
			internal_title_bar.drawing_area.pointer_motion_actions.extend (agent (a_menu_zone.internal_agents).on_drag_area_motion)

			create group_divider.make_with_content (content)
			to_minmum_size

			init_group_width
		ensure
			extended: extended = True
			set: content = a_menu_zone.content
			set: zone = a_menu_zone
		end

	wipe_out is
			-- Wipe out all menu items.
		do
			internal_menu_box.wipe_out
		end

	to_minmum_size is
			-- To minmum size.
		do
			set_size (minimum_width, minimum_height)
		end

feature {SD_MENU_ZONE_ASSISTANT} -- Command for sizer

	extend_one_item (a_item: EV_TOOL_BAR_ITEM) is
			-- Extend one item
		require
			has: content.menu_items.has (a_item)
			parent_void: a_item.parent = Void
		local
			l_menu_bar: EV_TOOL_BAR
			l_item_index: INTEGER
		do
			create l_menu_bar
			l_item_index := content.menu_items.index_of (a_item, 1)
			if not content.menu_items_texts.i_th (l_item_index).is_equal ("") then
				l_menu_bar.disable_vertical_button_style
			end
			l_menu_bar.extend (a_item)
			internal_menu_item_box.extend (l_menu_bar)
			internal_menu_item_box.disable_item_expand (l_menu_bar)
		ensure
--			has: internal_menu_box.has_recursive (a_item)
		end

	extend_one_new_row (a_group: ARRAYED_LIST [EV_TOOL_BAR_ITEM]; a_new_row: BOOLEAN; a_need_separator: BOOLEAN) is
			-- Extend a_group.
		require
			not_void: a_group /= Void
			valid: a_group.count > 0 and a_group.count <= content.menu_items.count
			has:
		local
			l_new_row: BOOLEAN
			l_separator: EV_TOOL_BAR_SEPARATOR
			l_h_separator: EV_HORIZONTAL_SEPARATOR
			l_tool_bar: EV_TOOL_BAR
		do
			if not a_new_row then
				create l_separator
				create l_tool_bar
				l_tool_bar.extend (l_separator)
				internal_menu_item_box.extend (l_tool_bar)
			else
				if a_need_separator then
					create l_h_separator
					internal_menu_box.extend (l_h_separator)
				end
				create internal_menu_item_box
				internal_menu_box.extend (internal_menu_item_box)
			end
			from
				l_new_row := a_new_row
				a_group.start
			until
				a_group.after
			loop
				extend_one_item (a_group.item)
				l_new_row := False
				a_group.forth
			end
		end

feature -- Query

	extended: BOOLEAN
			-- If `Current' extended?

	zone: SD_MENU_ZONE
			-- Menu zone Current managed.

	has (a_menu_zone: EV_WIDGET): BOOLEAN is
			-- Has a_menu_zone?
		do
			Result := internal_padding_box.has (a_menu_zone)
		end

	content: SD_MENU_CONTENT
			-- Content which Current managed.

feature {NONE} -- Implementation of resize issues.

	on_border_box_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle border box pointer motion.
		local
			l_temp_group_count: INTEGER
		do
			if not internal_border_box.has_capture then
				on_border_pointer_motion_no_capture (a_x, a_y)
			else
				inspect
					internal_pointer_direction
				when {SD_DOCKING_MANAGER}.dock_left then
--					if (screen_x + width) - a_screen_x > minimum_width then
--						if group_divider.group_count /= group_divider.item_with_width.count then
--							if group_divider.group_count < zone.content.group_count then
--								group_divider.on_pointer_motion (group_divider.group_count + 1)
--								zone.sizer.position_groups (group_divider.best_grouping)
--							end
--						end
--						debug ("docking")
--							print ("%Ngrouping at left")
--						end
--					end
				when {SD_DOCKING_MANAGER}.dock_right then
					if a_screen_x - screen_x > 0 then
						l_temp_group_count := group_count_by_width (a_screen_x - screen_x)
						if l_temp_group_count /= last_group_count then
							group_divider.on_pointer_motion (l_temp_group_count)
							zone.sizer.position_groups (group_divider.best_grouping)
							last_group_count := l_temp_group_count
						end
					end
				when {SD_DOCKING_MANAGER}.dock_top then
					if (screen_y + height) - a_screen_y > minimum_height then
--						set_height ((screen_y + height) - a_screen_y)
--						set_y_position (a_screen_y)
					end
				when {SD_DOCKING_MANAGER}.dock_bottom then
					if a_screen_y - screen_y > 0 then
						l_temp_group_count := group_count_by_height (a_screen_y - screen_y)
						if l_temp_group_count /= last_group_count then
							group_divider.on_pointer_motion (l_temp_group_count)
							zone.sizer.position_groups (group_divider.best_grouping)
							last_group_count := l_temp_group_count
						end
--						set_height (a_screen_y - screen_y)
					end
				end
			end
		end

	group_count_by_height (a_pointer_height: INTEGER): INTEGER is
			-- Group count base on a_pointer_height.
		require
			valid: a_pointer_height > 0
		do
			Result := a_pointer_height // one_group_height
			if Result > content.item_count_except_separator then
				Result := content.item_count_except_separator
			elseif Result = 0 then
				Result := 1
			end
		ensure
			valid: 0 < Result and Result <= content.item_count_except_separator
		end

	group_count_by_width (a_pointer_width: INTEGER): INTEGER is
			-- Group count base on a_pointer_width.
		require
			valid: a_pointer_width > 0
		local
			l_before: INTEGER
		do
			from
				all_group_width.start
			until
				all_group_width.after or Result /= 0
			loop
				if all_group_width.index + 1 <= all_group_width.count then
					l_before := all_group_width.i_th (all_group_width.index + 1)
					if l_before < a_pointer_width and a_pointer_width <= all_group_width.item then
						Result := all_group_width.index
					end
				else
					Result := content.group_count
				end

				debug ("docking")
					print ("%NSD_FLOATING_MENU_ZONE group_count_by_width comparing : Pointer width: " + a_pointer_width.out + " VS all_group_width.item: " + all_group_width.item.out + " ( index is: " + all_group_width.index.out + " ) ")
				end
				all_group_width.forth
			end
			if a_pointer_width >= all_group_width.first then
				Result := 1
			end
			debug ("docking")
				print ("%NSD_FLOATING_MENU_ZONE group_count_by_width Result is:" + Result.out)
			end
		ensure
			valid: 0 < Result and Result <= content.group_count
		end

	last_group_count: INTEGER

	all_group_width: ARRAYED_LIST [INTEGER]
			-- All possible group width.

	one_group_height: INTEGER
			-- One group height.

	on_border_pointer_motion_no_capture (a_x, a_y: INTEGER) is
			-- Handle pointer motion actions when no has capture.
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

	extend_menu_items is
			-- Extend menu items, call by `extend'.
		require
			not_void: content /= Void
		local
			l_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
		do
			l_items := content.menu_items
			create internal_menu_box
			internal_padding_box.extend (internal_menu_box)
			create internal_menu_item_box
			internal_menu_box.extend (internal_menu_item_box)
			from
				l_items.start
			until
				l_items.after
			loop
				if l_items.item.parent /= Void then
					l_items.item.parent.prune (l_items.item)
				end
				extend_one_item (l_items.item)
				l_items.forth
			end
		end

	internal_pointer_direction: INTEGER
			-- Pointer direction, one value of SD_DOCKING_MANAGER dock_top, dock_bottom, dock_left, dock_right.

feature {NONE} -- Implementation

	group_divider: SD_MENU_GROUP_DIVIDER
			-- Divider to divide menu groups.

	internal_title_bar: SD_MENU_TITLE_BAR
			-- Title bar

	internal_border_box: EV_BOX
			-- Border box surround target menu.

	internal_padding_box: EV_VERTICAL_BOX
			-- Box to show padding.

	internal_menu_box: EV_VERTICAL_BOX
			-- Box in `internal_padding_box', it contain `internal_menu_item_box'.

	internal_menu_item_box: EV_HORIZONTAL_BOX
			-- Box contain menu items.

	internal_border_width: INTEGER is 2
			-- Border width.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

	internal_shared: SD_SHARED
			-- All singletons.

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
