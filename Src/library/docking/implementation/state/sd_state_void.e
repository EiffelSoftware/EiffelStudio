indexing
	description: "SD_STATE when a content initialized, wait for change to other SD_STATE."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_STATE_VOID

inherit
	SD_STATE

	redefine
		dock_at_top_level,
		change_zone_split_area,
		stick_window,
		float_window,
		move_to_tab_zone,
		move_to_docking_zone
	end

create
	make

feature {NONE}  -- Initlization

	make (a_content: SD_CONTENT)is
			-- Creation method.
		require
			a_content_not_void: a_content /= Void
		do
			direction := {SD_DOCKING_MANAGER}.dock_left
			internal_content := a_content
			create internal_shared
		ensure
			set: a_content = internal_content
		end

feature -- Redefine.

	zone: SD_ZONE is
			-- Redefine.
		do
		end

	restore (titles: ARRAYED_LIST [STRING]; a_container: EV_CONTAINER; a_direction: INTEGER) is
			-- Redefine.
		do
		end

	record_state is
			-- Redefine.
		do
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Redefine.
		local
			l_docking_state: SD_DOCKING_STATE
		do
			internal_shared.docking_manager.lock_update
			if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right then
				create l_docking_state.make (internal_content, direction, (internal_shared.docking_manager.container_rectangle.width * internal_shared.default_docking_width_rate).ceiling)
			else
				create l_docking_state.make (internal_content, direction, (internal_shared.docking_manager.container_rectangle.height * internal_shared.default_docking_height_rate).ceiling)
			end
			l_docking_state.dock_at_top_level (a_multi_dock_area)
			change_state (l_docking_state)
			internal_shared.docking_manager.unlock_update
		ensure then
			state_changed: internal_content.state /= Current
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			-- Redefine.
		local
			l_docking_state: SD_DOCKING_STATE
		do
			internal_shared.docking_manager.lock_update
			create l_docking_state.make (internal_content, a_direction, 0)
			l_docking_state.change_zone_split_area (a_target_zone, a_direction)
			change_state (l_docking_state)
			internal_shared.docking_manager.unlock_update
		ensure then
			state_changed: internal_content.state /= Current
		end

	stick_window (a_direction: INTEGER) is
			-- Redefine.
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
		do
			internal_shared.docking_manager.lock_update
			create l_auto_hide_state.make (internal_content, a_direction)
			change_state (l_auto_hide_state)
			internal_shared.docking_manager.unlock_update
		ensure then
			state_changed: internal_content.state /= Current
		end

	float_window (a_x, a_y: INTEGER) is
			-- Redefine.
		local
			l_docking_state: SD_DOCKING_STATE
			l_floating_state: SD_FLOATING_STATE
		do
			internal_shared.docking_manager.lock_update
			create l_floating_state.make (a_x, a_y)
			create l_docking_state.make (internal_content, direction, 0)
			l_docking_state.dock_at_top_level (l_floating_state.inner_container)
			change_state (l_docking_state)
			internal_shared.docking_manager.unlock_update
		ensure then
			state_changed: internal_content.state /= Current
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE) is
			-- Redefine.
		local
			l_tab_state: SD_TAB_STATE
		do
			internal_shared.docking_manager.lock_update
			create l_tab_state.make_with_tab_zone (internal_content, a_target_zone, direction)
			change_state (l_tab_state)
			internal_shared.docking_manager.unlock_update
		ensure then
			state_changed: internal_content.state /= Current
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE) is
			-- Redefine.
		local
			l_tab_state: SD_TAB_STATE
		do
			internal_shared.docking_manager.lock_update
			create l_tab_state.make (internal_content, a_target_zone, direction)
			l_tab_state.set_direction (a_target_zone.state.direction)
			change_state (l_tab_state)
			internal_shared.docking_manager.unlock_update
		ensure then
			state_changed: internal_content.state /= Current
		end

invariant

	direction_valid: direction = {SD_DOCKING_MANAGER}.dock_top or direction = {SD_DOCKING_MANAGER}.dock_bottom
		or direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right

end
