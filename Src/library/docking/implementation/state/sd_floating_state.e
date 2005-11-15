indexing
	description: "Objects that remember resotre information when floating."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FLOATING_STATE

inherit
	SD_STATE
		redefine
			change_zone_split_area,
			stick_window,
			move_to_docking_zone,
			move_to_tab_zone,
			content_void
		end

create
	make

feature {NONE} -- Initlization
	make (a_screen_x, a_screen_y: INTEGER) is
			-- Creation method.
		require

		do
			create internal_shared
			create internal_zone.make (Current)

			internal_zone.show
			internal_zone.set_size (internal_shared.default_floating_window_width, internal_shared.default_floating_window_height)
			internal_zone.set_position (a_screen_x, a_screen_y)
			internal_shared.docking_manager.add_inner_container (internal_zone.inner_container)
		end

feature

	inner_container: SD_MULTI_DOCK_AREA is
			--
		do
			Result := internal_zone.inner_container
		end

	update_title_bar is
			--
		do
			internal_zone.update_title_bar
		end

feature -- Perform Restore
	restore (titles: ARRAYED_LIST [STRING]; a_container: EV_CONTAINER) is
			--
		do
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			--
		local
--			l_old_widget: EV_WIDGET
			l_docking_state: SD_DOCKING_STATE
			l_width_height: INTEGER
			l_widget: EV_WIDGET
			l_split_area: EV_SPLIT_AREA
			l_main_container_widget: EV_WIDGET
		do
			internal_shared.docking_manager.lock_update

			-- FIXIT: shoudl prune the SD_MULTI_DOCK_AREA here.
--			internal_shared.docking_manager.prune_zone (internal_zone)
			l_widget := internal_zone.inner_container.item
			internal_zone.inner_container.wipe_out
			internal_zone.destroy
			if 	internal_direction	= {SD_DOCKING_MANAGER}.dock_left or internal_direction = {SD_DOCKING_MANAGER}.dock_right then
				l_width_height := (a_multi_dock_area.width * internal_shared.default_docking_width_rate).ceiling
				l_split_area := create {EV_HORIZONTAL_SPLIT_AREA}
			else
				l_width_height := (a_multi_dock_area.height * internal_shared.default_docking_height_rate).ceiling
				l_split_area := create {EV_VERTICAL_SPLIT_AREA}
			end
--			create l_docking_state.make (internal_content, internal_direction, l_width_height)
--			l_docking_state.dock_at_top_level (a_multi_dock_area)
--			change_state (l_docking_state)
			l_main_container_widget := internal_shared.docking_manager.inner_container_main.item
			internal_shared.docking_manager.inner_container_main.save_spliter_position (l_main_container_widget)
			internal_shared.docking_manager.inner_container_main.wipe_out
			internal_shared.docking_manager.inner_container_main.extend (l_split_area)
			if internal_direction = {SD_DOCKING_MANAGER}.dock_left or internal_direction = {SD_DOCKING_MANAGER}.dock_top then
				l_split_area.set_first (l_widget)
				l_split_area.set_second (l_main_container_widget)
				if l_width_height >= l_split_area.minimum_split_position and l_width_height <= l_split_area.maximum_split_position then
					l_split_area.set_split_position (l_width_height)
				end

			else
				l_split_area.set_second (l_widget)
				l_split_area.set_first (l_main_container_widget)
				if l_width_height >= l_split_area.minimum_split_position and l_width_height <= l_split_area.maximum_split_position then
					l_split_area.set_split_position (l_split_area.maximum_split_position - l_width_height)
				end
			end

			internal_shared.docking_manager.inner_container_main.restore_spliter_position (l_main_container_widget)
			internal_shared.docking_manager.unlock_update
		end

	record_state is
			--
		do

		end

feature -- States report

	content_void: BOOLEAN is
			--
		do
			Result := not internal_zone.inner_container.readable
		end

feature {NONE} -- Implementation

	internal_zone: SD_FLOATING_ZONE

	on_close_window is
			-- Handle user clicked the close button on the floating window.
		do

		end

	on_move_window (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle user drag the window.
		do

		end

	stick_window (a_direction: INTEGER) is
			--
		do
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			-- Change `Current' to a docking zone.
		local
			l_zone: SD_ZONE
			l_current_item: EV_WIDGET
		do
			l_current_item := inner_container.item
			l_zone ?= l_current_item
			if l_zone /= Void then
				l_zone.state.change_zone_split_area (a_target_zone, a_direction)
			else
				change_zone_split_area_whole_content (a_target_zone, a_direction)
			end

			internal_zone.destroy
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE) is
			--
		local
--			l_tab_state: SD_TAB_STATE
			l_zone: SD_ZONE
		do
			internal_shared.docking_manager.lock_update

--			internal_shared.docking_manager.prune_zone (internal_zone)
			internal_zone.destroy

			l_zone ?= inner_container.item
			if l_zone /= Void then
				l_zone.state.move_to_docking_zone (a_target_zone)
			end



			internal_shared.docking_manager.unlock_update
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE) is
			--
		local
			l_tab_state: SD_TAB_STATE
		do
			internal_shared.docking_manager.lock_update

			-- FIXIT: shoudl prune the SD_MULTI_DOCK_AREA here.
--			internal_shared.docking_manager.prune_zone (internal_zone)
			internal_zone.destroy
			create l_tab_state.make_with_tab_zone (internal_content, a_target_zone)
--			l_tab_state.dock_at_top_level
			change_state (l_tab_state)
			internal_shared.docking_manager.unlock_update
		end

feature {NONE} -- Implementation


	change_zone_split_area_whole_content (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			--
		local
			l_container: EV_CONTAINER
			l_widget: EV_WIDGET
			l_spliter: EV_SPLIT_AREA
			l_current_item: EV_SPLIT_AREA
			l_target_split: EV_SPLIT_AREA
			l_target_split_position: INTEGER
		do
			l_current_item ?= inner_container.item
			check l_current_item /= Void end
			inner_container.save_spliter_position (l_current_item)
			l_widget ?= a_target_zone
			check l_widget /= Void end
			l_container ?= l_widget.parent
			check l_container /= Void end

			l_target_split ?= l_container
			if l_target_split /= Void then
				l_target_split_position := l_target_split.split_position
			end


			l_container.prune_all (l_widget)

			inner_container.wipe_out

			if a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right then
				l_spliter := create {EV_HORIZONTAL_SPLIT_AREA}
			else
				l_spliter := create {EV_VERTICAL_SPLIT_AREA}
			end

			if a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_top then
				l_spliter.set_first (l_current_item)
				l_spliter.set_second (l_widget)
			else
				l_spliter.set_first (l_widget)
				l_spliter.set_second (l_current_item)
			end

			l_container.extend (l_spliter)
			if l_target_split /= Void then
				l_target_split.set_split_position (l_target_split_position)
			end
			l_spliter.set_proportion (0.5)
			inner_container.restore_spliter_position (l_current_item)
		end

--	move_to_docking_zone_imp (a_target_zone: SD_DOCKING_ZONE; a_direction: INTEGER) is
--			--
--		local
--			l_old_zone_width_height: INTEGER
--			l_old_width, l_old_height: INTEGER
--			l_docking_state: SD_DOCKING_STATE
--			l_zone: SD_ZONE
--		do
--			-- First, remove current zone from old parent split area.
--			l_old_width := internal_zone.width
--			l_old_height := internal_zone.height
--			-- FIXIT: should prune the SD_MULTI_DOCK_AREA here.
----			internal_shared.docking_manager.prune_zone (v)
--			internal_shared.docking_manager.prune_inner_container (inner_container)
--
--			if a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right then
--				l_old_zone_width_height := l_old_width
--			else
--				l_old_zone_width_height := l_old_height
--			end




--			create l_docking_state.make (internal_content, a_direction, l_old_zone_width_height)
--			change_state (l_docking_state)
--			l_docking_state.change_zone_split_area (a_target_zone, a_direction)
--
--			internal_zone.destroy
--		end
feature {SD_DOCKING_MANAGER}
--	xml_element (node: XM_ELEMENT) is
--		do
--		end
feature -- Properties
	zone: SD_ZONE is
			--
		do
--			Result := internal_zone
		end

end
