indexing
	description: "State used when a content initialized."
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
			--
		require
			a_content_not_void: a_content /= Void
		do
			internal_content := a_content
			create internal_shared
		ensure
			set: a_content = internal_content
		end

feature -- Access

	zone: SD_ZONE is
			--
		do

		end

	restore (a_content: SD_CONTENT; a_container: EV_CONTAINER) is
			--
		do

		end

	record_state is
			--
		do

		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			--
		local
			l_docking_state: SD_DOCKING_STATE
		do
			internal_shared.docking_manager.lock_update
			if internal_direction = {SD_DOCKING_MANAGER}.dock_left or internal_direction = {SD_DOCKING_MANAGER}.dock_right then
				create l_docking_state.make (internal_content, internal_direction, (internal_shared.docking_manager.container_rectangle.width * internal_shared.default_docking_width_rate).ceiling)
			else
				create l_docking_state.make (internal_content, internal_direction, (internal_shared.docking_manager.container_rectangle.height * internal_shared.default_docking_height_rate).ceiling)
			end
			l_docking_state.dock_at_top_level (a_multi_dock_area)
			change_state (l_docking_state)
			internal_shared.docking_manager.unlock_update
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			--
		local
			l_docking_state: SD_DOCKING_STATE
		do
			internal_shared.docking_manager.lock_update
			create l_docking_state.make (internal_content, a_direction, 0)
			l_docking_state.change_zone_split_area (a_target_zone, a_direction)
			change_state (l_docking_state)
			internal_shared.docking_manager.unlock_update
		end

	stick_window (a_direction: INTEGER) is
			--
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
		do
			internal_shared.docking_manager.lock_update
			create l_auto_hide_state.make (internal_content, a_direction)
			change_state (l_auto_hide_state)
			internal_shared.docking_manager.unlock_update
		end

	float_window (a_x, a_y: INTEGER) is
			--
		local
			l_docking_state: SD_DOCKING_STATE
			l_floating_state: SD_FLOATING_STATE
		do
			internal_shared.docking_manager.lock_update
			create l_floating_state.make (a_x, a_y)
			create l_docking_state.make (internal_content, {SD_DOCKING_MANAGER}.dock_left, 0)
			l_docking_state.dock_at_top_level (l_floating_state.inner_container)
			change_state (l_docking_state)
			internal_shared.docking_manager.unlock_update
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE) is
			--
		local
			l_tab_state: SD_TAB_STATE
		do
			internal_shared.docking_manager.lock_update
			create l_tab_state.make_with_tab_zone (internal_content, a_target_zone)
			change_state (l_tab_state)
			internal_shared.docking_manager.unlock_update
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE) is
			--
		local
			l_tab_state: SD_TAB_STATE
		do
			internal_shared.docking_manager.lock_update
			create l_tab_state.make (internal_content, a_target_zone)
			change_state (l_tab_state)
			internal_shared.docking_manager.unlock_update
		end

feature {NONE} -- Implementation

invariant


end
