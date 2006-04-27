indexing
	description: "Store tool bar zone state."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_ZONE_STATE

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method
		do
		end

feature -- Properties which record information in one row.

	size: INTEGER
			-- SD_TOOL_BAR_ZONE size

	set_size (a_size: INTEGER) is
			-- Set `size'
		require
			valid: a_size >= 0
		do
			size := a_size
		ensure
			set: size = a_size
		end

	position: INTEGER
			-- SD_TOOL_BAR_ZONE position in its parent row.

	set_position (a_position: INTEGER) is
			-- Set `position'
		require
			valid: a_position >= 0
		do
			position := a_position
		ensure
			set: position = a_position
		end

	is_only_zone: BOOLEAN
			-- When docking, if there is only one SD_T0OL_BAR_ZONE in SD_TOOL_BAR_ROW?

	set_is_only_zone (a_only_zone: BOOLEAN) is
			-- Set `is_only_zone'
		do
			is_only_zone := a_only_zone
		ensure
			set: is_only_zone = a_only_zone
		end

feature -- Propertites which record row infomations.

	container_direction: INTEGER
			-- Tool bar container direction.
			-- One value of {SD_DOCKING_MANAGER}.dock_top, dock_bottom, dock_left, dock_right.

	set_container_direction (a_direction: INTEGER) is
			-- Set `container_direction'
		require
			valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		do
			container_direction := a_direction
		ensure
			set: container_direction = a_direction
		end

	container_row_number: INTEGER
			-- Which row SD_TOOL_BAR_ZONE is in?

	set_container_row_number (a_row_number: INTEGER) is
			-- Set `container_row_number'
		require
			valid: a_row_number > 0
		do
			container_row_number := a_row_number
		ensure
			set: container_row_number = a_row_number
		end

feature -- Properties which record floating informations.

	screen_x: INTEGER is
			-- `internal_screen_x'
		local
			l_screen: EV_SCREEN
		do
			if is_screen_position_set then
				Result := internal_screen_x
			else
				create l_screen
				Result := l_screen.pointer_position.x
			end

		end

	screen_y: INTEGER is
			-- 'internal_screen_y'
		local
			l_screen: EV_SCREEN
		do
			if is_screen_position_set then
				Result := internal_screen_y
			else
				create l_screen
				Result := l_screen.pointer_position.y
			end
		end

	set_screen_x (a_screen_x: INTEGER) is
			-- Set `screen_x'
		do
			internal_screen_x := a_screen_x
			is_screen_position_set := True
		ensure
			set: internal_screen_x = a_screen_x
			set: is_screen_position_set = True
		end

	set_screen_y (a_screen_y: INTEGER) is
			-- Set `screen_y'
		do
			internal_screen_y := a_screen_y
			is_screen_position_set := True
		ensure
			set: internal_screen_y = a_screen_y
			set: is_screen_position_set = True
		end

	floating_group_info: SD_TOOL_BAR_GROUP_INFO
			-- How items positioned when floating?

	set_floating_group_info (a_group_info: SD_TOOL_BAR_GROUP_INFO) is
			-- Set `row_count'
		require
			not_void: a_group_info /= Void
		do
			floating_group_info := a_group_info
		ensure
			set: floating_group_info = a_group_info
		end

feature -- Items layout

	set_items_layout (a_layout: like items_layout) is
			-- Set `a_layout'
		require
			not_void: a_layout /= Void
		do
			items_layout := a_layout
		ensure
			set: items_layout = a_layout
		end

	items_layout: ARRAYED_LIST [TUPLE [STRING, BOOLEAN]]
			-- Items layout, first is item name, second is whether item `is_displayed'
			-- Order of this list, it's order items displayed.

feature {NONE} -- Implementation

	internal_screen_x, internal_screen_y: INTEGER
			-- Floating screen position.

	is_screen_position_set: BOOLEAN
			-- If already setted `internal_screen_x' and `internal_screen_y'?
end
